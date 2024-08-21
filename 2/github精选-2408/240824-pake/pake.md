25.2k star,开源神器，一键将网页打包为桌面程序

这个项目是一位前端大佬开源的，看几个示例你就明白是干嘛的了

![微信阅读桌面版](image.png)

![桌面版本小红书](image-1.png)

![桌面版ytb](image-2.png)

是的上面这些桌面版本的程序都是用今天要介绍的这款工具生成的，你还可以生成任何你日常经常浏览的站点。

>项目地址：https://github.com/tw93/Pake

## pake项目简介

pake是一款用rust开发的用来构建轻量级桌面应用的工具，同时支持mac、linux、windows。

具体使用可以参考如下：（将一个博客打包为可以桌面应用）

![](pake.gif)

## 如何安装

下载量是真的高，因为作为已经打包好了一些应用，有需要的可以直接去下载成品。

 ![](https://img.shields.io/github/downloads/tw93/Pake/total?style=flat-square)

如果熟悉rust，而且动手能力不错的话，可以通过命令行自行打包

操作如下：

```
# Install with npm
npm install -g pake-cli

# Command usage
pake url [OPTIONS]...

# Feel free to play with Pake! It might take a while to prepare the environment the first time you launch Pake.
pake 具体链接 --name 程序名 --hide-title-bar
```

作者也提供了另外一种方式打包，就是可以使用 GitHub Actions 在线编译包，或许这个对于普通用户更复杂？

## pake功能特点

- 类似的工具你可能知道Electron，这款比之封装的大小更小，小了约20倍
- 使用rust语言开发，所以比js效率更高，更轻

## 目前github star数

 ![](https://img.shields.io/github/stars/tw93/Pake?style=flat-square)

 目前该项目获得了25.2k star