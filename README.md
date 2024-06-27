### Docker安装
一键安装命令
```
curl -fsSL https://github.com/skywrt/docker/releases/download/latest/linux.sh| bash -s docker --mirror Aliyun
```
### 部署或更新脚本

> 脚本支持重复执行

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/skywrt/docker/main/install.sh)"
```
### 卸载脚本

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/skywrt/docker/main/uninstall.sh)"
```
