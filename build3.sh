#!/bin/bash

# 修改默认IP
# sed -i 's/192.168.1.1/10.0.10.1/g' package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 免登录
# sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

#编译的固件文件名添加日期
sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=$(shell TZ=UTC-8 date "+%Y%m%d")-$(VERSION_DIST_SANITIZED)/g' include/image.mk

# 移除要替换的包
# rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon



# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone https://github.com/ntlf9t/luci-app-easymesh.git package/luci-app-easymesh   # 简易联网
# git_sparse_clone master https://github.com/kiddin9/kwrt-packages luci-app-oaf open-app-filter oaf 
git_sparse_clone master https://github.com/kiddin9/kwrt-packages luci-app-arpbind luci-app-vsftpd vsftpd-alt 
git_sparse_clone master https://github.com/kiddin9/kwrt-packages luci-app-vlmcsd vlmcsd luci-app-usb3disable luci-app-usb-printer

# Themes
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# 更改 Argon 主题背景
cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# SmartDNS
# git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
# git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

#添加sqm
# git clone https://github.com/Plutonium141/luci-app-sqm.git package/luci-app-sqm #sqm流量整理
git clone https://github.com/tohojo/sqm-scripts.git package/sqm-scripts #sqm流量整理

# Add truboacc source

curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# 取消主题默认设置
find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;

./scripts/feeds update -a
./scripts/feeds install -a
