#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

#========================================
# 【 diy-part2 内容：系统基础设置】
#========================================

# 修改默认IP
sed -i 's/192.168.1.1/10.1.10.1/g' package/base-files/files/bin/config_generate

# 开机自动开启 WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改 WiFi 名称
sed -i 's/ssid=OpenWrt/ssid=BlueFire/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改主机名
sed -i 's/OpenWrt/BlueFire/g' package/base-files/files/bin/config_generate

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 固件文件名添加日期
sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=$(shell TZ=UTC-8 date "+%Y%m%d")-$(VERSION_DIST_SANITIZED)/g' include/image.mk

#========================================
# 【 diy-part1 内容：添加插件 & 主题】
#========================================

# 移除冲突包，防止编译失败
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/packages/net/{vsftpd,vlmcsd,xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/luci/applications/{luci-app-vsftpd,luci-app-vlmcsd,luci-app-arpbind,luci-app-turboacc,luci-app-oaf,luci-app-openclash}

# Git稀疏克隆函数
git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set "$@"
  mv -f "$@" ../package/
  cd .. && rm -rf $repodir
}

# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone --depth=1 https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh

# 集合插件（kiddin9）
git_sparse_clone main https://github.com/kiddin9/op-packages \
  luci-app-oaf open-app-filter oaf \
  luci-app-arpbind \
  luci-app-vsftpd vsftpd \
  luci-app-vlmcsd vlmcsd \
  luci-app-usb3disable \
  luci-app-usb-printer \
  luci-app-turboacc

# 主题 Argon
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-theme-argon

# SQM 流量调度
git clone --depth=1 https://github.com/tohojo/sqm-scripts.git package/sqm-scripts

# 添加 helloworld 源
echo 'src-git helloworld https://github.com/fw876/helloworld' >> feeds.conf.default
