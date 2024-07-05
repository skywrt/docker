#!/bin/bash

# PVE扩容
lvremove pve/data
lvextend -l +100%FREE -r pve/root
resize2fs /dev/mapper/pve-root

# 备份源文件
cp /etc/apt/sources.list /etc/apt/sources.list_bak

# 编辑sources.list
echo "deb https://mirrors.ustc.edu.cn/debian/ bookworm main contrib non-free" > /etc/apt/sources.list
echo "deb https://mirrors.ustc.edu.cn/debian/ bookworm-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb https://mirrors.ustc.edu.cn/debian/ bookworm-backports main contrib non-free" >> /etc/apt/sources.list
echo "deb https://mirrors.ustc.edu.cn/debian-security/ bookworm-security main contrib non-free" >> /etc/apt/sources.list

# 编辑pve企业源
echo "deb https://mirrors.ustc.edu.cn/proxmox/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-enterprise.list

# 添加pve无订阅源
echo "deb https://mirrors.ustc.edu.cn/proxmox/debian/ceph-quincy bookworm no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list

# 更新列表并升级
apt update && apt dist-upgrade -y

# 修复源401错误
echo "deb https://mirrors.ustc.edu.cn/proxmox/debian/ceph-quincy bookworm no-subscription" > /etc/apt/sources.list.d/ceph.list

# 再次更新
apt update && apt dist-upgrade -y

# 更换LXC国内源
cp /usr/share/perl5/PVE/APLInfo.pm /usr/share/perl5/PVE/APLInfo.pm_back
sed -i 's|http://download.proxmox.com|https://mirrors.ustc.edu.cn/proxmox|g' /usr/share/perl5/PVE/APLInfo.pm

# 询问是否重启PVE
read -p "是否要重启PVE？(Y/N) " choice
case "$choice" in
  y|Y ) reboot ;;
  n|N ) echo "已完成更新，未重启PVE。" ;;
  * ) reboot ;;
esac
