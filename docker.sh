#!/bin/bash

# 检查docker服务是否存在，不存在则询问用户是否安装，不安装退出脚本
if ! command -v docker &> /dev/null; then
    if [ "$(uname -o)" = "Darwin" ]; then
        echo "Docker 未安装，请安装 Docker 后再运行脚本"
        exit 1
    fi
    read -rp "Docker 未安装，是否安装？(y/n): " install
    install=${install:-y}
    if [ "$install" = "y" ]; then
        echo "安装 Docker..."
        curl -fsSL https://github.com/skywrt/docker/releases/download/latest/docker.sh | bash -s docker --mirror Aliyun
        systemctl enable docker
        systemctl start docker
    else
        echo "退出安装"
        exit 1
    fi
fi

# 检查是否安装了 compose 插件，docker compose 命令
if ! docker compose &> /dev/null && ! which docker-compose &> /dev/null; then
    read -rp "Docker Compose 未安装，是否安装？(y/n): " install
    install=${install:-y}
    if [ "$install" = "y" ]; then
        echo "安装 Docker Compose..."
        # 判断系统是 x86 还是 arm，arm 有很多种类，都要判断
        if [ "$(uname -m)" = "aarch64" ]; then
            file=docker-compose-linux-aarch64
        elif [ "$(uname -m)" = "x86_64" ]; then
            file=docker-compose-linux-x86_64
        else
            echo "不支持的系统架构 $(uname -m)，请自行安装 Docker Compose（https://docs.docker.com/compose/install/linux/#install-using-the-repository）"
            exit 1
        fi
        
        # 获取最新版本号
        latest_version=$(curl -sSLI -o /dev/null -w '%{url_effective}' https://github.com/docker/compose/releases/latest | awk -F '/' '{print $NF}')
        
        # 下载并安装最新版本
        curl -SL "https://github.com/docker/compose/releases/download/${latest_version}/$file" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
    else
        echo "退出安装"
        exit 1
    fi
fi

# 如果 Docker 和 Docker Compose 已安装，则提示用户按任意键返回主菜单
if command -v docker &> /dev/null && (docker compose &> /dev/null || which docker-compose &> /dev/null); then
    read -n 1 -s -r -p "Docker 和 Docker Compose 已安装，请按任意键返回主菜单..."
    echo
fi
