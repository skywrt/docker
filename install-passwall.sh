#!/bin/bash

# 在/tmp目录下新建一个myipk文件夹
mkdir /tmp/myipk
cd /tmp/myipk

# 下载Latest标签版本的openwrt-23.05主程序和语言包
wget https://github.com/xiaorouji/openwrt-passwall/releases/latest/download/luci-23.05_luci-app-passwall_4.77-6_all.ipk
wget https://github.com/xiaorouji/openwrt-passwall/releases/latest/download/luci-23.05_luci-i18n-passwall-zh-cn_git-24.152.54078-47d7784_all.ipk

# 检测本机器的具体架构
arch=$(opkg print-architecture | awk 'NR==3{print \$2}')
echo "Detected architecture: $arch"

# 根据架构下载对应的依赖压缩包
case $arch in
    x86_64)
        dep_pkg=passwall_packages_ipk_x86_64.zip
        ;;
    aarch64_cortex-a53 | aarch64_cortex-a72 | aarch64_generic | arm_cortex-a15_neon-vfpv4 | arm_cortex-a7 | arm_cortex-a7_neon-vfpv4 | arm_cortex-a8_vfpv3 | arm_cortex-a9 | arm_cortex-a9_neon | arm_cortex-a9_vfpv3 | mipsel_24kc | mipsel_74kc | mipsel_mips32 | mips_24kc | mips_4kec | mips_mips32)
        dep_pkg=passwall_packages_ipk_$arch.zip
        ;;
    *)
        echo "Unsupported architecture: $arch"
        exit 1
        ;;
esac

# 下载对应的依赖压缩包并解压
wget https://github.com/xiaorouji/openwrt-passwall/releases/latest/download/$dep_pkg
unzip $dep_pkg

# 安装所有ipk文件
opkg install *.ipk --force-reinstall
