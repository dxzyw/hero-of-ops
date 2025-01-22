本篇文章主要介绍argocd的工作流模板及cron工作流

工作流模板与工作流有不同的kind，如下：

```
apiVersion: argoproj.io/v1alpha1
kind: WorkflowTemplate
metadata:
  name: hello
spec:
  entrypoint: main
  templates:
    - name: main
      container:
        image: busybox
        command: [ echo ]
        args: [ "hello world" ]
```
工作流模板可以通过kubectl来管理

```
kubectl apply -f hello-workflowtemplate.yaml
```

cron工作流是按照计划运行的工作流,如下：

```
apiVersion: argoproj.io/v1alpha1
kind: CronWorkflow
metadata:
  name: hello-cron
spec:
  schedule: "* * * * *"
  workflowSpec:
    entrypoint: main
    templates:
      - name: main
        container:
          image: busybox
          command: ["echo"]
          args: ["hello world"]
```

新建cron工作流
```
argo cron create hello-cronworkflow.yaml
```