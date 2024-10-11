38.3k star，一招解决docekr镜像过大的问题，强大！酷炫！实用！

# Dive：深入 Docker 镜像的魔幻之旅

在容器化时代，Docker 已经成为了众多开发者和运维人员的首选工具之一。通过 Docker，我们可以将应用程序及其依赖项封装在一个轻量级的容器中，轻松实现跨平台部署。

然而，当我们在构建 Docker 镜像时，一个经常被忽视的问题是镜像的大小。过大的镜像不仅会占用宝贵的存储空间，还可能导致部署时间延长，影响性能。

为了更好地理解和优化 Docker 镜像，让我们一起探索一个神奇的工具 - Dive。

通过一个简答的gif先了解下：

![dive使用](https://files.mdnice.com/user/46581/d1aea7cb-5a54-4ec8-938e-9c128337d53a.gif)


## 什么是 Dive？

Dive 是一个功能强大的命令行工具，用于探索和分析 Docker 镜像层的内容。它的名字"**Dive**"就像是一次深潜，让您能够深入了解 Docker 镜像的内部结构，查看每个层次的细节，发现不必要的文件和浪费空间，以便更好地优化您的镜像。

Dive 的目标很明确 - 帮助您更好地理解 Docker 镜像，发现如何缩小镜像的大小，并让您的容器部署更加高效。

## 基本特性

### 1. 分析 Docker 镜像内容

使用 Dive，您可以深入查看 Docker 镜像的层次结构。镜像由多个层次组成，每个层次都包含一组文件和文件夹。通过 Dive，您可以逐个层次地查看这些文件，以及它们在整个镜像中的位置。这使您能够清晰地了解镜像构建的每个步骤。

### 2. 显示不同层次的更改

一个 Docker 镜像通常包含多个层次，每个层次都基于前一个层次构建。 Dive 可以标识出每个镜像层次中哪些文件已更改、被修改、添加或删除。这有助于您了解不同层次之间的差异，并识别哪些文件在构建过程中发生了变化。

### 3. 估算镜像效率

Dive 提供了一个实验性的指标，用于估算镜像的效率。这个指标将显示镜像中浪费空间的百分比得分以及总的浪费文件空间。这些浪费可能来自于文件在不同层次之间的重复、文件的移动，或者文件没有完全删除。通过这个指标，您可以轻松识别和优化镜像中的浪费空间。

### 4. 快速构建和分析周期

Dive 提供了一个便捷的功能，让您可以快速构建 Docker 镜像并立即进行分析。只需使用 `dive build -t some-tag` 命令替换您通常用于构建镜像的 Docker 命令，您就能够一键执行构建和分析操作。这样，您可以更加高效地构建和优化镜像。



## 安装 Dive

Dive 可以在各种操作系统上安装，以下是一些示例安装方法：

### 在 Ubuntu/Debian 上安装 Dive

```shell
export DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
```

### 在 RHEL/Centos 上安装 Dive

```shell
export DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.rpm
rpm -i dive_${DIVE_VERSION}_linux_amd64.rpm
```

### 在 Arch Linux 上安装 Dive

```shell
pacman -S dive
```

### 在 Mac 上安装 Dive

如果您使用 Homebrew，可以使用以下命令安装 Dive：

```shell
brew install dive
```

### 在 Windows 上安装 Dive

您可以从 Dive 的 GitHub 发行版页面下载适用于 Windows 的最新版本。

## 使用 Dive 进行镜像分析

Dive 的使用非常简单。只需在命令行中运行 `dive <your-image-tag>`，将 `<your-image-tag>` 替换为您要分析的 Docker 镜像标签即可。Dive 将会启动一个界面，让您深入探索镜像的层次结构和内容。

不仅如此，您还可以使用 Docker 命令直接运行 Dive，如下所示：

```shell
alias dive="docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"


dive <your-image-tag>
```

这使得 Dive 在您的 Docker 工作流中无缝集成，轻松分析和优化镜像。

## 为什么使用 Dive？

Dive 不仅是一个镜像分析工具，它还是一个镜像优化的利器。为什么您应该考虑使用 Dive 呢？

### 更好的镜像理解

Dive 让您能够深入了解 Docker 镜像的内部结构。通过分析每个层次的内容，您可以清晰地了解镜像的构建过程，发现不必要的文件和重复的内容。这有助于您更好地理解镜像，从而更好地优化它。

### 减小镜像大小

Dive 可以帮助您识别镜像中的浪费空间。通过查看哪些文件是不必要的、重复的，或者可以被删除的，您可以采取措施减小镜像的大小。这不仅会减少存储成本，还会提高容器部署的速度和性能。

### 提高效率

通过 Dive，您可以快速构建和分析镜像，减少了构建和分析之间的等待时间。这使您能够更快速地迭代和优化镜像，提高了工作效率。


## 结语

在容器化的世界里，Docker 镜像的大小和效率至关重要。Dive 是一个强大的工具，可以帮助您更好地理解和优化 Docker 镜像。无论您是一名开发者还是一名运维人员，Dive 都将成为您不可或缺的伙伴，帮助您构建更加高效、轻量化的容器镜像。

不要再被过大的 Docker 镜像困扰，开始使用 Dive，深入探索 Docker 镜像的魔幻之旅吧！ Dive，让 Docker 镜像优化变得如此简单。