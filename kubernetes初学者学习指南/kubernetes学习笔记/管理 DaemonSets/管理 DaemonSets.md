
DaemonSet 确保所有（或部分）节点都运行 Pod 的副本。当节点添加到集群中时，Pod 也会被添加到集群中。当节点从集群中删除时，这些 Pod 将被驱逐。删除 DaemonSet 将清理它创建的 Pod。

DaemonSet 的一些典型用途是：

- 在每个节点上运行集群存储守护程序，例如 glusterd 和 ceph。
- 在每个节点上运行日志收集守护程序，例如 Fluentd 或 Logstash。
- 在每个节点上运行节点监控守护程序，例如 Prometheus Node Exporter （node_exporter）

在一个简单的例子中，一个覆盖所有节点的 DaemonSet 将用于每种类型的守护进程。更复杂的设置可能会对单一类型的守护进程使用多个 DaemonSet，但对于不同的硬件类型具有不同的标志和/或不同的内存和 cpu 约束。

### 创建daemon set

本文我们简单介绍下如何创建daemonset，我们通过启动一个nginx在所有节点上

#### nginx DaemonSet

我们先看一个yaml文件,是完成一些准备工作

```
---
kind: Namespace
apiVersion: v1
metadata:
  name: development
  labels:
    name: development

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: nginx-svc-acct
  namespace: development
  labels:
    name: nginx-svc-acct
```

cat nginx-daemonset.yaml

```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx
  namespace: development
  labels:
    app: nginx
    name: nginx
spec:
  selector:
    matchLabels:
      app: nginx
      name: nginx
  template:
    metadata:
      labels:
        app: nginx
        name: nginx
    spec:
      serviceAccountName: nginx-svc-acct
      containers:
      - image: katacoda/docker-http-server:latest
        name: nginx
        ports:
        - name: http
          containerPort: 80
```

上述创建后，可以通过如下命令查看

```
kubectl get po -n development -l app=nginx -o 'jsonpath={.items[0].spec.nodeName}';
```

可以看到目前只在node01上运行，如果想要在master上执行，需要调整配置

```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx
  namespace: development
  labels:
    app: nginx
    name: nginx
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
        name: nginx
    spec:
      serviceAccountName: nginx-svc-acct
      containers:
      - image: katacoda/docker-http-server:latest
        name: nginx
        ports:
        - name: http
          containerPort: 80
      tolerations:
      - key: node-role.kubernetes.io/master
        effect: NoSchedule
```