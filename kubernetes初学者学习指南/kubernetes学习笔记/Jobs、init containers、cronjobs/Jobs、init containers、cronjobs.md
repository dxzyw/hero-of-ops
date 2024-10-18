
本文章介绍Kubernetes 中的 Jobs、Init Containers 和 CronJobs

Jobs 资源创建一个或多个 Pod，并确保所有 Pod 都成功终止。

有两种类型的Jobs
- 非并行作业：一个 Job，它只创建一个 Pod（如果 Pod 终止不成功，则重新创建），并在 Pod 成功终止时完成。
- 具有完成计数的并行作业：当一定数量的 Pod 成功终止时完成的 Job。您可以使用 completions 字段指定所需的完成数。

Cron Jobs创建一个作业对象，它们对于创建定期和重复任务很有用，例如运行备份或发送电子邮件。

Init containers 是 Pod 中的常规容器，在 App 容器之前运行，它们还满足以下语句：

- 他们可以运行应用程序容器中不存在的设置脚本 - 例如，预填充一些数据，等待特定服务启动并运行等。
- 除了应用程序容器之外，一个 Pod 还可以有一个或多个 init 容器
- Init 容器始终运行到 completation
- 每个任务都必须成功完成，然后才能开始下一个任务
- 如果任何已配置的 init 容器未成功完成执行，则应用程序容器将不会运行

### Jobs

作业创建的 Pod 不会自动删除。保留 Pod 允许您查看已完成作业的日志，以检查潜在错误。如果要删除它们，则需要手动执行此操作。


#### 创建一个作业

yaml文件如下

```
apiVersion: batch/v1
kind: Job
metadata:
  name: countdown
spec:
  template:
    spec:
      containers:
      - name: countdown
        image: bash
        command: ["/bin/sh",  "-c"]
        args: 
          - for i in 9 8 7 6 5 4 3 2 1 ; do echo $i ; done &&
            echo Perfect!
     restartPolicy: OnFailure            
```

restartPolicy只能设置为onfailure或者never

> 注意：在某些情况下，您希望在多次重试后使作业失败。为此，请使用 spec.backoffLimit，它实际上被设置为 6。你可以使用 spec.activeDeadlineSeconds 来限制执行时间，以防你想管理特定任务的持续时间。如果执行达到此截止时间，则 Job 及其所有 Pod 都将终止。

部署

```
kubectl apply -f /manifests/job.yaml
```

查看日志

```
kubectl logs `kubectl get pods -o 'jsonpath={.items[0].metadata.name}'`
```

### Parallel Jobs 并行作业

要创建并行作业，我们可以使用 spec.parallelism 来设置我们想要并行运行的 Pod 数量，并使用 spec.completions 来设置我们想要实现的作业完成数量。

```
apiVersion: batch/v1
kind: Job
metadata:
  name: countdown
spec:
  completions: 8
  parallelism: 2
  template:
    spec:
      containers:
      - name: countdown
        image: bash
        command: ["/bin/sh",  "-c"]
        args: 
          - for i in 9 8 7 6 5 4 3 2 1 ; do echo $i ; done &&
            echo Perfect! 
      restartPolicy: OnFailure
```
该作业将并行运行 2 个 pod，直到成功达到 8 个完成

#### Cron Jobs

```
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            args:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
```

创建 cron 作业后，LAST-SCHEDULE 列将立即没有值 （<none>）。这表明 CronJob 尚未运行。

一旦 LAST-SCHEDULE 列获得值，它表示 CronJob 现在已计划运行

```
kubectl get cronjob hello
```

### Init Container

Init Container 是在应用程序容器启动之前执行的容器。Init-containers 通常用于部署实用程序或执行未在应用程序容器镜像中加载和执行的脚本。

#### 使用 init 容器创建 Pod

如下yaml
```
apiVersion: v1
kind: Pod
metadata:
  name: happypanda
spec:
  containers:
  - name: busybox
    image: busybox:latest
    command: ["/bin/sh", "-c"]
    args: ["cat /opt/workdir/helloworld && sleep 3600"]
    volumeMounts:
    - name: workdir
      mountPath: /opt/workdir
  initContainers:
  - name: init-container
    image: busybox
    command:
            - sh
            - -c
            - 'echo "The app is running" > /opt/workdir/helloworld'
    volumeMounts:
    - mountPath: /opt/workdir
      name: workdir
  volumes:
  - name: workdir
```

此示例运行一个 init-container，该容器在卷中创建一个 helloworld 文件。如果 helloworld 文件存在于特定路径上并且 Pod 可以访问它，则将调度应用程序 Pod。

```
kubectl apply -f /manifests/init-container.yaml
```

如果 Pod 正在运行，则表示该文件已成功创建，并且 Pod 可以读取它。我们将手动检查文件是否位于指定路径，并且它是否具有正确的内容：

kubectl exec -ti happypanda -- cat /opt/workdir/helloworld