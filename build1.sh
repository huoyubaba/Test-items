#!/bin/bash
# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/config
# 移除要替换的包（防止冲突）
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/packages/net/{vsftpd,vlmcsd}
rm -rf feeds/luci/applications/{luci-app-vsftpd,luci-app-vlmcsd,luci-app-arpbind,luci-app-turboacc,luci-app-oaf}
# 移除冲突插件，防止编译失败
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
rm -rf feeds/luci/applications/luci-app-openclash

# Git稀疏克隆（通用函数，别动）
git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set "$@"
  mv -f "$@" ../package/
  cd .. && rm -rf $repodir
}

# 添加插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone --depth=1 https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# 集合插件（kiddin9）
git_sparse_clone main https://github.com/kiddin9/op-packages \
  luci-app-arpbind \
  luci-app-vsftpd vsftpd \
  luci-app-vlmcsd vlmcsd \
  luci-app-usb3disable \
  luci-app-usb-printer \
  luci-app-turboacc

# 主题 Argon
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-theme-argon

# SQM 流量管理
git clone --depth=1 https://github.com/tohojo/sqm-scripts.git package/sqm-scripts
