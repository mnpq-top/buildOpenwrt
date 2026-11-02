#!/bin/bash
cat <<EOF >>feeds.conf.default

src-git rtp2httpd https://github.com/stackia/rtp2httpd.git;main
src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main

EOF

#git clone https://github.com/luanmuc/luci-app-airoha-npu.git package/luci-app-airoha-npu

################################
./scripts/feeds update -a
./scripts/feeds install -a
################################

cat <<EOF >> .config

#CONFIG_SDK=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_nano=y
CONFIG_LUCI_LANG_zh_Hans=y

CONFIG_PACKAGE_nginx=y

CONFIG_PACKAGE_luci-proto-wireguard=y

CONFIG_PACKAGE_luci-app-https-dns-proxy=y

CONFIG_PACKAGE_luci-app-airoha-npu=y

CONFIG_PACKAGE_luci-app-rtp2httpd=y

EOF

cat <<EOF >> .configg
#CONFIG_PACKAGE_luci-app-honk=y
CONFIG_PACKAGE_kmod-sched-core=y
CONFIG_PACKAGE_kmod-sched-bpf=y
CONFIG_PACKAGE_kmod-veth=y
CONFIG_PACKAGE_kmod-nft-queue=y
EOF

cat <<EOF >> .config
CONFIG_PACKAGE_luci-app-nikki=y
CONFIG_PACKAGE_kmod-dummy=y
EOF
sed -i 's/+mihomo//' package/feeds/packages/nikki/Makefile
sed -i 's/+yq//' package/feeds/packages/nikki/Makefile

cat <<EOF >> .config
CONFIG_PACKAGE_kmod-airoha-xpon=y
CONFIG_PACKAGE_kmod-airoha-pon-frontend=y
CONFIG_PACKAGE_airoha-pond=y
CONFIG_PACKAGE_airoha-ponctl=y
CONFIG_PACKAGE_luci-app-pon=y
EOF
sed -i 's/CONFIG_PACKAGE_airoha-pon-debug=y//' .config
sed -i 's/CONFIG_PACKAGE_luci-theme-argon=y//' .config

#
