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

[2.Kubernetes 高可用性解释]()

[3.Kubernetes 设计注意事项]()

### Kubernetes 集群设置指南

在本节中，将学习如何在本地工作站和云平台上设置类似生产的多节点 Kubernetes 集群和开发集群。

我强烈建议大家使用以下教程设置自托管集群。它将为 Kubernetes 组件如何与集群中涉及的关键配置进行交互打下坚实的基础。

[4.]()Kubernetes Minikube 教程

[5.]()使用 Kubeadm 设置 Kubernetes 集群：使用 Kubeadm 设置自托管 Kubernetes 的端到端指南。

在 Kubeadm 上启用 Feature Gates（如果您想尝试在最新的 Kubernetes 版本中添加的 alpha 功能）
升级 Kubeadm 集群

Kubeconfig 文件解释：深入了解如何使用 Kubeconfig 文件进行集群身份验证。

了解重要的 Kubernetes 集群配置：有关所有关键 Kubernetes 集群配置的完整指南。

在 Vagrant 上设置自动化 Kubeadm 集群：使用 Vagrant 的基于 kubeadm 的全自动集群设置。

Google Cloud 上的 GKE 集群设置 – 详细指南

使用 eksctl 的 EKS 集群设置：只需几步即可创建 EKS 集群的指南。

### Kubectl 教程

使用 Kubernetes 集群时，kubectl 是与集互的重要命令。在本节中，我们将查看有效使用 kubectl 的教程。

[13.kubectl 设置上下文指南]()

### Kubernetes 备份和恢复教程

在本节中，我们将学习使用 Kubernetes 原生工具和其他开源和 cncf 相关工具进行 Kubernetes 备份和恢复。

[14.Etcd 备份和恢复：关于备份 etcd 和从备份中恢复它的详细指南。]()

### Kubernetes 原生资源教程

本节介绍有关 Kubernetes 原生资源的教程，如部署、Pod、Statefulset、RBAC、作业、入口等。

Kubernetes Pod 解释：通过实际示例解释基本对象 pod。

Pod 生命周期解释：有关 Pod 生命周期阶段的详细指南。

了解 init 容器：深入了解 init contianers。

Kubernetes 初学者部署教程

Kubernetes Daemonset 解释

如何为服务帐户创建 Kubernetes 角色

如何创建用于 API 访问的 Kubernetes 服务帐户

面向初学者的 Kubernetes Ingress 教程

如何使用 Nginx 控制器在 Kubernetes 上设置 Ingress

如何为 Kubernetes Ingress 配置 SSL/TLS

如何创建 Kubernetes 作业/cron 作业

Kubernetes Pod PriorityClass 和 Preemption 解释

### Kubernetes 生产力指南

创建 Kubernetes YAML 的简单方法
最佳 Kubernetes 仪表板应用程序 – Kubernetes Lens [视频教程]

### Kubernetes 监控教程

本节重点介绍如何使用 Prometheus、Grafana、Alert Manager 等工具进行 Kubernetes 监控和日志记录。我们还将介绍与特定云提供商相关的日志记录和监控指南。

如何在 Kubernetes 集群上设置 Prometheus 监控

在 Kubernetes 上设置 Prometheus Node Exporter

在 Kubernetes 上设置 Kube 状态指标

在 Kubernetes 上设置警报管理器

在 Kubernetes 上设置 grafana

### Kubernetes 日志指南

本部分介绍有关 Kubernetes 日志记录的端到端初学者教程列表。

Kubernetes 日志为初学者解释：本教程详细介绍了 Kubernetes 日志的底层概念和模式。

Kubernetes 上的 EFK 设置：解释 Kubernetes 上的 EFK 日志记录堆栈的分步指南。

在 Kubernetes 上设置 Grafana Loki

### Kubernetes 故障排除教程

在本节中，我们将学习对 Kubernetes 对象（Pod、部署、有状态副本集、集群组件等）进行故障排除。

如何对 Kubernetes Pod 进行故障排除

### Kubernetes 数据库教程

本节旨在介绍如何为 PostgreSQL、MongoDB 等数据库设置 Statefulsets 的教程。我们还将介绍 Kubernetes 数据库运算符，它们提供了额外的功能来管理 Kubernetes 上的数据库。

了解如何部署 PostgreSQL Statefulset 集群

在 Kubernetes 上部署 MongoDB 

### Kubernetes 包管理教程

在 Kubernetes 包管理下，您将了解 Helm 和 Kustomize 等工具。Helm 是一个模板工具，Kustomize 是一个覆盖引擎。这些是组织用于管理 Kubernetes 部署的标准工具。

如何安装 Helm 进行 Kubernetes 部署

如何从头开始创建 Helm Chart

Kustomize 教程

Kuztomize Configmap 和密码生成器

### Kubernetes CI/CD 教程

在 Kubernetes CI/CD 下，您将学习使用常用的 CI/CD 工具（如 Jenkins）和高级 GitOps Operator（如 ArgoCD、FluxCD 等）。

在 Kubernetes 集群上设置 Jenkins 

在Kubernetes Pod 上设置 Jenkins 构建代理

使用 Kaniko 在 Kubernetes Pod 中构建 Docker 镜像

在 Kubernetes 上设置最新的 Nexus OSS

在 Kubernetes 上设置 Argo CD

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