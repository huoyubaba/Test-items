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
# sed -i '$a src-git applications https://github.com/coolsnowwolf/luci/tree/master/applications' feeds.conf.default  # 软件源
# sed -i '$a src-git packages https://github.com/openwrt/packages' feeds.conf.default   # 基础包
# sed -i '$a src-git kenzo https://github.com/kenzok8/small-package' feeds.conf.default   # 软件源
svn co https://github.com/coolsnowwolf/luci/tree/master/applications/luci-app-smartdns package/luci-app-smartdns
svn co https://github.com/coolsnowwolf/luci/tree/master/applications/luci-app-sqm package/luci-app-sqm
