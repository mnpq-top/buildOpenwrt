#!/bin/bash

cat <<EOF >> .config

#CONFIG_SDK=y
CONFIG_PACKAGE_nano=y
#CONFIG_PACKAGE_kmod-tls=y

#CONFIG_PACKAGE_luci-proto-wireguard=y

CONFIG_PACKAGE_luci-app-airoha-npu=y

CONFIG_PACKAGE_luci-theme-argon=n
EOF
