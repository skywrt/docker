#!/bin/bash

# 安装Python的pip工具
apt update
apt install -y python3-pip

# 使用pip安装Docker Compose
pip install docker-compose

# 验证安装
docker-compose --version
