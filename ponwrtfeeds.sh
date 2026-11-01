#!/bin/bash
cat <<EOF >>feeds.conf.default

src-git rtp2httpd https://github.com/stackia/rtp2httpd.git;main
src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main

EOF

git clone https://github.com/luanmuc/luci-app-airoha-npu.git package/luci-app-airoha-npu

################################
./scripts/feeds update -a
./scripts/feeds install -a
################################

cat <<EOF >> .config

#CONFIG_SDK=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_kmod-tls=y
CONFIG_LUCI_LANG_zh_Hans=y

CONFIG_PACKAGE_nginx-full=y

CONFIG_PACKAGE_luci-proto-wireguard=y

CONFIG_PACKAGE_luci-app-https-dns-proxy=y

CONFIG_PACKAGE_luci-app-airoha-npu=y

CONFIG_PACKAGE_luci-app-rtp2httpd=y

CONFIG_PACKAGE_luci-app-nikki=y
CONFIG_PACKAGE_kmod-dummy=y

EOF
sed -i 's/+mihomo//' feeds/nikki/nikki/Makefile
sed -i 's/+yq//' feeds/nikki/nikki/Makefile

sed -i 's/CONFIG_PACKAGE_airoha-pon-debug=y//' .config
sed -i 's/CONFIG_PACKAGE_luci-theme-argon=y//' .config
