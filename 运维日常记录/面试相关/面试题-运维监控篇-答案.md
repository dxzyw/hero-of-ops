## Prometheus
- Prometheus的工作流程
- Metric的几种类型？分别是什么？ ☆
- Prometheus有哪几种服务发现☆
- Prometheus常用函数
- thanos架构☆
- thanos与VictoriaMetrics对比
- thanos sidecar和receive区别☆
- thanos rule组件和prometheus区别
- Prometheus告警从触发到收到通知延迟在哪
- 告警抑制怎么做☆
- 告警架构高可用怎么做☆
- Pod指标WSS和RSS区别☆
- 监控四个黄金指标
- 在大规模环境下，如何优化Prometheus性能
- 如何实现告警的自动化响应☆
- Prometheus数据压缩和持久化实现原理
- kubectl top输出与Linux free命令不一致原因☆
- 用到了哪些exporter，功能是什么
- 是否自己开发过exporter☆
- target down的情况如何进行故障排除？
- Exporter 停止工作，如何监控？
- Prometheus的拉取模式与zabbix推送模式有何区别？各有什么优缺点？
- Prometheus operator怎么添加targets和告警规则
- k8s集群外exporter怎么使用Prometheus监控


## Prometheus 进阶
- Prometheus的数据模型是什么？如何组织和存储时序数据？
- Prometheus如何处理高基数问题？
- remote write和remote read的工作原理是什么？
- 如何实现Prometheus的跨数据中心监控？
- Prometheus的查询语言PromQL有哪些优势和局限性？
- 如何优化Prometheus的查询性能？
- Prometheus如何实现标签的动态重写（relabel）？
- 如何处理Prometheus采集数据丢失的情况？
- Prometheus的数据保留策略如何设置？
- recording rules和alerting rules的区别和使用场景

## 监控系统设计
- 如何设计一个大规模监控系统的架构？
- 监控系统的性能指标有哪些？如何衡量？
- 监控数据的采集频率如何确定？
- 如何处理监控数据的时间戳对齐问题？
- 监控系统中如何处理敏感数据？
- 如何实现监控指标的动态聚合？

## 告警管理
- 如何避免告警风暴？
- 告警级别如何划分？
- 如何设计合理的告警阈值？
- 告警收敛策略有哪些？
- 如何处理告警误报？
- 告警升级机制如何设计？
- 如何实现告警的分组和路由？
- 告警恢复通知的策略是什么？

## 可观测性
- 可观测性的三大支柱是什么？
- 如何实现分布式追踪？
- 日志、指标、追踪三者之间的关系？
- 如何选择合适的可观测性工具？
- APM系统的核心功能有哪些？
- 如何实现服务依赖关系的可视化？
- 如何衡量系统的可观测性水平？
- ELK Stack在可观测性中的应用？
- SLI、SLO、SLA的区别和关系？
- 如何实现全链路监控？

## 性能监控
- 如何监控系统的性能瓶颈？
- 常见的性能问题诊断工具有哪些？
- 如何进行容器性能监控？
- 微服务架构下的性能监控策略？
- 如何监控数据库性能？
- JVM性能监控的关键指标有哪些？
- 网络性能监控的方法和工具？
- 如何监控云服务的性能？
- 性能监控数据的可视化方案？
- 如何设置性能基准线？

