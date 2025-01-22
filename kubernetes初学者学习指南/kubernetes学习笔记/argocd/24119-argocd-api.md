本篇文章主要介绍argocd的api

主要介绍如下几点：

- 了解如何创建访问令牌以连接到 API。
- 如何通过curl方式来提交工作流
- 如何查找api文档


在开始之前我们先来生成访问令牌

```
kubectl create role argoapi --verb=create,get,list --resource=workflows.argoproj.io --resource=workfloweventbindings --resource=workflowtemplates
kubectl create sa argoapi
kubectl create rolebinding argoapi  --role=argoapi --serviceaccount=argo:argoapi
ARGO_TOKEN="Bearer $(kubectl create token argoapi)"

curl http://localhost:2746/api/v1/info -H "Authorization: $ARGO_TOKEN"
```

然后可以通过如下curl命令来提交工作流

```
curl \
   http://localhost:2746/api/v1/workflows/argo \
  -H "Authorization: $ARGO_TOKEN" \
  -H 'Content-Type: application/json' \
  -d '{
  "workflow": {
    "metadata": {
      "generateName": "hello-world-"
    },
    "spec": {
      "templates": [
        {
          "name": "main",
          "container": {
            "image": "busybox",
            "command": [
              "echo"
            ],
            "args": [
              "hello world"
            ]
          }
        }
      ],
      "entrypoint": "main"
    }
  }
}'
```

查看日志

```
curl \
    http://localhost:2746/api/v1/workflows/argo/@latest \
    -H "Authorization: $ARGO_TOKEN"
```

### webhooks

为了简单起见，我们使用api/v1/workflows端点来创建工作流，但有一个端点专门设计用于通过 api 创建工作流： api/v1/events 。

- 只允许从WorkflowTemplate创建工作流，因此更安全。
- 允许解析 HTTP 有效负载并将其用作参数
- 允许与其他系统集成，而无需更改这些系统
- Webhooks 还支持 GitHub 和 GitLab，因此可以从 git 操作触发工作流程

要使用它，需要创建一个WorkflowTemplate和一个工作流事件绑定：

工作流事件绑定包括：

- 匹配事件的事件选择器
- 使用workflowTemplateRef对WorkflowTemplates引用 

如下:

```
apiVersion: argoproj.io/v1alpha1
kind: WorkflowEventBinding
metadata:
  name: hello
spec:
  event:
    selector: payload.message != ""
  submit:
    workflowTemplateRef:
      name: hello
    arguments:
      parameters:
        - name: message
          valueFrom:
            event: payload.message
```

先创建一个工作流模板

```
apiVersion: argoproj.io/v1alpha1
kind: WorkflowTemplate
metadata:
  name: hello
spec:
  entrypoint: main
  arguments:
    parameters:
      - name: message
        value: hello world
  templates:
    - name: main
      inputs:
        parameters:
          - name: message
      container:
        image: busybox
        command: [echo]
        args: ["{{inputs.parameters.message}}"]
```

```
kubectl apply -f hello-workflowtemplate.yaml
kubectl apply -f hello-workfloweventbinding.yaml
```

然后可以通过curl命令触发

```
curl http://localhost:2746/api/v1/events/argo/- -H "Authorization: $ARGO_TOKEN" -d '{"message": "hello events"}'
```