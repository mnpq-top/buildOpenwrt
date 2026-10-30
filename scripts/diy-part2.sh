#!/bin/bash

cat <<EOF >> .config

#CONFIG_SDK=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_kmod-tls=y
CONFIG_PACKAGE_luci-i18n-base-zh-cn=y

#CONFIG_PACKAGE_qosify=y

CONFIG_PACKAGE_luci-proto-wireguard=y

CONFIG_PACKAGE_luci-app-airoha-npu=y
#CONFIG_PACKAGE_luci-app-nikki=y

CONFIG_PACKAGE_luci-app-passwall=y

#
# Configuration
#
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Haproxy=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Hysteria is not set
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_NaiveProxy is not set
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Client=y
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Server=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadow_TLS is not set
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Simple_Obfs=y
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SmartDNS=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Geodata is not set
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Geoview=y
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Plugin=y
#CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray_Plugin is not set
# end of Configuration

EOF

sed -i 's/CONFIG_PACKAGE_luci-theme-argon=y//' .config
