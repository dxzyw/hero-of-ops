Kubernetes 初学者教程：56 个综合指南(持续完善中)

本篇文章是一个学习kubernetes的指导性文章，文章中会涉及你学习kubernetes过程中所需要掌握的大部分内容，本文持续更新。

如果您不熟悉Kubernetes，或者想要学习kubernetes，那么这篇文章会是一个不错的起点，文章中具体的内容细节点会跳转对应的文章，敬请期待。

这篇文章主要是用来引导了解基础知识，重点介绍 Kubernetes 对象以及您在 Kubernetes 实践中工作所需的基本工具。

主要涉及如下几点：

- 1. 对 Kubernetes 的需求
- 2. Kubernetes 架构和高可用性设置
- 3. 原生 Kubernetes 对象（Pod、部署、有状态副本集、作业等）
- 4. Kubernetes 监控和日志记录
- 5. Kubernetes 故障排除
- 6. Kubernetes 配置和密钥管理
- 7. Kubernetes 安全性
- 8. Kubernetes 生产力工具。
- 9. Kubernetes 认证指南

之前也有写过一篇完整的学习路线，可以作为参考：[如何学习kubernetes(附完整路线图及资源)](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247492529&idx=2&sn=c22b5a998381645de7f4de93a1056cde&chksm=fdb617adcac19ebb00bf721962b3dfaff2565ceb001ff6dbc6045043435398f324cfa2db9da8&token=316445105&lang=zh_CN#rd)


## 什么是 Kubernetes？

顾名思义，Kubernetes 或 k8s 是由云原生计算基金会维护的基于容器的应用程序的开源编排和集群管理。

Kubernetes （k8s） 官网说：

Kubernetes 是一个开源系统，用于自动化容器化应用程序的部署、扩展和管理。

它将组成应用程序的容器分组到逻辑单元中，以便于管理和发现。Kubernetes 建立在 Google 15 年运行生产工作负载的经验之上，并结合了社区的最佳想法和实践。

简而言之，Kubernetes 使管理多个主机上的容器变得容易。此外，它还使使用声明性 YAML 文件进行容器部署变得如此简单。

从而可以指定容器的部署方式，Kubernetes 会通过读取 YAML 中提供的信息来处理它。

根据 Splunk 的 Kubernetes 状况报告，96% 的组织正在使用或评估 Kubernetes，目前有 560 万开发人员正在使用 kubernetes。此外，在过去 5 年中，集装箱生产使用量增加了 300% 以上。



## 为什么我们需要 Kubernetes？

当涉及到 Kubernetes 或容器编排器时，第一个问题是我们为什么需要它。让我们从两个例子来理解它。

### 容器部署

假设有几个 Java 应用程序。

我们可以将其打包到容器中，并在包含 Docker 引擎或任何容器引擎的服务器上运行它。对于这种情况，没有复杂性。

使用 Dockerfile 将应用程序打包到 Docker 镜像中，并在主机上公开一个端口，让外部可以访问。

但问题在于它可能单点故障，因为它仅在单个服务器上运行。为了处理单点故障，我们需要一个有效的机制。

这就是为什么需要像 Kubernetes 这样的容器编排工具来按需扩展应用程序并承受单节点故障。

Kubernetes 有助于扩展应用程序、自我修复和滚动更新，使其非常适合运行容器。

### 微服务部署/编排

现在，假设有一个由微服务（API、UI、用户管理、信用卡交易系统等）组成的大型应用程序。所有这些微服务组件都必须使用 REST API 或其他协议相互通信。

由于应用程序有许多组件或微服务，因此我们无法将所有服务部署在一个服务器或容器中。应用程序必须解耦，每个微服务都应该自行部署和扩展。这使得应用程序开发和部署更轻松、更快速。

在这种情况下，复杂性在于网络、共享文件系统、负载均衡和服务发现。这就是 Kubernetes 的用武之地。它有助于以可管理的方式编排复杂的流程。

使用 Kubernetes，您只需要担心应用程序的开发和部署。

所有繁重的工作，如网络、跨节点的服务到服务通信、负载均衡、服务发现、资源调度、可扩展性和高可用性，都由 Kubernetes 负责。

总的来说，Kubernetes 可以帮助您实现以下目标。

- 1. 自动修复
- 2. 容器自动化调度
- 3. 水平和垂直扩缩容
- 3. 滚动应用程序升级和降级，零停机时间

## Kubernetes 初学者教程

为了开始使用 Kubernetes，所有 Kubernetes 初学者的教程按顺序分类到不同的部分。这是一个不断更新的的全面实用 Kubernetes 学习指南列表。

注意：Kubernetes 是一个开源工具，功能会不断更新。指南可能使用了旧版本的 API 或工作流，但情况会发生变化。我尽量保持所有指南的更新。如果有的话，如遇到任何问题，请发表评论，以便了解更新并进行相应的更改。

### Kubernetes 架构和高可用性

本节提供关于 Kubernetes 架构、设计、开发集群设置指南、云平台上的集群设置指南以及 Kubernetes 集群自动化的初学者教程。

[1.Kubernetes 架构解释](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247492422&idx=1&sn=8ab08e5567a649ce5942048a9749160b&chksm=fdb6175acac19e4c5973482203c39f88afb9dd0eb21e3c5f43607c024f6a573d1cb80ba2f52f&token=316445105&lang=zh_CN#rd)

[2.Kubernetes 高可用性解释](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247492780&idx=2&sn=35777ee2fc97a42a68bb452a9c1d075e&chksm=fdb610b0cac199a69bb076518f5bb8b46ed85a2a3b680d5e291c994c73ce708a3b1e313577d9&token=1005856225&lang=zh_CN#rd)

[3.Kubernetes 设计注意事项](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247492843&idx=2&sn=7bfd6e6a29b4ce920fbcf2f01d29346e&chksm=fdb610f7cac199e123ae029907d0b0c09601a146da71848d945b562a1d1e2bdd38cf2c4950ba&token=1123264028&lang=zh_CN#rd)

### Kubernetes 集群设置指南

在本节中，将学习如何在本地工作站和云平台上设置类似生产的多节点 Kubernetes 集群和开发集群。

我强烈建议大家使用以下教程设置自托管集群。它将为 Kubernetes 组件如何与集群中涉及的关键配置进行交互打下坚实的基础。

[4.Kubernetes Minikube 教程](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247492921&idx=2&sn=48a151e5b50fdaa6a0143c8602aab531&chksm=fdb61125cac19833bed2cf5a8a80a9f4a8ea3dd18da83ddb41e758b0dc73c1deead5fe0ff554&token=582551660&lang=zh_CN#rd)

[5.使用 Kubeadm 设置 Kubernetes 集群](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493046&idx=2&sn=152d327f15e6c1b4721c9b324455669f&chksm=fdb611aacac198bcffdb86d1099433031bbfeddcc4e6007fdee8183aee9664e0bfdbb954edf6&token=582551660&lang=zh_CN#rd)

[6.Kubeconfig 文件解释](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493100&idx=1&sn=8e8ebd8f0da6176dc7bde8d1dbd15698&chksm=fdb611f0cac198e641abb12ee00868ba8272558f5e8eb8d4387458df9dac9972e9d00f7283c4&token=1304546276&lang=zh_CN#rd)

[7.kubernetes集群配置文件](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493140&idx=2&sn=38def000e622e5d9a9f4018bc882abe7&chksm=fdb61208cac19b1e701bc9aa144e4d02abfcd76d1b931f2dcf3ade30cdd029ca6db1c2fbe2b0&token=1304546276&lang=zh_CN#rd)

[8.如何在 Vagrant VM 上启动 Kubernetes 集群](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493440&idx=2&sn=c4bb6c5eb0b355d058bdb8678090ba24&chksm=fdb6135ccac19a4a1fc5b09471a7cdd5a3b7b70376d9df6a938f96acf2b3b1b4640aec515c8d&token=1304546276&lang=zh_CN#rd)

### Kubectl 教程

使用 Kubernetes 集群时，kubectl 是与集互的重要命令。在本节中，我们将查看有效使用 kubectl 的教程。

[9.kubectl 设置上下文指南](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493474&idx=2&sn=201ccc90667df96a64446f9538320c73&chksm=fdb6137ecac19a686ecf9cd6006c09a84baa746e7acfc492e6416135877e10ac027594f6672f&token=1403121859&lang=zh_CN#rd)

### Kubernetes 备份和恢复教程

在本节中，我们将学习使用 Kubernetes 原生工具和其他开源和 cncf 相关工具进行 Kubernetes 备份和恢复。

[10.Etcd 备份和恢复：关于备份 etcd 和从备份中恢复它的详细指南](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493542&idx=2&sn=f050a3c152d18cd84fba52143aa2cc24&chksm=fdb613bacac19aacb30f673c192ee4b1456df45ef49550f3fcfd1956bcaaf76177fd8c78e1f9&token=1403121859&lang=zh_CN#rd)

### Kubernetes 原生资源教程

本节介绍有关 Kubernetes 原生资源的教程，如部署、Pod、Statefulset、RBAC、作业、入口等。

[11.Kubernetes Pod 解释：通过实际示例解释基本对象 pod](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493521&idx=2&sn=72b2fd0f266a739dc30b62d95aacf55d&chksm=fdb6138dcac19a9bb9b5db8f8c45e595f8675efdde3c7588d8d1dbaf0bf7f46e5942783422f3&token=1403121859&lang=zh_CN#rd)

[12.Pod 生命周期解释：有关 Pod 生命周期阶段的详细指南](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493541&idx=2&sn=e75a6789bda824f957d1a3c7f01e642c&chksm=fdb613b9cac19aafb3501c226367b4869bdd6a865e831e335fee386c705502559a05c956be08&token=1403121859&lang=zh_CN#rd)

[13.了解 init 容器：深入了解 init contianers](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493583&idx=2&sn=6814077c1360acc501a2b3a342f51cae&chksm=fdb613d3cac19ac504e4d8aad2bfc1f7e6b5dcdd616486ee3ddb5d9e8140c948e9e4426338de&token=1846056608&lang=zh_CN#rd)

[14.Kubernetes 初学者Deployment教程](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493657&idx=2&sn=2d9e86b7fb935882257c45c4f3a8c040&chksm=fdb61c05cac195136d15893cb86c9a4089ff6c38009b264a58c9d02285450e653fc599aea774&token=1846056608&lang=zh_CN#rd)

[15.Kubernetes Daemonset 解释](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493697&idx=2&sn=871cd0bc82ac7bd1a276b737ab1757d0&chksm=fdb61c5dcac1954b18a29ed6bd9927b6016cbc478a56a8039a0f0319c16d755798bda1648bcc&token=1830017738&lang=zh_CN#rd)

[16.如何为服务帐户创建 Kubernetes 角色](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493729&idx=2&sn=e0b87320b8bac286886b01a9a133c1fc&chksm=fdb61c7dcac1956b7c2482e87ed68c8d564ceb1d176a9ce227ae8593371fc08e9cd49676c10a&token=1830017738&lang=zh_CN#rd)

[17.如何创建用于 API 访问的 Kubernetes 服务帐户](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493988&idx=2&sn=6208dd5b9aac2f6dd1d5bb6e955fa898&chksm=fdb61d78cac1946e16c67fb66d7fb07c41fead739c77c55f67494f7c16b1d1b878e9c358ac6c&token=1600392871&lang=zh_CN#rd)

[18.面向初学者的 Kubernetes Ingress 教程](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493850&idx=2&sn=81d534a1ca4a121a7e367797436daf52&chksm=fdb61cc6cac195d087ccf2607b13de869364df2308fc62f49a60235caf712127d3646719f187&token=1830017738&lang=zh_CN#rd)

[19.如何使用 Nginx 控制器在 Kubernetes 上设置 Ingress](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493851&idx=2&sn=4891520a0b82420a2d64f1fff07fd208&chksm=fdb61cc7cac195d1d4d0a63adfbe5310f86e09322639fc213a9da9779db93ee5af21b08b0000&token=1830017738&lang=zh_CN#rd)

[20.如何为 Kubernetes Ingress 配置 SSL/TLS](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493885&idx=2&sn=07bf53ba9390539eb09cd13d02f1f99c&chksm=fdb61ce1cac195f7ff6917877428e31de166d7b315cef1fca641797e8506d9df35722fde667c&token=2055857181&lang=zh_CN#rd)

[21.如何创建 Kubernetes 作业/cron 作业](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493924&idx=2&sn=6ee7888815158f307aa1a6a03ee5e872&chksm=fdb61d38cac1942ebd40a707c9dd497335c7ceb5847fc57c35f4c96b259d570bf4d077b06346&token=2055857181&lang=zh_CN#rd)

[22.Kubernetes Pod PriorityClass 和 Preemption 解释](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247493951&idx=2&sn=8eb0d65c268c362f600260fed9d23701&chksm=fdb61d23cac194351f7b431bd05c54c68629acd31362f4f0ef6a8babb7033c92c05092b38544&token=1600392871&lang=zh_CN#rd)

### Kubernetes 生产力指南

[23.创建 Kubernetes YAML 的简单方法](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494035&idx=2&sn=088568a28d7caa1dc06d2e012d70a755&chksm=fdb61d8fcac194995289a47f03670cfc084b17bfb5f199aecf5676ba1e98ea3b2517a9d8547d&token=1600392871&lang=zh_CN#rd)


### Kubernetes 监控教程

本节重点介绍如何使用 Prometheus、Grafana、Alert Manager 等工具进行 Kubernetes 监控和日志记录。我们还将介绍与特定云提供商相关的日志记录和监控指南。

[24.如何在 Kubernetes 集群上设置 Prometheus 监控](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494086&idx=2&sn=a94b6aeafdd3fa019a76ff2952ff9408&chksm=fdb61ddacac194ccb781f402580a92bd41f776637f0156473634320a49a25d5f4296a45f1fe1&token=1600392871&lang=zh_CN#rd)

[25.在 Kubernetes 上设置 Prometheus Node Exporter](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494112&idx=2&sn=f0fbde5c26803f824a7066256db6dd67&chksm=fdb61dfccac194eaf1e37eb7f77d943eab2c800a785872a99ff49a1a0cced4f788175032ac1d&token=1600392871&lang=zh_CN#rd)

[26.在 Kubernetes 上设置 Kube 状态指标](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494132&idx=2&sn=42b6a2d07617192c595b28be6539c3ca&chksm=fdb61de8cac194fe5a6075c7cb2f873b5c333c69e6be51310094b19045b01ac648710207f34d&token=1600392871&lang=zh_CN#rd)

[27.在 Kubernetes 上设置警报管理器](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494165&idx=2&sn=115d7541fb471a6ba25e1caf7d414ea1&chksm=fdb61e09cac1971f41c4ff35687e092da94427f3695ec798dffc37f975d61105f5780d49e661&token=1600392871&lang=zh_CN#rd)

[28在 Kubernetes 上设置 grafana](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494234&idx=2&sn=1bae28a3de7e8f784d6302f1b9705a9f&chksm=fdb61e46cac19750fba5af344f870776d5b0d0efa839d02fd686fe01e4d14487205f271b116d&token=1094165661&lang=zh_CN#rd)

### Kubernetes 日志指南

本部分介绍有关 Kubernetes 日志记录的端到端初学者教程列表。

[29.Kubernetes 日志为初学者解释](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494199&idx=2&sn=482fc38e7180cf528087b3867c4db802&chksm=fdb61e2bcac1973d7a864ee43d4e5676a79a9f1b4ebcba0e1e9febe97eaa55f81c4f3f50473b&token=1600392871&lang=zh_CN#rd)：本教程详细介绍了 Kubernetes 日志的底层概念和模式。

[30.Kubernetes 上的 EFK 设置：解释 Kubernetes 上的 EFK 日志记录堆栈的分步指南。](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494362&idx=2&sn=3e1e03da8e4ae241a75cd7542b46ff83&chksm=fdb61ec6cac197d01e4dfc57c517b2f66b2a0eb60943801f18e682cdecebb870008920839b9b&token=1094165661&lang=zh_CN#rd)

[31.在 Kubernetes 上设置 Grafana Loki](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494402&idx=2&sn=6dcae74cee1a7d4b31e73eec11b958f9&chksm=fdb61f1ecac1960862e2b7b4b4ac3e0d61f846e59763b57c8be71bd7ab6d759f1968436b1f6a&token=1094165661&lang=zh_CN#rd)

### Kubernetes 故障排除教程

在本节中，我们将学习对 Kubernetes 对象（Pod、部署、有状态副本集、集群组件等）进行故障排除。

[32.如何对 Kubernetes Pod 进行故障排除](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494601&idx=2&sn=7943a1b909920bfdac20e1921542eca2&chksm=fdb61fd5cac196c3fa207f2a58649916af8ba2d1ffe0fd7f3e1bc748c86289a9e88175032b86&token=1094165661&lang=zh_CN#rd)

### Kubernetes 数据库教程

本节旨在介绍如何为 PostgreSQL、MongoDB 等数据库设置 Statefulsets 的教程。我们还将介绍 Kubernetes 数据库运算符，它们提供了额外的功能来管理 Kubernetes 上的数据库。

[33.了解如何部署 PostgreSQL Statefulset 集群](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494602&idx=2&sn=8a3765ee35c792131b2dbd22a02c8248&chksm=fdb61fd6cac196c00dc95c4541d86ea4dc7f2bc39a5c0acd0686f20b71ff5944c3a263ed38f2&token=1094165661&lang=zh_CN#rd)

[34.在 Kubernetes 上部署 MongoDB](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494603&idx=2&sn=b703ac837787c753148877286fc347f5&chksm=fdb61fd7cac196c1da282dc46a3a972821ebeeb3d86a98b0a8b35de47bf71ebca37d52955533&token=1094165661&lang=zh_CN#rd)

### Kubernetes 包管理教程

在 Kubernetes 包管理下，您将了解 Helm 和 Kustomize 等工具。Helm 是一个模板工具，Kustomize 是一个覆盖引擎。这些是组织用于管理 Kubernetes 部署的标准工具。

[35.如何安装 Helm 进行 Kubernetes 部署](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494604&idx=2&sn=1c3be8afddee45cae4952430b56ff601&chksm=fdb61fd0cac196c62d17d2bee7f8025722301e480d3259dab2f5fdd39353faf18084132773a4&token=1094165661&lang=zh_CN#rd)

[36.如何从头开始创建 Helm Chart](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494680&idx=2&sn=b90eb0b36364f7b25e79d2cd017845fa&chksm=fdb61804cac1911202ec0b962906340289e95da8d96f0ad13a0ea46ce66ee8c78e16a1f57d9f&token=1094165661&lang=zh_CN#rd)

[37.Kustomize 教程](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494701&idx=2&sn=9dc9b852339abbc7c5f1c2f87819ef77&chksm=fdb61831cac19127358b351be1bbab86eb4f77cbe483b4edc01ee8a69b3d2b3a8d7240b161ee&token=1094165661&lang=zh_CN#rd)

[38.Kuztomize Configmap 和密码生成器](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494734&idx=2&sn=db17a96823c8078ee0ff8f7918fffce2&chksm=fdb61852cac1914456c436edee2d62ff7c3ee82e8e1810336ba13b24dc13f90dfd8cc7413509&token=1094165661&lang=zh_CN#rd)

### Kubernetes CI/CD 教程

在 Kubernetes CI/CD 下，您将学习使用常用的 CI/CD 工具（如 Jenkins）和高级 GitOps Operator（如 ArgoCD、FluxCD 等）。

[39.在 Kubernetes 集群上设置 Jenkins](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494779&idx=2&sn=35faea15aaf29448fec78217e8d8a187&chksm=fdb61867cac1917153f9be4cf1353a0563ab0fcdf0459c1f94831999e23e59f680bf5e469089&token=1094165661&lang=zh_CN#rd)

[40.在Kubernetes Pod 上设置 Jenkins 构建代理](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494870&idx=2&sn=45057a7627d3e6e66101d45799f37a29&chksm=fdb618cacac191dcce952a6374ca397cc3d705ffa9ab06d51994a47043c00d9e999b3b4b5c10&token=1094165661&lang=zh_CN#rd)

[41.使用 Kaniko 在 Kubernetes Pod 中构建 Docker 镜像](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494814&idx=2&sn=6051c0e56c8331a381fa4e318eb75f24&chksm=fdb61882cac1919435f99a44a5a6d110f9ead80f6259f52c7094882448504e052894757e4b5b&token=1094165661&lang=zh_CN#rd)

[42.在 Kubernetes 上设置最新的 Nexus OSS](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494903&idx=3&sn=c3b52b0d05419d93ea283f8bc4389adf&chksm=fdb618ebcac191fdab6ff68f00808c32148ef23560dcbad239ca4fad273496e6c340c845da27&token=1094165661&lang=zh_CN#rd)

[43.在 Kubernetes 上设置 Argo CD](https://mp.weixin.qq.com/s?__biz=MzU4MjY3Mzc3OQ==&mid=2247494952&idx=2&sn=210e5db8021b3c578de7b4930f3fc6d1&chksm=fdb61934cac19022949713892a641c26f79c744b4a79689ee4f135a6bf61334b2150e8c7de9a&token=1094165661&lang=zh_CN#rd)

在 ArgoCD 上设置多个集群

### Kubernetes 密钥管理教程

在本节中，您将学习如何使用推荐的开源密钥管理工具在 Kubernetes 中管理密钥。此外，我们还将介绍可以与 Kubernetes 集成的特定于云的秘密管理解决方案。

在 Kubernetes 中设置 Hashicorp Vault

使用 Vault Agent 向 Pod 注入密钥

在 EKS 上设置外部密钥

### Kubernetes 安全指南

在本节中，我们将了解 Kubernetes 安全指南。

使用 kube-bench 进行 CIS 基准测试

### Kubernetes 认证指南 （CKA/CKAD/CKS）

如果您希望获得 Kubernetes 认证，以下认证指南将有所帮助。

CKA认证学习指南

CKAD 认证学习指南

CKS 认证学习指南

另外，请查看 kubernetes 认证优惠券页面以获取最新的考试券代码，以节省考试注册费用。

### Kubernetes 最新更新

以下是 Kubernetes 的一些最新更新。

Kubernetes v.1.30：Uwubernetes 已发布，具有 58 个新功能和改进功能。

Kubernetes v.28：Planternetes 已发布。它有 45 项增强功能。19 个已进入 Alpha 阶段，14 个已升级为 
Beta 阶段，12 个已阶段阶段为 Stable。

Kubernetes v1.27 版本：Chill Vibes 已发布。它有 60 项增强功能。其中 13 人正在毕业到稳定。

Kubernetes v1.26：电气化已经发布。它有 37 项增强功能。

Kubernetes v1.25：Combiner 已发布。它有 40 项增强功能。

Kubernetes 1.24：Stargazer 已发布。此版本有 46 项增强功能。其中，13 个正在逐步升级到稳定版，14 个现有功能得到了改进，添加了 13 个新功能，6 个已弃用。

Dockershim 在 Kubernetes 1.24 发布时已弃用

Kubernetes 卷扩展现在是一个稳定的功能

### Kubernetes 常见问题

Kubernetes 好学吗？

Kubernetes 是一个复杂的分布式系统，也是一个由 API 驱动的 DevOps 工具。如果您了解 API、YAML 和网络的基础知识，则可以轻松学习 Kubernetes。

如何开始学习 Kubernetes？

要开始学习 Kubernetes，您需要首先了解有关平台本身的更多信息。有许多在线平台可以帮助您开始学习。其中一些包括以下内容：

1. 从路线图开始：首先，有一个详细的路线图，其中包含要在 Kubernetes 中学习的概念列表。您可以参考我们的 Kubernetes 学习路线图，了解从初级到高级的 Kubernetes 主题的结构化列表。

2. 官方的 Kubernetes 文档和任务 – 这是了解构成 Kubernetes 的所有不同组件和功能的最佳来源。您可以查看此网站，了解每个组件的作用以及如何使用它。

3. 在线 Kubernetes 论坛 – 有许多在线论坛，人们在这里讨论 Kubernetes。例如，LinkedIn 群组、StackOverflow 和 Reddit。这是提出问题并从其他用户那里获得帮助的好地方。您还可以在此处找到许多有用的提示和技巧。

4. YouTube Kubecon 视频 – 许多优秀的 Kubecon 视频可以帮助您深入了解 Kubernetes。您可以了解 Kubernetes 的不同功能以及如何使用它们。

5. 书籍 – 有很多好书可以帮助您了解 Kubernetes。其中一些书籍包括“Kubernetes： Up and Running”和“Kubernetes Cookbook”。

6. Killercoda 场景：使用 Katacoda 免费教程学习使用基于浏览器的终端的实时 Kubernetes 场景。

## 总结

将继续将所有 Kubernetes 初学者教程添加到此列表中。