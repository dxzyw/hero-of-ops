本篇文章，我们将会学习argocd的inputs和outputs

主要从如下几点：

- 了解关于参数（parameters）
- 创建使用参数的工作流程
- 了解工件（artifacts）和存储（storage）
- 创建生成和使用工件的工作流

### 参数

输入参数

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: input-parameters-
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
argo submit --watch input-parameters-workflow.yaml
```

```
argo submit --watch input-parameters-workflow.yaml -p message='Welcome to Argo!'
```

输出参数

在 DAG 模板和步骤模板中，引用一个任务的输出，作为使用模板标签的另一任务的输入：

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: parameters-
spec:
  entrypoint: main
  templates:
    - name: main
      dag:
        tasks:
          - name: generate-parameter
            template: echo
          - name: consume-parameter
            template: print-message
            dependencies:
              - generate-parameter
            arguments:
              parameters:
                - name: message
                  value: "{{tasks.generate-parameter.outputs.parameters.hello-param}}"

    - name: echo
      container:
        image: busybox
        command: [sh, -c]
        args: ["echo -n hello world > /tmp/hello_world.txt"]
      outputs:
        parameters:
          - name: hello-param
            valueFrom:
              path: /tmp/hello_world.txt

    - name: print-message
      inputs:
        parameters:
          - name: message
      container:
        image: busybox
        command: [echo]
        args: ["{{inputs.parameters.message}}"]
```

### artifacts

Artifact是一个可以将数据存储在对象存储或者文件系统中的对象。

如下示例：

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: artifacts-
spec:
  entrypoint: main
  templates:
    - name: main
      dag:
        tasks:
          - name: generate-artifact
            template: save-message
          - name: consume-artifact
            template: print-message
            dependencies:
              - generate-artifact
            arguments:
              artifacts:
                - name: message
                  from: "{{tasks.generate-artifact.outputs.artifacts.hello-art}}"

    - name: save-message
      container:
        image: busybox
        command: [sh, -c]
        args: ["echo hello world > /tmp/hello_world.txt"]
      outputs:
        artifacts:
          - name: hello-art
            path: /tmp/hello_world.txt

    - name: print-message
      inputs:
        artifacts:
          - name: message
            path: /tmp/message
      container:
        image: busybox
        command: [sh, -c]
        args: ["cat /tmp/message"] 
```

### 总结

输入或输出有两类型：参数及工件

- 参数是短字符
- 工件则是文件，而且可以压缩并上传到s3或者目录 
- 如果要使用另外一个任务的输出作为另外一个任务的输入，可以使用DAG
