#!/bin/bash

cat <<EOF >> .config

#CONFIG_SDK=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_kmod-tls=y
CONFIG_LUCI_LANG_zh_Hans=y

#CONFIG_PACKAGE_qosify=y
CONFIG_PACKAGE_nginx-full=y

CONFIG_PACKAGE_luci-proto-wireguard=y

CONFIG_PACKAGE_luci-app-https-dns-proxy=y

CONFIG_PACKAGE_luci-app-airoha-npu=y
CONFIG_PACKAGE_luci-app-rtp2httpd=y
CONFIG_PACKAGE_luci-app-nikki=y


EOF

sed -i 's/CONFIG_PACKAGE_luci-theme-argon=y//' .config
