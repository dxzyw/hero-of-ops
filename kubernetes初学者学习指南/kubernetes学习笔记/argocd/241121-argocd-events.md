本篇文章主要聊一下关于argo-events的内容：

- 如何安装argo-events
- 如何根据时间触发工作流
- 了解如何解决与 Argo Events 和 Argo Workflows 相关的 Kubernetes RBAC 问题。


### 如何安装argo-events

先要新建一个命名空间

```
kubectl create ns argo-events
```

然后安装argo-events及eventbus

```
kubectl apply -n argo-events -f https://github.com/argoproj/argo-events/releases/download/v1.9.2/install.yaml 
kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml
```

在整个过程中，还需要配置一个minio的事件源

所以需要给argo配置一个密钥 

```
cat /root/minio-secret.yaml
apiVersion: v1
stringData:
  accesskey: argoproj
  secretkey: sup3rs3cr3tp4ssw0rd1
kind: Secret
metadata:
  name: minio-creds
  labels:
    app: minio
type: Opaque
```
```
kubectl apply -n argo-events -f /root/minio-secret.yaml
```
如下为事件源配置

```
cat /root/minio-eventsource.yaml
apiVersion: argoproj.io/v1alpha1
kind: EventSource
metadata:
  name: minio
spec:
  minio:
    example:
      # bucket information
      bucket:
        # name of the bucket
        name: argoproj
      # s3 service endpoint
      endpoint: minio.argo.svc.cluster.local:9000
      # list of events to subscribe to
      # Visit https://docs.minio.io/docs/minio-bucket-notification-guide.html
      events:
        - s3:ObjectCreated:Put
        - s3:ObjectRemoved:DeleteMarkerCreated

      # type of the connection
      insecure: true
      # accessKey refers to K8s secret that stores the access key
      accessKey:
        # Key within the K8s secret whose corresponding value (must be base64 encoded) is access key
        key: accesskey
        # Name of the K8s secret that contains the access key
        name: minio-creds
      # secretKey contains information about K8s secret that stores the secret key
      secretKey:
        # Key within the K8s secret whose corresponding value (must be base64 encoded) is secret key
        key: secretkey
        # Name of the K8s secret that contains the secret key
        name: minio-creds
```

```
kubectl apply -n argo-events -f /root/minio-eventsource.yaml
``` 

上述过程中，我们创建了Events Controller-Manager、eventbus statefulset、minio-eventsource pod

```
kubectl -n argo-events get deploy controller-manager
kubectl -n argo-events get statefulsets eventbus-default-stan
kubectl -n argo-events get pod -l eventsource-name=minio
```
要实现事件的触发，我们还需要完成两步配置，1.创建一个传感器2.创建一个账户能够在argo命名空间中创建资源

1.创建一个传感器

```
cat /root/minio-sensor.yaml
apiVersion: argoproj.io/v1alpha1
kind: Sensor
metadata:
  name: minio
spec:
  dependencies:
    - name: example-dep
      eventSourceName: minio
      eventName: example
  triggers:
    - template:
        name: minio-workflow-trigger
        k8s:
          operation: create
          source:
            resource:
              apiVersion: argoproj.io/v1alpha1
              kind: Workflow
              metadata:
                generateName: artifact-workflow-
                namespace: argo
              spec:
                entrypoint: echo
                arguments:
                  parameters:
                    - name: message
                      # the value will get overridden by event payload from test-dep
                      value: THIS_WILL_BE_REPLACED
                templates:
                  - name: echo
                    inputs:
                      parameters:
                        - name: message
                    container:
                      command:
                        - echo
                      image: busybox
                      args: ["{{inputs.parameters.message}}"]
          # The container args from the workflow are overridden by the s3 notification key
          parameters:
            - src:
                dependencyName: example-dep
                dataKey: notification.0.s3.object.key
              dest: spec.arguments.parameters.0.value
      retryStrategy:
        steps: 3
```
会在我们的 argo-events 命名空间中创建一个 pod，负责在收到事件时触发工作流程。


2.然后配置一个账户能够在argo命名空间中创建资源

```
cat /root/sa.yaml
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: argo-events-create-wf
  namespace: argo-events
rules:
  - apiGroups: ["argoproj.io"]
    resources: ["workflows"]
    verbs: ["create"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: argo-events-cluster-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: argo-events-create-wf
subjects:
  - kind: ServiceAccount
    name: default
    namespace: argo-events
```

完成上述两步之后，我们如果在minio中创建文件，将会触发argo的工作流




