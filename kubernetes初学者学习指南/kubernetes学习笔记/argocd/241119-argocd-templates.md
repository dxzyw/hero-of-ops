
这篇文章主要是帮你理解 **Argo CD 里的模板（templates）**。
简单来说，模板就是定义 **工作流该怎么跑** 的方式。

阅读后你会明白：

* 有哪些不同类型的模板
* 模板里常用的标签怎么用
* 如何把这些模板拼在一起，形成更复杂的工作流

在 Argo CD 里，模板大致分为两类：

### 1. 工作（Work）

工作就是 **最小的任务单位**，比如一个“步骤”。
它可以是：

* 一个 **容器**（最常用的）
* 一个 **容器组**（多个容器一起运行）
* 一段 **脚本**
* 一个 **资源**（比如 Kubernetes 资源）

### 2. 编排（Orchestration）

编排是把多个工作 **组织起来**，就像把乐队里的乐手组合成一首曲子。
它支持更复杂的逻辑，比如：

* **DAG（有向无环图）**：定义任务的依赖关系，常用
* **步骤（Steps）**：一个一个顺序执行
* **Suspend**：让流程暂停，等条件满足后再继续

👉 在实际使用中，最常见的就是 **容器（单个任务）** 和 **DAG（编排多个任务）**。



### 容器模板

如下示例：

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: container-
spec:
  entrypoint: main
  templates:
  - name: main
    container:
      image: busybox
      command: [echo]
      args: ["hello world"]
```

执行如上

```
argo submit --watch container-workflow.yaml
```

### 模板标签

模板标签是在运行时将数据替换到工作流程中的一种方法。模板标签由{{和}}分隔，并在模板执行时被替换。

如下示例：

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: template-tag-
spec:
  entrypoint: main
  templates:
    - name: main
      container:
        image: busybox
        command: [echo]
        args: [hello "{{workflow.name}}"]
```

### 工作模板 

- 容器集：允许在单个 Pod 中运行多个容器。当希望容器共享一个公共工作区时，或者当希望将 Pod 启动时间整合到工作流程中的一个步骤中时，这非常有用。
- 脚本：允许在 Pod 中运行任意命令。
- 资源：允许在工作流程中创建、修改和删除 Kubernetes 资源。
- 数据：允许在工作流程中传递数据。

下面的命令可以查看

```
kubectl get pods -l workflows.argoproj.io/workflow
```

### DAG模板

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: dag-
spec:
  entrypoint: main
  templates:
    - name: main
      dag:
        tasks:
          - name: a
            template: echo
          - name: b
            template: echo
            dependencies:
              - a
    - name: echo
      container:
        image: busybox
        command: [ echo ]
        args: [ "hello world" ]
```

DAG 有两个任务：“a”和“b”。两者都运行“echo”模板，但由于“b”依赖于“a”，因此在“a”成功完成之前它不会启动。

loops

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: with-items-
spec:
  entrypoint: main
  templates:
    - name: main
      dag:
        tasks:
          - name: print-message
            template: echo
            arguments:
              parameters:
                - name: message
                  value: "{{item}}"
            withItems:
              - "hello world"
              - "goodbye world"

    - name: echo
      inputs:
        parameters:
          - name: message
      container:
        image: busybox
        command: [echo]
        args: ["{{inputs.parameters.message}}"]
```
在此示例中，它将针对列出的每个项目执行一次。我们可以在这里看到一个模板标签。 {{item}}将替换为“hello world”和“goodbye world”。 DAG 并行执行，因此两个任务将同时启动。


- 步骤模板允许您按顺序运行一系列步骤。
- Suspend 模板允许您暂停工作流，并稍后恢复。

编排模板不运行 Pod

