#!/bin/bash

# 在/tmp目录下新建一个myipk文件夹
mkdir -p /tmp/myipk
cd /tmp/myipk

# 下载Latest标签版本的openwrt-23.05主程序和语言包（只会下载更新的文件）
wget -N https://github.com/xiaorouji/openwrt-passwall/releases/latest/download/luci-23.05_luci-app-passwall_4.77-6_all.ipk
wget -N https://github.com/xiaorouji/openwrt-passwall/releases/latest/download/luci-23.05_luci-i18n-passwall-zh-cn_git-24.152.54078-47d7784_all.ipk

# 检测本机器的具体架构
arch=$(uname -m)
echo "Detected architecture: $arch"

# 根据架构下载对应的依赖压缩包
case $arch in
    x86_64)
        dep_pkg=passwall_packages_ipk_x86_64.zip
        ;;
    aarch64 | armv7l | mips)
        dep_pkg=passwall_packages_ipk_$arch.zip
        ;;
    *)
        echo "Unsupported architecture: $arch"
        exit 1
        ;;
esac

# 下载对应的依赖压缩包（只会下载更新的文件）并解压
wget -N https://github.com/xiaorouji/openwrt-passwall/releases/latest/download/$dep_pkg
unzip -o $dep_pkg  # 使用-o选项强制覆盖解压已存在的文件

# 安装所有ipk文件
opkg install *.ipk --force-reinstall
