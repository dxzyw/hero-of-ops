
## 第三部分：镜像的创建、管理和发布

📌 **简介**：讲解如何构建、管理和优化Docker镜像，以提高应用的可移植性和运行效率。
1. Docker镜像的基本概念
2. 获取官方镜像
3. 自定义镜像构建方法
4. Dockerfile的编写
5. 镜像版本管理
6. 镜像优化与多阶段构建
7. 镜像存储与分发
8. Docker Hub与私有仓库
9. 镜像的安全性
10. 镜像垃圾回收策略
11. 生成支持多架构的Docker镜像
12. 实战演示：构建自己的应用镜像

### 1. Docker镜像的基本概念

Docker镜像是用于创建容器的只读模板，包含应用运行所需的所有内容（代码、依赖、环境变量等）。镜像分为多层，每一层都基于前一层构建，具有高度的可移植性和复用性。

---

### 2. 获取官方镜像

可以通过 Docker Hub 等公共仓库获取官方镜像。官方镜像经过严格测试，安全可靠，适合生产环境使用。

**常用命令：**
```bash
docker pull ubuntu
docker pull python:3.10
```
可通过 `docker search` 命令查找镜像：
```bash
docker search nginx
```

---

### 3. 自定义镜像构建方法

除了使用官方镜像，还可以根据实际需求自定义镜像。常见方法有：

- 基于已有镜像手动修改并提交为新镜像
- 编写 Dockerfile 自动化构建

**示例：**
```bash
docker commit [容器ID] myimage:v1
```
更推荐使用 Dockerfile 方式，便于版本管理和自动化。

---

### 4. Dockerfile的编写

Dockerfile 是定义镜像构建过程的脚本文件。常用指令有：

- `FROM`：指定基础镜像
- `RUN`：执行命令
- `COPY`/`ADD`：复制文件
- `WORKDIR`：设置工作目录
- `CMD`/`ENTRYPOINT`：容器启动命令
- `EXPOSE`：声明端口
- `ENV`：设置环境变量

**示例 Dockerfile：**
```dockerfile
FROM python:3.10
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "main.py"]
```

---

### 5. 镜像版本管理

通过标签（tag）管理镜像的不同版本，便于回滚和多环境部署。

**常用命令：**
```bash
docker tag myimage:v1 myrepo/myimage:v2
docker images
```

---

### 6. 镜像优化与多阶段构建

优化镜像体积和构建效率，常用方法：

- 清理无用文件和缓存
- 合理分层，减少镜像层数
- 使用多阶段构建（multi-stage build），只保留最终产物

**多阶段构建示例：**
```dockerfile
FROM golang:1.20 AS builder
WORKDIR /src
COPY . .
RUN go build -o app

FROM alpine:latest
COPY --from=builder /src/app /app
CMD ["/app"]
```

---

### 7. 镜像存储与分发

镜像可存储在本地或推送到远程仓库（如 Docker Hub、Harbor）。

**常用命令：**
```bash
docker push myrepo/myimage:v1
docker save myimage:v1 > myimage_v1.tar
docker load < myimage_v1.tar
```

---

### 8. Docker Hub与私有仓库

- **Docker Hub**：全球最大的公共镜像仓库，适合开源项目和公共镜像分发。
- **私有仓库**：如 Harbor、阿里云镜像服务，适合企业内部镜像管理和安全控制。

**登录与推送：**
```bash
docker login
docker push myrepo/myimage:v1
```

---

### 9. 镜像的安全性

- 使用官方或可信镜像源
- 定期扫描镜像漏洞（如 `docker scan`、Trivy）
- 最小化基础镜像，减少攻击面
- 定期更新和修复依赖

---

### 10. 镜像垃圾回收策略

长期使用会产生无用镜像和中间层，需定期清理，释放磁盘空间。

**常用命令：**
```bash
docker image prune
docker system prune -a
```

---

### 11. 生成支持多架构的Docker镜像

可通过 `buildx` 工具构建多架构镜像，支持 x86、ARM 等平台。

**示例：**
```bash
docker buildx build --platform linux/amd64,linux/arm64 -t myimage:multiarch .
```

---

### 12. 实战演示：构建自己的应用镜像

**步骤：**
1. 编写 Dockerfile
2. 构建镜像
   ```bash
   docker build -t myapp:v1 .
   ```
3. 运行并测试容器
   ```bash
   docker run -d -p 8080:80 myapp:v1
   ```
4. 推送到仓库
   ```bash
   docker tag myapp:v1 myrepo/myapp:v1
   docker push myrepo/myapp:v1
   ```

---

通过本章学习，你将掌握 Docker 镜像的构建、管理、优化与分发，为应用的容器化和持续交付打下坚实基础。
