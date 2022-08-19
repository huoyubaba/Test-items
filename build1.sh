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
# sed -i '$a src-git kenzo https://github.com/kenzok8/small-package' feeds.conf.default   # 软件源
# git clone https://github.com/erdoukki/luci-app-arpbind.git package/luci-app-arpbind
# git clone https://github.com/zlg98/luci-app-vlmcsd.git package/luci-app-vlmcsd
# git clone https://github.com/loryncien/luci-app-sqm.git package/luci-app-sqm
git clone https://github.com/loryncien/luci-app-sqm.git package/luci-app-sqm
git clone https://github.com/ricsc/sqm-scripts.git package/sqm-scripts
# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-smartdns package/luci-app-smartdns
# svn co https://github.com/kiddin9/openwrt-packages/trunk/smartdns package/smartdns
svn co https://github.com/kiddin9/openwrt-packages/trunk/applications/luci-app-vlmcsd package/luci-app-vlmcsd
svn co https://github.com/kiddin9/openwrt-packages/trunk/vlmcsd package/vlmcsd
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-samba4 package/luci-app-samba4
svn co https://github.com/kiddin9/openwrt-packages/trunk/autoshare-samba package/autoshare-samba
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-vsftpd package/luci-app-vsftpd
svn co https://github.com/kenzok8/jell/trunk/vsftpd-alt package/vsftpd-alt
svn co https://github.com/kenzok8/small-package/trunk/luci-app-autoreboot package/luci-app-autoreboot
svn co https://github.com/kenzok8/small-package/trunk/luci-app-ramfree package/luci-app-ramfree
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-usb3disable package/luci-app-usb3disable
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-accesscontrol package/luci-app-accesscontrol
svn co https://github.com/kenzok8/jell/trunk/luci-app-usb-printer package/luci-app-usb-printer
