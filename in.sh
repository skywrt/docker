#!/bin/bash

# 安装 Docker
安装_docker() {
    echo "正在安装 Docker..."
    curl -fsSL https://github.com/skywrt/docker/releases/download/latest/linux.sh | bash -s docker --mirror Aliyun
}

# 部署小雅服务
部署_xiaoya() {
    echo "正在部署小雅服务..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/skywrt/docker/main/install.sh)"
}

# 卸载小雅服务
卸载_xiaoya() {
    echo "正在卸载小雅服务..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/skywrt/docker/main/uninstall.sh)"
}

# 运行小雅转存清理工具
运行_xiaoya_清理工具() {
    echo "正在运行小雅转存清理工具..."
    bash -c "$(curl -sLk https://xiaoyahelper.ddsrem.com/aliyun_clear.sh | tail -n +2)" -s 5
}

# 主脚本
echo "欢迎使用设置脚本!"

# 选择操作
echo "请选择要执行的操作:"
echo "1. 安装 Docker"
echo "2. 部署小雅服务"
echo "3. 卸载小雅服务"
echo "4. 运行小雅转存清理工具"
echo "5. 退出"

read -p "请输入您的选择 [1-5]: " choice

case $choice in
    1)
        安装_docker
        ;;
    2)
        部署_xiaoya
        ;;
    3)
        卸载_xiaoya
        ;;
    4)
        运行_xiaoya_清理工具
        ;;
    5)
        echo "退出脚本."
        exit 0
        ;;
    *)
        echo "无效的选择. 退出."
        exit 1
        ;;
esac

echo "设置脚本完成."
