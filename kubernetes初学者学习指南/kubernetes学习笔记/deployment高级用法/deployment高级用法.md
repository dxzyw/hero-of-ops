
本篇文章继续介绍deployment

在开始介绍deployment之前，先来聊下ReplicaSets

### ReplicaSets

ReplicaSet 是确保每个 Pod 的所需数量的副本都已启动并正在运行。每当 Pod 宕机时，ReplicaSet 都会部署一个新的 Pod 以保持高可用性。

如下这个yaml文件将会创建一个rs

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: tutum-rs
  labels:
    app: tutum
spec:
  replicas: 3
  selector:
    matchLabels:
      app: tutum
  template:
    metadata:
      labels:
        app: tutum
    spec:
      containers:
      - name: tutum
        image: tutum/hello-world
        ports:
        - containerPort: 80
```
其中比较重要的是两个配置，一个是replicas，一个是selector。

replicas确保有多少个在活跃的pod

selector用来匹配一组pod

部署一个ReplicaSet与部署一个pod一样

```
kubectl create -f ./resources/tutum-rs.yaml
```

如上可以创建三个tutum pod

我们可以通过如下命令来详细查看ReplicaSet的具体情况

```
kubectl describe rs tutum-rs
```

如果要修改启动的副本数目，可以通过如下命令

```
kubectl edit rs tutm-rs
```

上述修改完成后，将会自动扩缩

也可以采用命令行的方式完成上述操作

```
kubectl scale rs tutum-rs --replicas=2
```

如果你想要实现自动扩缩容，可以通过 autoscale 方式来完成

```
kubectl autoscale rs tutum-rs --max=10 --min=3 --cpu-percent=50 --dry-run=true -o=yaml
```

通过上述dry-run方式可以生成一段yaml文件，但是不会对现有环境产生影响，而上述的autoscale是当所有Pod的平均CPU使用率达到50%时，触发扩缩操作

### Deployment Manifests 部署清单


管理我们的 Deployment 的最有效和可重复的方法是使用 Manifest 文件。

如下是一个最简单的清单文件

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tutum-deployment
spec:
  template:
    spec:
      containers:
      - name: tutum
        image: tutum/hello-world
        ports:
        - containerPort: 80
```

如果我们看一下这个 Deployment，它看起来与我们的 PodSpec 和 RS Manifest 非常相似。我们可以将 Pod 部分中已经介绍过的任何配置添加到此清单中。我们还应该配置 ReplicaSet 以满足我们的复制需求。

所有 Kubernetes deployment YAML 文件都必须包含以下规范：

#### apiVersion - apps/v1

apiVersion 指定要使用的 API 版本。API 对象按组定义。deployment对象属于 apps API 组。Group 对象可以声明为 alpha、beta 或 stable

- Alpha - 可能包含 bug，但不能保证将来会正常工作。示例：（object）/v1alpha1
- beta - 仍然有些不稳定，但很可能会进入 Kubernetes 主要 API。示例：（object）/v1beta1
- stable - 建议在生产系统中仅使用稳定版本。示例：apps/v1

#### kind - Deployment

kind 值声明要在 Yaml 文件中描述的 Kubernetes 对象的类型。Kubernetes 支持以下 'kind' 对象：

- componentstatuses
- configmaps 配置映射
- daemonsets 守护进程集
- Deployment 部署
- events 事件
- endpoints 端点
- horizontalpodautoscalers
- ingress 入口
- jobs
- limitranges limit范围
- Namespace Namespace （命名空间）
- nodes
- pods
- persistentvolumes
- persistentvolumeclaims
- PersistentVolume声明
- resourcequotas 资源配额
- replicasets
- replicationcontrollers
- serviceaccounts
- services

#### metadata 元数据

元数据声明其他数据以唯一标识 Kubernetes 对象。可以添加到对象的关键元数据：

- labels - k8s 内部用于根据标识信息选择对象的大小受限的键值对
- name - 对象的名称（在本例中为 Deployment 的名称）
- namespace - 用于创建对象 （deployment） 的命名空间的名称
- annotations - 用于为对象提供非识别信息的大型非结构化键值对。k8s 无法查询注解。
- spec - 对象的期望状态和特征。spec 有三个重要的子字段：
  - replicas：部署中运行的 Pod 数量
  - selector：管理 Deployment 必须匹配的 Pod 标签
  - template：定义每个 pod（容器、端口等）

### 与 Deployment 交互

让我们看看创建 Deployment 时发生了什么：

kubectl describe deployment tutum-deployment

我们可以看到，在 Deployment 的事件中，创建了一个 ReplicaSet。让我们看看带有 kubectl 的 ReplicaSet 描述了什么 rs。您的 ReplicaSet 具有唯一的名称，因此您需要 tab-complete。

当我们查看 ReplicaSet 事件时，我们可以看到它正在创建 Pod。

当我们使用 kubectl describe pod 查看 Pod 时，我们会看到主机拉取了镜像，并启动了容器。

可以在命令行上使用 set 更新部署。下面是一个示例：

```
kubectl set image deployment/tutum-deployment tutum=nginx:alpine --record
```

我们将上述镜像调整后，可以通过查看历史记录查看发生了什么：

```
kubectl rollout history deployment tutum-deployment
```

### 如何完成一个功能齐全的deploymnent

现在，让我们用 Deployment 的基本内容填充这个文件：

```
apiVersion: 
kind: 
metadata: 
spec: 
```
我们应该为这些中的每一个设置什么值？

- apiVersion: apps/v1
- kind: Deployment
- metadata 需要配置名称及标签
- spec：配置RS及pod

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tutum-deployment
  labels:
    app: tutum
spec:
```

继续完成spec，需要配置一个RS，并且能够匹配标签

```
spec:
  replicas: 3
  selector:
    matchLabels:
      app: tutum
```

然后需要配置容器、端口、以及镜像

```
spec:
  replicas: 3
  selector:
    matchLabels:
      app: tutum
  template:
    metadata:
      labels:
        app: tutum
    spec:
      containers:
      - name: tutum
        image: tutum/hello-world
        ports:
        - containerPort: 80
```

### 两个任务

#### 配置一个nginx的deployment，要求如下：

- 命名 Deployment
- 为deployment配置标签
- 配置rs需要启动5个pod
- 使用nginx-alpine镜像
- 在端口上监听80
- 配置环境变量，user=admin。password=root，host=test
- 配置资源限制1个cpu，256M内存


```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports:
        - containerPort: 80
        env:
        - name: user
          value: "admin"
        - name: password
          value: "root"
        - name: host
          value: "test"
        resources:
          limits:
            cpu: "1"
            memory: "256Mi"
          requests:
            cpu: "1"
            memory: "256Mi"
```


#### 补充滚动更新和回滚

```
strategy:
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 1
  type: RollingUpdate
```

获取deployment rollout历史

```
kubectl rollout history deployment/nginx-deployment
```

跳会指定版本

```
kubectl rollout undo deployment.v1.apps/nginx-deployment --to-revision=X
```