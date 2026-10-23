#!/bin/bash

cat <<EOF >> .config

CONFIG_SDK=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_kmod-tls=y

CONFIG_PACKAGE_kmod-tun=y
CONFIG_PACKAGE_kmod-tcp-bbr=y
CONFIG_PACKAGE_kmod-nf-flow=y
CONFIG_PACKAGE_kmod-nft-tproxy=y
CONFIG_PACKAGE_kmod-nft-offload=y

CONFIG_PACKAGE_kmod-wireguard=y
CONFIG_PACKAGE_luci-proto-wireguard=y

CONFIG_PACKAGE_luci-app-airoha-npu=y

EOF
