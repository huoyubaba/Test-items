#!/bin/bash

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 免登录
# sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

#编译的固件文件名添加日期
sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=$(shell TZ=UTC-8 date "+%Y%m%d")-$(VERSION_DIST_SANITIZED)/g' include/image.mk

# 移除要替换的包
# rm -rf feeds/packages/net/smartdns
# rm -rf feeds/luci/themes/luci-theme-argon


# 更改 Argon 主题背景
# cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# 取消主题默认设置
# find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;

###### Git稀疏克隆
# 参数1是分支名, 参数2是仓库地址, 参数3是子目录，同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}
# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
# git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone https://github.com/ntlf9t/luci-app-easymesh.git package/luci-app-easymesh   # 简易联网
# git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-oaf open-app-filter oaf 
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-arpbind luci-app-vsftpd vsftpd 
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-vlmcsd vlmcsd luci-app-usb3disable luci-app-usb-printer

# Themes
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-theme-argon

# SmartDNS
# git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
# git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

#添加sqm
# git clone https://github.com/Plutonium141/luci-app-sqm.git package/luci-app-sqm #sqm流量整理
git clone https://github.com/tohojo/sqm-scripts.git package/sqm-scripts #sqm流量整理

# Add truboacc source
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# Add oaf
rm -rf package/OpenAppFilter
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

echo "CONFIG_PACKAGE_luci-app-oaf=y" >>.config
make defconfig
make -j1 V=s

./scripts/feeds update -a
./scripts/feeds install -a
