

Isto 的请求路由允许控制 Kubernetes 集群中部署的服务之间的流量。

请求路由可用于 A/B 测试。例如，它通过将满足特定条件的用户请求子集定向到具有最新功能的部署来启用新功能测试。

可以在 Istio 中定义的请求匹配标准示例包括：

- HTTP Header  HTTP 标头
- URL Path Prefix  URL 路径前缀
- Query Parameters  查询参数

Isto 的请求路由使用两个资源进行配置： 一个 DestinationRule 以及 VirtualService。

假设创建 DestinationRule 名为 notification 的默认命名空间中的资源，其中包含 notification-service 主机的两个子集 v1 和 v2

```
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: notification
spec:
  host: notification-service
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```

然后创建 VirtualService 名为 notification 的默认命名空间中的资源 只有一个默认 HTTP 目标路由用于 Host notification-service。目标路由指向在上一步中创建的名为 v1 的子集。

```
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: notification
spec:
  hosts:
  - notification-service
  http:
  - route:
    - destination:
       host: notification-service
       subset: v1
```

还可以根据header的内容来分配流量，比如：

```
---
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: notification
spec:
 hosts:
 - notification-service
 http:
  - route:
    - destination:
       host: notification-service
       subset: v2
    match:
    - headers:
        testing:
          exact: "true"
  - route:
    - destination:
       host: notification-service
       subset: v1
```

还可以根据url来分配流量

```
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: notification
spec:
  hosts:
  - notification-service
  http:
  - match:
    - uri:
        prefix: "/v2/notify"
    rewrite:
      uri: "/notify"
    route:
    - destination:
        host: notification-service
        subset: v2
  - route:
    - destination:
        host: notification-service
        subset: v1
```

