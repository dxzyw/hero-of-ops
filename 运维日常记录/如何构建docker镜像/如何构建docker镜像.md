好的，我会在脚本中补充一些基础镜像的具体介绍。以下是更新后的视频脚本：

---

**[开场白]**
- **主持人**：大家好，欢迎收看本期视频！今天我们将学习如何使用 Docker 构建一个自定义的 Nginx 镜像。

**[介绍 Docker 和 Dockerfile]**
- **主持人**：首先，Docker 是一个用于打包、部署和运行应用程序的工具。我们将使用 Dockerfile 来定义镜像的构建过程。

**[创建项目结构]**
- **主持人**：让我们开始吧！首先，我们需要创建一个项目文件夹，并在其中创建一个名为 `Dockerfile` 的文件。

**[编写 Dockerfile]**
- **主持人**：在 Dockerfile 中，我们将使用 `FROM` 指令来指定基础镜像。在这个例子中，我们使用 `nginx:alpine` 作为基础镜像。`nginx:alpine` 是一个轻量级的 Nginx 镜像，非常适合用于构建小型和高效的容器。
  - **展示代码**：
    ```Dockerfile
    # 使用官方的 Nginx 镜像作为基础镜像
    FROM nginx:alpine

    # 复制自定义的 Nginx 配置文件到容器中
    COPY nginx.conf /etc/nginx/nginx.conf

    # 复制应用程序文件到容器中
    COPY . /usr/share/nginx/html

    # 暴露端口
    EXPOSE 80

    # 启动 Nginx
    CMD ["nginx", "-g", "daemon off;"]
    ```

**[创建 Nginx 配置文件]**
- **主持人**：接下来，我们需要创建一个自定义的 Nginx 配置文件 `nginx.conf`。
  - **展示代码**：
    ```nginx
    events { }

    http {
        server {
            listen 80;
            server_name localhost;

            location / {
                root /usr/share/nginx/html;
                index index.html;
            }
        }
    }
    ```

**[创建应用程序文件]**
- **主持人**：然后，我们创建一个简单的 HTML 文件 `index.html` 作为我们的应用程序代码。
  - **展示代码**：
    ```html
    <!DOCTYPE html>
    <html>
    <head>
        <title>Welcome to Nginx!</title>
    </head>
    <body>
        <h1>Success! The Nginx server is running.</h1>
    </body>
    </html>
    ```

**[构建镜像]**
- **主持人**：现在，我们可以使用 `docker build` 命令来构建镜像。
  - **展示命令**：
    ```bash
    docker build -t my-nginx-image .
    ```

**[运行容器]**
- **主持人**：构建完成后，我们可以使用 `docker run` 命令来运行容器，并在浏览器中查看结果。
  - **展示命令**：
    ```bash
    docker run -d -p 8080:80 my-nginx-image
    ```

**[结尾]**
- **主持人**：好了，这就是如何使用 Docker 构建和运行一个自定义 Nginx 镜像的全部过程。感谢大家的观看，请记得点赞和订阅！

