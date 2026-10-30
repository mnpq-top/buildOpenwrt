#!/bin/bash


cat <<EOF >>feeds.conf.default

src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main

EOF

git clone https://github.com/luanmuc/luci-app-airoha-npu.git package/luci-app-airoha-npu

