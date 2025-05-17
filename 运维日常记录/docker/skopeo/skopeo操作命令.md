

**1. 查看远程镜像信息（无需拉取本地）**  
```bash
skopeo inspect docker://registry.fedoraproject.org/fedora:latest
```

**2. 查看镜像配置（更详细）**  
```bash
skopeo inspect --config docker://registry.fedoraproject.org/fedora:latest | jq
```

**3. 复制镜像到另一个仓库**  
```bash
skopeo copy docker://quay.io/buildah/stable docker://registry.internal.company.com/buildah
```

**4. 复制镜像到本地目录**  
```bash
skopeo copy docker://docker.io/library/ubuntu:latest dir:/tmp/ubuntu
```

**5. 删除远程仓库中的镜像**  
```bash
skopeo delete docker://localhost:5000/imagename:latest
```

**6. 同步整个仓库到本地目录**  
```bash
skopeo sync --src docker --dest dir registry.example.com/busybox /media/usb
```

**7. 登录私有仓库**  
```bash
skopeo login --username USER myregistrydomain.com:5000
```

**8. 使用用户名密码直接操作**  
```bash
skopeo inspect --creds=testuser:testpassword docker://myregistrydomain.com:5000/busybox
```

---

更多用法和详细说明可参考官方文档：[Skopeo GitHub](https://github.com/containers/skopeo)
