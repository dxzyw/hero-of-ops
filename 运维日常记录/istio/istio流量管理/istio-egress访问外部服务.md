Istio 通过使用 ServiceEntry 服务 资源。

通过利用服务入口，外部服务可以无缝地整合到 Isto 的内部服务注册表中。

这些服务的集成还允许充分利用 Isto 的功能，例如 模拟超时、引入服务故障和实施高级请求路由 通过配置 虚拟服务 和 DestinationRules 的 DestinationRules 中。

如果是注入istio的服务，那么出口通过该参数控制 outboundTrafficPolicy 默认为allow any

可以通过设置参数REGISTRY_ONLY来控制对外流量

```
istioctl install --set profile=demo     -y --manifests=/root/istio-${ISTIO_VERSION}/manifests     --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY
```

```
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: httpbin-ext
spec:
  hosts:
  - httpbin.org
  ports:
  - number: 80
    name: http
    protocol: HTTP
  resolution: DNS
  location: MESH_EXTERNAL
```

可以对对外服务配置延迟策略

```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin-ext
spec:
  hosts:
  - httpbin.org
  http:
  - timeout: 3s
    route:
    - destination:
        host: httpbin.org
        port:
          number: 80
```