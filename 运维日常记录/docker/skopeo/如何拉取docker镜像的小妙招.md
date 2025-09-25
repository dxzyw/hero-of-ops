9.8k star,镜像搬运工，CI/CD 的秘密武器！

skopeo，这个工具是目前用到最频繁的工具之一，而最频繁的操作就是通过github的action从docker官方仓库同步到阿里云镜像仓库，然后就可以在国内环境去使用了。

具体操作后面介绍，这里先简单介绍下该工具。

## 关于skopeo

这个工具是containers社区维护的开源工具，是一个命令行工具，专门用于操作容器镜像和镜像仓库，最大的特点在可以无需docker环境就可以直接与仓库交互，非常适合CI/CD的场景。

而在国内，它最大的用途则在于可以从docker官方镜像库同步到国内。

## skopeo的特点


1. **无需 Docker 守护进程**
   不需要 `docker pull` / `docker push` 依赖 Docker Daemon，`skopeo` 直接用 HTTP(S)/registry API 操作镜像。

2. **多种镜像传输方式**
   支持从一个仓库复制到另一个仓库，甚至支持本地存储（目录、OCI、tar）。

3. **只操作元数据，不拉取整个镜像**
   可直接查看镜像信息（manifest、digest、标签等），而不用拉镜像到本地。

4. **安全和认证机制**
   支持 TLS、Basic Auth、Bearer Token、Kubernetes secret、离线签名与验证。

5. **灵活的存储后端**
   支持 docker://、dir://、oci://、tarball://、containers-storage:// 等格式。

## skopeo使用场景

### 1. 查看镜像信息（无需下载镜像）

```bash
skopeo inspect docker://docker.io/library/nginx:latest
```

会输出镜像的 digest、架构、layers、标签等信息。

---

### 2. 镜像复制（Registry ↔ Registry）

把 `nginx:latest` 从 Docker Hub 复制到阿里云仓库：

```bash
skopeo copy docker://docker.io/ansible/ansible:ubuntu1404 docker://registry.cn-hangzhou.aliyuncs.com/argo_study/ansible:ubuntu1404
```
如果你想要结合github action，其实主要是利用github的网络环境，来同步的话，可以如下：

```bash
name: Sync Image to Aliyun  Example

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Git pull
      uses: actions/checkout@v3

    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2.9.1

    - name: Login to Docker Hub
      uses: docker/login-action@v2.2.0
      with:
        registry: registry.cn-hangzhou.aliyuncs.com
        username: 自己的用户
        password: 自己的密码
        logout: false

    - name: Use Skopeo Tools Sync Image to Docker Hub
      run: |
         skopeo copy docker://docker.io/ansible/ansible:ubuntu1404 docker://registry.cn-hangzhou.aliyuncs.com/argo_study/ansible:ubuntu1404
      # 使用 skopeo 工具将镜像同步到阿里云个人仓库中，使用时请自行源和目标修改仓库名称和镜像名称
```

👉 适合做镜像同步、镜像加速。



### 3. 保存镜像为目录 / OCI 格式 / Tar 包

* 保存为本地目录（每层单独文件夹）：

  ```bash
  skopeo copy docker://docker.io/library/alpine:3.19 dir:/tmp/alpine-dir
  ```

* 保存为 OCI 格式（可供 Podman/CRI-O 使用）：

  ```bash
  skopeo copy docker://docker.io/library/alpine:3.19 oci:/tmp/alpine-oci:3.19
  ```

* 保存为压缩 tar 包：

  ```bash
  skopeo copy docker://docker.io/library/alpine:3.19 docker-archive:/tmp/alpine.tar:3.19
  ```

---

### 4. 镜像签名与验证

* 签名（配合 `cosign` / `sigstore` 等工具）：

  ```bash
  skopeo copy --sign-by dev@example.com docker://nginx:latest \
              docker://registry.example.com/secure/nginx:latest
  ```

* 验证签名：

  ```
  skopeo inspect --verify docker://registry.example.com/secure/nginx:latest
  ```

---

### 5. 在 CI/CD 里做镜像扫描或同步

比如Jenkins Pipeline，不想拉取镜像浪费空间，可以只用 `skopeo inspect` 获取 digest，然后做安全扫描或比较：

```bash
digest=$(skopeo inspect docker://nginx:latest | jq -r .Digest)
echo "Current Nginx digest: $digest"
```

---

## 适用场景总结

* 构建 **镜像同步服务**（定时把上游镜像同步到私有仓库）
* 在 **CI/CD 流程** 中检查/传输镜像（比 docker pull 更轻量）
* **离线环境** 镜像导出/导入（tar / oci）
* 与 **Podman / Buildah / CRI-O** 配合，形成无 Docker 的容器工具链
* 镜像安全验证、签名、合规性检测



