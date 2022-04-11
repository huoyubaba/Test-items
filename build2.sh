#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: build2.sh
# Description: OpenWrt DIY script part 2 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# sed -i '$a src-git lede https://github.com/coolsnowwolf/lede/tree/master/package' feeds.conf.default
# sed -i '$a src-git kenzo https://github.com/kenzok8/jell' feeds.conf.default   #19.07 18.06 软件源
# sed -i '$a src-git kenzo https://github.com/kenzok8/small-package' feeds.conf.default   # 软件源
# git clone https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata
# git clone https://github.com/Thanf-code/luci-app-cpufreq.git package/luci-app-cpufreq
# git clone https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns  #smartdns DNS加速
# git clone https://github.com/iamaluckyguy/luci-app-smartinfo.git package/luci-app-smartinfo
git clone https://github.com/erdoukki/luci-app-arpbind.git package/luci-app-arpbind
# git clone https://github.com/zlg98/luci-app-vlmcsd.git package/luci-app-vlmcsd
git clone https://github.com/loryncien/luci-app-sqm.git package/luci-app-sqm
# svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-sqm package/luci-app-sqm
git clone https://github.com/ricsc/sqm-scripts.git package/sqm-scripts
# git clone https://github.com/kongfl888/luci-i18n-sqm-zh-cn.git package/luci-i18n-sqm-zh-cn
svn co https://github.com/kenzok8/small-package/trunk/luci-app-smartdns package/luci-app-smartdns
svn co https://github.com/kenzok8/small-package/trunk/smartdns package/smartdns
svn co https://github.com/kenzok8/small-package/trunk/luci-app-autoreboot package/luci-app-autoreboot
svn co https://github.com/kenzok8/small-package/trunk/luci-app-ramfree package/luci-app-ramfree
svn co https://github.com/kenzok8/small-package/trunk/luci-app-usb3disable package/luci-app-usb3disable
svn co https://github.com/kenzok8/jell/trunk/luci-app-accesscontrol package/luci-app-accesscontrol
svn co https://github.com/kenzok8/jell/trunk/luci-app-samba4 package/luci-app-samba4
svn co https://github.com/kenzok8/jell/trunk/autoshare-samba package/autoshare-samba
svn co https://github.com/kenzok8/jell/trunk/luci-app-usb-printer package/luci-app-usb-printer
svn co https://github.com/kenzok8/jell/trunk/luci-app-vsftpd package/luci-app-vsftpd
svn co https://github.com/kenzok8/jell/trunk/vsftpd-alt package/vsftpd-alt
svn co https://github.com/kenzok8/jell/trunk/luci-app-vlmcsd package/luci-app-vlmcsd
svn co https://github.com/kenzok8/jell/trunk/vlmcsd package/vlmcsd
