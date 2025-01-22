本篇文章介绍关于argocd的templates

你将会了解到：

- 了解不同templates的
- 了解如何使用模板标签来构建模板
- 将它们组合在一起形成复杂的工作流

模板分为了很多类型，分为两个不同的类别：工作和编排

- 工作：工作是argocd中工作流的基本构建块，工作定义了单个任务或步骤，可以包含一个或多个容器
- 编排：编排是argocd中工作流的高级构建块，编排定义了多个工作，并可以包含条件、循环和错误处理等复杂逻辑 

而工作包含：

- 容器 container
- 容器组
- 脚本
- 资源


而编排包含：

- DAG
- 步骤
- Suspend

在这里面最长见到的是容器及DAG

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

