

使用 Ingress Gateway 资源配置 Istio Ingress 流量。


网关的目的是在服务网格边界之外公开服务，与 Kubernetes Ingress 资源相比，它提供了更广泛的自定义和灵活性。


此外，网关支持将 Istio 功能（例如监控和路由规则）应用于进入集群的传入流量。


Isto 的入口流量使用两个资源进行配置： gateway 以及 VirtualService。


创建 Istio 网关 在默认命名空间中命名 booking-gateway，以公开端口 80 上的 HTTP 流量并用于主机 booking.example.com。


```
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: booking-gateway
spec:
  # The selector matches the ingress gateway pod labels.
  selector:
    istio: ingressgateway
  servers:
  - name: booking
    port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "booking.example.com"
```

然后创建路由规则到具体的服务

```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: booking
spec:
  hosts:
  - "booking.example.com"
  gateways:
  - booking-gateway
  http:
  - route:
    - destination:
        port:
          number: 80
        host: booking-service
```