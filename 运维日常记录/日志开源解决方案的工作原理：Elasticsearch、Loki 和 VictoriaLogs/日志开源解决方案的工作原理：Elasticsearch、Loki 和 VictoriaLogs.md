### 关于日志系统的存储与查询：Elasticsearch、OpenSearch、Loki 和 VictoriaLogs

如果你在使用 Elasticsearch、OpenSearch、Loki 或 VictoriaLogs，并且对系统需要大量内存或全文搜索查询速度很慢感到困惑，那么这篇文章可能会引起你的兴趣。

#### 日志定义
假设典型的 Kubernetes 日志包含许多日志字段（通常由 Fluentbit 传输），这些日志被摄取到集中式日志数据库中，例如：

```json
{
  "@timestamp": "2024-10-18T21:11:52.237412Z",
  "message": "error details: name = ErrorInfo reason = IAM_PERMISSION_DENIED domain = iam.googleapis.com metadata = map[permission:logging.logEntries.create]",
  "kubernetes_annotations.EnableNodeJournal": "false",
  "kubernetes_annotations.EnablePodSecurityPolicy": "false",
  "kubernetes_annotations.SystemOnlyLogging": "false",
  "kubernetes_annotations.components.gke.io/component-name": "fluentbit",
  "kubernetes_annotations.components.gke.io/component-version": "1.30.2-gke.3",
  "kubernetes_annotations.monitoring.gke.io/path": "/api/v1/metrics/prometheus",
  "kubernetes_container_hash": "gke.gcr.io/fluent-bit-gke-exporter@sha256:0ef2fab2719444d5b5b0817cf4512f24a347c521d9db9c5e3f85eb4fdcf9a187",
  "kubernetes_container_image": "sha256:81082ddf27934f981642f2d8e615f763cc15c08414baa0e908a674ccb116dfcb",
  "kubernetes_container_name": "fluentbit",
  "kubernetes_docker_id": "f39c349b5368b3abde7c22f97f3f8547c202228e725bb5ef620f399e2a5e67af",
  "kubernetes_host": "gke-sandbox-sandbox-pool-4cpu-b-4dc82194-l0an",
  "kubernetes_labels.component": "fluentbit-gke",
  "kubernetes_labels.controller-revision-hash": "68cfcc69c",
  "kubernetes_labels.k8s-app": "fluentbit-gke",
  "kubernetes_labels.kubernetes.io/cluster-service": "true",
  "kubernetes_labels.pod-template-generation": "24",
  "kubernetes_namespace_name": "kube-system",
  "kubernetes_pod_id": "7d75e660-9fcf-4b6a-b860-210293b5eda6",
  "kubernetes_pod_name": "fluentbit-gke-jt7wb",
  "stream": "stderr"
}
```

这些日志包含以下字段：

- `@timestamp`：日志生成的时间
- `message`：纯文本日志信息
- 各种 Kubernetes 特定字段，用于标识给定日志条目的源容器

典型的日志条目长度为 1KiB-2KiB。

### Elasticsearch 是如何存储和查询日志的？
Elasticsearch 为每个摄取的日志条目分配一个唯一 ID（这可能是存储纯日志条目的文件中的偏移量）。然后，它将每个日志字段拆分为多个词。例如，`message` 字段的值 `error details: name = ErrorInfo` 被拆分为 `error`、`details`、`name` 和 `ErrorInfo` 四个词（即 tokens）。然后，它将这些 tokens 持久化到倒排索引中，即从（字段名；token）到日志条目 ID 的映射。例如，上述 `message` 字段被转换为倒排索引中的四个条目：

- `(message; error) -> ID`
- `(message; details) -> ID`
- `(message; name) -> ID`
- `(message; ErrorInfo) -> ID`

典型的 token 长度大约为 5-10 字节。这样我们可以估计，Elasticsearch 需要为每个 1KiB 长度的日志条目创建大约 125 个倒排索引条目。因此，对于每个 1KiB 的日志条目，Elasticsearch 为 10亿 个日志条目创建了 1250亿 个倒排索引条目。相同的（字段名；token）对的倒排索引条目通常以一种称为 postings 的紧凑形式存储：

- `(字段名；token) -> [ID_1, ID_2, … ID_N]`

例如，所有字段 `kubernetes_container_name=fluentbit` 的 token 最终被压缩到一个倒排索引条目中：

- `(kubernetes_container_name; fluentbit) -> [ID_1, ID_2, … ID_N]`

如果这样的日志数量等于 1.25 亿，那么 [ID_1, ID_2, … ID_N] 列表包含 1.25 亿 个条目。每个 ID 通常是一个 64 位整数，因此 1.25 亿 个条目占用 1.25 亿 * 8 字节 = 1GB。

因此，存储 1 亿 个 1KiB 日志的倒排索引大小至少等于 10亿 * 125 * 8 字节 = 1TB（不包括（字段名；token）对所需的存储空间）。Elasticsearch 还需要存储原始日志，以便在查询结果中显示。1 亿 个 1KiB 日志需要 10亿 * 1KiB = 1TiB 的存储空间。因此，总需要的存储空间等于 1TB + 1TiB = 2TiB。Elasticsearch 可能会通过 Roaring bitmaps 压缩倒排索引。它也可能压缩原始日志。这可能会将所需的磁盘空间减少几倍，但仍然非常大。

Elasticsearch 使用倒排索引进行快速全文搜索。当你在某个字段中搜索某个词（即 token）时，它会立即通过在按（字段名；token）排序的 postings 上进行二分搜索来定位（字段名；token）对的 postings，然后根据它们的 ID 从存储中一一读取原始日志条目。这就是为什么 Elasticsearch 在全文搜索方面表现如此出色的原因！

### 查询 Elasticsearch 日志的缺点？
是的，有以下缺点：

1. **大量日志字段值查询**：当你搜索在大量日志中出现的某个字段值时，Elasticsearch 需要在查询过程中读取大量 postings。例如，如果你搜索字段 `kubernetes_container_name=fluentbit` 的日志，而该字段存在于 1.25 亿 个日志中，那么 Elasticsearch 需要读取 1.25 亿 * 8 字节 = 1GiB 的 8 字节日志 ID。这种查询可能非常慢。或者，为了稍微提高性能，所有需要的 postings 缓存在 RAM 中时，它们可能需要大量 RAM。这种情况在 Elasticsearch 的典型生产设置中非常常见。

2. **返回日志过多**：当查询返回的日志过多时，Elasticsearch 可能需要从存储的随机位置读取这些日志。这在低 IOPS 存储系统上可能非常慢。例如，一个典型的 HDD 每秒提供 100-200 次随机读取操作。这意味着，如果这些日志未缓存到 RAM 中，Elasticsearch 可能需要 10K 日志 / 100 IOPS = 100 秒来读取和返回 10K 个匹配日志。

### 总结
- **Elasticsearch 的优势**：Elasticsearch 通过倒排索引提供了出色的全文搜索性能。
- **存储需求**：Elasticsearch 需要大量存储空间来处理中等和大规模日志（例如超过 1TB）。
- **内存需求**：Elasticsearch 需要大量 RAM 来以合理的速度查询中等和大规模日志（例如超过 1TB）。

### Grafana Loki 的日志存储与查询机制

Grafana Loki 是一个为日志设计的集中式系统，旨在高效存储和查询日志数据。它的工作机制与其他日志系统，如 Elasticsearch，有显著的不同。

#### 日志流标签集
Loki 将所有日志字段（除了 `message` 和 `@timestamp`）进行排序，并构建一个日志流标签集，例如：

```json
{
  kubernetes_annotations.EnableNodeJournal="false",
  kubernetes_annotations.EnablePodSecurityPolicy="false",
  kubernetes_annotations.SystemOnlyLogging="false",
  kubernetes_annotations.components.gke.io/component-name="fluentbit",
  kubernetes_annotations.components.gke.io/component-version="1.30.2-gke.3",
  kubernetes_annotations.monitoring.gke.io/path="/api/v1/metrics/prometheus",
  kubernetes_container_hash="gke.gcr.io/fluent-bit-gke-exporter@sha256:0ef2fab2719444d5b5b0817cf4512f24a347c521d9db9c5e3f85eb4fdcf9a187",
  kubernetes_container_image="sha256:81082ddf27934f981642f2d8e615f763cc15c08414baa0e908a674ccb116dfcb",
  kubernetes_container_name="fluentbit",
  kubernetes_docker_id="f39c349b5368b3abde7c22f97f3f8547c202228e725bb5ef620f399e2a5e67af",
  kubernetes_host="gke-sandbox-sandbox-pool-4cpu-b-4dc82194-l0an",
  kubernetes_labels.component="fluentbit-gke",
  kubernetes_labels.controller-revision-hash="68cfcc69c",
  kubernetes_labels.k8s-app="fluentbit-gke",
  kubernetes_labels.kubernetes.io/cluster-service="true",
  kubernetes_labels.pod-template-generation="24",
  kubernetes_namespace_name="kube-system",
  kubernetes_pod_id="7d75e660-9fcf-4b6a-b860-210293b5eda6",
  kubernetes_pod_name="fluentbit-gke-jt7wb",
  stream="stderr"
}
```

这个标签集唯一标识了从单一来源接收的一组日志（在这个例子中是 Kubernetes 容器）。Loki 仅为每个日志流存储一次这个标签集，并将其放入倒排索引中，以便快速定位匹配的日志流。与 Elasticsearch 不同，Loki 的倒排索引非常小，因为它包含的是每个日志流的条目，而不是每个日志的条目。通常日志流的数量相对较少（例如几百万个日志流，而不是几十亿个日志条目）。

#### 日志存储与压缩
Loki 将所有 `message` 字段按日志流分组，并按 `@timestamp` 排序，然后以压缩形式存储到持久化存储中。按流分组的日志消息可以提高压缩比率，因为每个日志流通常包含相似的日志。这样，Loki 在典型的生产案例中可以提供 5x-10x 的压缩比率。例如，10亿条 1KiB 的日志可能只占用 100GiB 的存储空间。

这种分组和压缩方式显著减少了存储空间需求，并且相比于 Elasticsearch，Loki 需要更少的 RAM，因为倒排索引更小，保持在 RAM 中以获得良好的查询性能也更容易。

### Loki 的优缺点

#### 优点：
- **存储效率高**：Loki 所需的存储空间比 Elasticsearch 少 10 倍，尤其适合需要扫描大量存储日志的重查询。
- **内存占用低**：由于较小的倒排索引，Loki 的内存需求也更低。

#### 缺点：
- **“大海捞针”查询性能差**：对于搜索独特的词或短语的大量日志，性能较差，因为它需要读取、解压缩并扫描所有日志消息。例如，搜索 `trace_id=7d75e660-9fcf-4b6a-b860-210293b5eda6`，Loki 可能需要扫描 1TiB 的数据，即使有良好的压缩比率，也需要读取大量数据。
- **高基数字段支持差**：对于包含大量唯一值的结构化日志（如 `user_id`、`trace_id`、`ip`），Loki 的支持很差。如果将这些字段存储在日志流标签集中，倒排索引会迅速膨胀，占用大量内存，并显著增加磁盘 IO，降低查询性能。

### 总结
Loki 是一种高效的日志存储和查询解决方案，适合处理和存储大量日志数据，但在某些情况下（如高基数字段或搜索独特词语时）其性能可能逊色于 Elasticsearch。然而，通过合理的使用场景和优化配置，Loki 可以显著降低存储和内存成本，是日志管理的一个有力工具。



## 关于victorialogs的实现原理

为了更高效地处理和查询海量日志数据，VictoriaLogs 采取了一些独特的方法。

#### 日志字段拆分与布隆过滤器
VictoriaLogs 会将每个日志字段拆分成多个词（即 tokens），类似于 Elasticsearch 的做法。然而，与 Elasticsearch 使用倒排索引不同，VictoriaLogs 使用布隆过滤器来处理这些 tokens。布隆过滤器的作用是快速跳过查询中不包含特定词的数据块。例如，当搜索某个唯一短语（如 `trace_id=7d75e660–9fcf-4b6a-b860-210293b5eda6`）时，大多数数据块会被直接跳过，只有少数数据块会被读取和检查，从而提高查询性能，特别是对于“大海捞针”类型的查询。

布隆过滤器只需要每个唯一 token 占用 2 字节，而 Elasticsearch 的倒排索引则需要至少 8 字节。由于唯一 token 的数量通常远小于总 token 数量，因此布隆过滤器的存储需求大约比倒排索引小 10 到 100 倍。这不仅减少了存储空间需求，还降低了数据摄取和查询时的内存占用，也减少了重查询期间的磁盘读取量。

#### 日志流的概念
VictoriaLogs 还引入了类似 Loki 的日志流概念，但默认情况下不会将日志字段放入日志流标签集中。相反，它依赖日志运输器通过 `_stream_fields` 查询参数或 `VL-Stream-Fields` HTTP 请求头提供的一组流日志字段。这样可以高效地存储和查询具有高基数字段（如 `user_id`, `trace_id` 或 `ip`）的结构化日志。

#### 列存储
VictoriaLogs 将每个日志字段的数据分组并存储在物理上独立的存储区域（类似于 ClickHouse 的列存储）。这极大地减少了查询过程中需要读取的数据量，因为只有所请求字段的数据会从存储中读取。此外，这种方式还能提高按字段压缩数据的比率，从而进一步减少存储空间需求。


### 综上所述

VictoriaLogs 通过使用布隆过滤器来提高全文搜索性能，同时保持低存储空间需求（最多比 Elasticsearch 少 15 倍）和低内存需求（最多比 Elasticsearch 少 30 倍）。虽然简单查询可能比 Elasticsearch 慢，但在处理包含多个过滤条件的复杂查询时，VictoriaLogs 通常表现优于 Elasticsearch。此外，VictoriaLogs 支持类似 Grafana Loki 的日志流，并使用列存储来进一步减少存储空间使用。这些特性使得 VictoriaLogs 成为处理和查询海量日志数据的高效工具。 

所有日志开源解决方案（Elasticsearch、Loki 和 VictoriaLogs）都有自己的优点和缺点。我尝试以清晰的方式解释这些解决方案如何存储和查询日志。我希望这些信息能帮助您选择适合您需求的正确解决方案。如有疑问，请尝试为您的特定工作负载同时运行多个解决方案，然后选择最佳解决方案。