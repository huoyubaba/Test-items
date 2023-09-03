#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: build1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# sed -i '$a src-git luci https://github.com/coolsnowwolf/luci' feeds.conf.default  # 软件源
# sed -i '$a src-git packages https://github.com/openwrt/packages' feeds.conf.default   # 基础包
# sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages' feeds.conf.default   # 软件源
# git clone https://github.com/Plutonium141/luci-app-sqm.git package/luci-app-sqm #sqm流量整理
git clone https://github.com/tohojo/sqm-scripts.git package/sqm-scripts #sqm流量整理
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-smartdns package/luci-app-smartdns #smartdns DNS加速
svn co https://github.com/kiddin9/openwrt-packages/trunk/smartdns package/smartdns #smartdns DNS加速
# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome #adguardhome 广告拦截 DNS加速
# svn co https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome #adguardhome 广告拦截 DNS加速
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-vlmcsd package/luci-app-vlmcsd  #kms 激活服务
svn co https://github.com/kiddin9/openwrt-packages/trunk/vlmcsd package/vlmcsd  #kms 激活服务
# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-samba4 package/luci-app-samba4  #网络共享 服务器
# svn co https://github.com/kiddin9/openwrt-packages/trunk/autoshare-samba package/autoshare-samba  #网络共享 自动挂载服务
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-vsftpd package/luci-app-vsftpd  #网络ftp共享 服务器
svn co https://github.com/kiddin9/openwrt-packages/trunk/vsftpd-alt package/vsftpd-alt  #网络共享 ftp服务文件
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-arpbind package/luci-app-arpbind   #IP/MAC绑定服务
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-oaf package/luci-app-oaf  #控制访问页面
svn co https://github.com/kiddin9/openwrt-packages/trunk/open-app-filter package/open-app-filter   #控制访问页面
svn co https://github.com/kiddin9/openwrt-packages/trunk/oaf package/oaf   #控制访问页面
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-usb3disable package/luci-app-usb3disable  #禁用USB3.0
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-usb-printer package/luci-app-usb-printer    #USB打印服务
svn co https://github.com/tcsr200722/luci-app-samba package/luci-app-samba  # 网络共享服务3.6

git clone https://github.com/ntlf9t/luci-app-easymesh.git package/luci-app-easymesh   # 简易联网

# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-turboacc package/luci-app-turboacc   #网络加速附带插件
# svn co https://github.com/kiddin9/openwrt-packages/trunk/pdnsd-alt package/pdnsd-alt
# svn co https://github.com/kiddin9/openwrt-packages/trunk/dnsforwarder package/dnsforwarder
# svn co https://github.com/kiddin9/openwrt-packages/trunk/shortcut-fe package/shortcut-fe   #网络加速附带插件

# Add truboacc source
mkdir -p turboacc_tmp ./package/turboacc
cd turboacc_tmp 
git clone https://github.com/chenmozhijin/turboacc -b package
cd ../package/turboacc
git clone https://github.com/fullcone-nat-nftables/nft-fullcone
git clone https://github.com/chenmozhijin/turboacc
mv ./turboacc/luci-app-turboacc ./luci-app-turboacc
rm -rf ./turboacc
cd ../..
cp -f turboacc_tmp/turboacc/hack-5.15/952-add-net-conntrack-events-support-multiple-registrant.patch ./target/linux/generic/hack-5.15/952-add-net-conntrack-events-support-multiple-registrant.patch
cp -f turboacc_tmp/turboacc/hack-5.15/953-net-patch-linux-kernel-to-support-shortcut-fe.patch ./target/linux/generic/hack-5.15/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
cp -f turboacc_tmp/turboacc/pending-5.15/613-netfilter_optional_tcp_window_check.patch ./target/linux/generic/pending-5.15/613-netfilter_optional_tcp_window_check.patch
rm -rf ./package/libs/libnftnl ./package/network/config/firewall4 ./package/network/utils/nftables
mkdir -p ./package/network/config/firewall4 ./package/libs/libnftnl ./package/network/utils/nftables
cp -r ./turboacc_tmp/turboacc/shortcut-fe ./package/turboacc
cp -RT ./turboacc_tmp/turboacc/firewall4-$(grep -o 'FIREWALL4_VERSION=.*' ./turboacc_tmp/turboacc/version | cut -d '=' -f 2)/firewall4 ./package/network/config/firewall4
cp -RT ./turboacc_tmp/turboacc/libnftnl-$(grep -o 'LIBNFTNL_VERSION=.*' ./turboacc_tmp/turboacc/version | cut -d '=' -f 2)/libnftnl ./package/libs/libnftnl
cp -RT ./turboacc_tmp/turboacc/nftables-$(grep -o 'NFTABLES_VERSION=.*' ./turboacc_tmp/turboacc/version | cut -d '=' -f 2)/nftables ./package/network/utils/nftables
rm -rf turboacc_tmp
