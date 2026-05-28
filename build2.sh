#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改默认IP
sed -i 's/192.168.1.1/10.1.10.1/g' package/base-files/files/bin/config_generate

# 开机自动开启 WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改 WiFi 名称
sed -i 's/ssid=OpenWrt/ssid=BlueFire/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改主机名
sed -i 's/OpenWrt/BlueFire/g' package/base-files/files/bin/config_generate

# 移除冲突插件，防止编译失败
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/luci/applications/luci-app-openclash

# 添加 helloworld 源（passwall/ssr++ 依赖）
echo 'src-git helloworld https://github.com/fw876/helloworld' >> feeds.conf.default

# 固件文件名自动加日期
sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=$(shell TZ=UTC-8 date "+%Y%m%d")-$(VERSION_DIST_SANITIZED)/g' include/image.mk

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/config
