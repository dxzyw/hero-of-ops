 黑客或者安全在用的kali linux是怎样，安装
 
 ## kali Linux的历史

Kali Linux由Offensive Security公司维护,可以追溯到BackTrack Linux这个著名的渗透测试发行版。BackTrack于2006年首次发布,基于Knoppix,集成了许多安全工具。它因功能强大而深受安全研究人员的喜爱。

后来,BackTrack的开发团队决定对其进行重构,于2012年发布了Kali Linux的第一个版本。Kali Linux基于Debian,对各种安全工具进行了优化集成,使其成为新一代完备的渗透测试系统。

直到今天,Kali Linux已经发展成为网络安全领域最流行和强大的Linux发行版之一。它拥有超过600种预装的安全工具,覆盖了漏洞评估、逆向工程等方面的需求。每年都会发布新的版本,不断优化和增强功能。



**不建议个人用户使用，仅仅建议用作测试，实际它自身带有攻击性，但不具备防御性**


## 简要介绍几个Kali Linux的主要特点:

1. 预装了大量网络安全工具软件,覆盖信息收集、漏洞扫描、密码破解、无线测试等方面,非常全面。

2. 基于Debian,系统稳定性好。并针对安全工具做了优化,如内核补丁等。

3. 默认禁用了对新用户不友好的功能,比如root账户SSH远程登录。可以减少安全风险。

4. 提供了方便的工具管理功能,可以快速安装/删除工具。并有Metapackages将相关工具分类打包。

5. 界面设计友好,自带一些方便的小工具。还可以切换到经典的KDE桌面。

6. 硬件兼容性好,支持主流的无线网卡芯片,可用于无痕渗透。

7. 专为安全研究人员和pentester设计,但也可作为日常使用的Linux发行版。

8. 有专门的Kali NetHunter版本,可安装在手机等移动设备上,进行移动渗透测试。

9. 社区活跃,定期更新版本,作为专业渗透测试系统值得信赖。


1. ## 虚拟机安装

1. 创建新的虚拟机

![](https://files.mdnice.com/user/46581/69450d04-7d14-4a69-a875-eb588825cff1.png)


2. 新建虚拟机向导选择自定义
![](https://files.mdnice.com/user/46581/2e9926e8-93fa-4ce9-ac5f-57d31226454b.png)

3. 直接点击下一步

![](https://files.mdnice.com/user/46581/6a4f9088-c1ac-4fbd-9423-d353f45bcd37.png)

4. 操作系统选择稍后安装操作系统


![](https://files.mdnice.com/user/46581/2e765948-616a-4f52-9a57-7bad50457b15.png)


5. 选择linux系统，系统版本选择debian10.x就好


![](https://files.mdnice.com/user/46581/db729b0f-adf5-47ef-86e9-ffd001cf6f32.png)

6. 

![](https://files.mdnice.com/user/46581/8053b1d4-0875-4b86-b158-0a46e1abda00.png)

7. 设置处理器配置，可以默认，后面还是可以调整的


![](https://files.mdnice.com/user/46581/a1387c5c-00a6-4ac6-b4d2-18d2430004d1.png)


8. 虚拟机的内存同理


![](https://files.mdnice.com/user/46581/a5e96b92-a760-4caf-883a-795dc05320bf.png)


9. 网络类型建议选择nat网络模式，可以直接复用主机的网络


![](https://files.mdnice.com/user/46581/4ae57182-b336-4361-ac61-87b28344388a.png)


10. 根据默认选择就好


![](https://files.mdnice.com/user/46581/2adc7d66-d030-4a55-8379-91ac98ba1ca5.png)


11. 根据默认选择就好

![](https://files.mdnice.com/user/46581/7723f1ad-37a7-44fa-93ce-7e82cdf7fed8.png)


12. 创建新的虚拟磁盘


![](https://files.mdnice.com/user/46581/14c16a3d-19c4-457b-b021-df4b27709f1e.png)


13. 可以根据需要配置需要的磁盘大小，默认20G，建议选择40G，不然安装软件会失败


![](https://files.mdnice.com/user/46581/7c73fa04-cac3-417b-81ad-44b1aae0ef4c.png)

14. 直接点击下一步就好



![](https://files.mdnice.com/user/46581/95f0ffb1-cb11-4c8e-b82e-49d072308a5b.png)


15. 到这步基本的配置就结束了



![](https://files.mdnice.com/user/46581/92813254-127d-42f5-bc76-c6df7c260359.png)


16. 如有需要调整的，可以点击配置



![](https://files.mdnice.com/user/46581/f121b165-5c02-48b9-b8da-5c8c87b39efb.png)



17. 在DVD可以修改iso镜像地址的路径


![](https://files.mdnice.com/user/46581/789d7c3b-ebe8-4600-8163-55af17b6b857.png)



18. 到这步就可以点击开启虚拟机了


![](https://files.mdnice.com/user/46581/6daa85c0-bd61-4d7e-b87d-b181295f74f3.png)

## 安装debian

1. graphical install有图行安装，install无图形安装。

![](https://files.mdnice.com/user/46581/87931e5d-1990-498b-a4f4-126c403e52c1.png)

2. 选择中文简体
![](https://files.mdnice.com/user/46581/5b21417c-4564-401b-b85e-29e80ade872b.png)

3. 根据需要选择即可，继续

![](https://files.mdnice.com/user/46581/a47f7bb0-8ecc-4850-b594-f5f9de6df780.png)
4. 这里选择汉语，可以根据需要选择

![](https://files.mdnice.com/user/46581/b18f6203-bca1-4743-974f-a45a063a93af.png)
5. 开始探测挂载安装介质

![](https://files.mdnice.com/user/46581/5186b588-6c35-4519-84f1-bfd3bcab7ba4.png)
6. 配置网络

![](https://files.mdnice.com/user/46581/5bf54f57-e690-4636-bf1d-2283b2ac572e.png)
7. 设置主机名，根据需要就好

![](https://files.mdnice.com/user/46581/a0c71df1-e886-4c59-a153-0dbb94010a75.png)

8. 忽略，不需要操作
![](https://files.mdnice.com/user/46581/d758d46f-6de6-4246-ab82-ddd947c07810.png)

9. 设置用户和密码

![](https://files.mdnice.com/user/46581/c39f4c35-0809-4bc5-a91e-1fc60f3d37ae.png)

10. 配置时钟

![](https://files.mdnice.com/user/46581/f8752d7b-3fec-47d2-941e-1a8049d973eb.png)
11. 磁盘分区设置，一路继续即可

![](https://files.mdnice.com/user/46581/63ddee6e-d629-4183-beb5-c2dc34fad177.png)


![](https://files.mdnice.com/user/46581/7eb55a7b-ed0f-48cd-bc28-0ae8945c8f76.png)


![](https://files.mdnice.com/user/46581/411b8d64-40d2-4a16-9efe-cf8b06107b8e.png)


![](https://files.mdnice.com/user/46581/828207fc-26b3-4abc-bd0b-4370f1d23eab.png)


![](https://files.mdnice.com/user/46581/09f09553-1ae0-4625-93a9-a1b592ff0998.png)



![](https://files.mdnice.com/user/46581/411b8d64-40d2-4a16-9efe-cf8b06107b8e.png)
12.  选中要安装的软件
![](https://files.mdnice.com/user/46581/b28c9fbc-2c5e-4154-9e3d-46ce2949a21f.png)

13. 系统安装中

![](https://files.mdnice.com/user/46581/8ac56768-f559-4e95-94dc-ea2a17527d92.png)


14. 如果遇到如下报错，有可能是需要调整apt源，如下方式调整


![](https://files.mdnice.com/user/46581/db62ace7-cb9d-454b-9086-93f0888e262b.png)

15. 进入shell

![](https://files.mdnice.com/user/46581/0d35fcb6-be46-4b14-a7f0-b5b830c0ef8e.png)

16. 

![](https://files.mdnice.com/user/46581/ac4afaa0-fa89-4534-b2e3-8c8f6ae8ea18.png)

```
chroot /target
nano /etc/apt/sources.list

```

可以使用如下源：

```
deb http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
deb-src http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
```


![](https://files.mdnice.com/user/46581/8b4a355d-59f5-4478-848f-c8cc5c401fbb.png)


使用ctrl+o 保存 然后回车 ，按ctrl+x 退出

重新选择安装软件，继续安装，还有一种可能是没有空间了，建议最开始选择40G


17. 安装grub引导


![](https://files.mdnice.com/user/46581/3e95dd68-728d-4561-8046-93ad178a8f85.png)
 
![](https://files.mdnice.com/user/46581/40265c2e-80bd-4cf0-893f-da76e56ffe81.png)

18. 安装完成


![](https://files.mdnice.com/user/46581/a135133f-2ea5-4568-bd1d-4c41339b44c7.png)


## 系统启动


![](https://files.mdnice.com/user/46581/2f86f79e-5513-464f-b72c-6fd6b8ca2ff8.png)

输入前面新建的普通用户


![](https://files.mdnice.com/user/46581/a9a7513e-6537-42e4-8c47-3719830dab0e.png)

系统界面


![](https://files.mdnice.com/user/46581/52453660-c569-4aef-ad8b-3450bd958ab5.png)

可以看到自带了很多安全工具 


![](https://files.mdnice.com/user/46581/94f75031-a45f-48b1-aff0-0b98926f65d8.png)

终端看起来也是很舒服的


![](https://files.mdnice.com/user/46581/b9794c94-a326-4fa0-a24b-8138ceed8fcb.png)

自带了一些酷炫的桌面


![](https://files.mdnice.com/user/46581/b95d4854-3f08-434b-b538-9593308f8f4b.png)


![](https://files.mdnice.com/user/46581/ee2239ed-5343-4ed6-bb3b-d2931ac09617.png)

