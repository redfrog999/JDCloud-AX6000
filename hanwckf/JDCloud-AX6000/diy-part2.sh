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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
##-----------------Add OpenClash dev core------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
##---------------------------------------------------------

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# 修改默认wifi名称ssid为MIWIFI_2022或自定义
#sed -i 's/ssid=OpenWrt/ssid=MIWIFI_2022/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改默认wifi密码key为123456789
# sed -i 's/encryption=none/encryption=sae-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# rm -rf lua-maxminddb
# git clone https://github.com/jerrykuku/lua-maxminddb

# 安装xiaorouji最新版Passwall
rm -rf luci-app-passwall
git clone https://github.com/xiaorouji/openwrt-passwall luci/applications/luci-app-passwall

# remove v2ray-geodata package from feeds (openwrt-22.03 & master)
rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/net/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#安装Alist为最新版
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-alist package/alist

