#!/bin/bash
cat <<EOF >>feeds.conf.default

#src-git rtp2httpd https://github.com/stackia/rtp2httpd.git;main
src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main

EOF

#git clone https://github.com/luanmuc/luci-app-airoha-npu.git package/luci-app-airoha-npu

################################
./scripts/feeds update -a
./scripts/feeds install -a
################################

cat <<EOF >> .config
#CONFIG_SDK=y
CONFIG_LUCI_LANG_zh_Hans=y
CONFIG_PACKAGE_luci-proto-wireguard=y
CONFIG_PACKAGE_luci-app-https-dns-proxy=y
CONFIG_PACKAGE_luci-app-airoha-npu=y
EOF

for i in curl nano nginx-full
do
  echo "CONFIG_PACKAGE_$i=y" >> .config
done

echo 'CONFIG_PACKAGE_luci-app-rtp2httpd=y' >> .config
sed -i '/PKG_VERSION:=/c\PKG_VERSION:=3.17.2' package/feeds/packages/rtp2httpd/Makefile
sed -i '/PKG_HASH:=/c\PKG_HASH:=ce866091321a0d69dff7e8f7dda5d68be94e901659ed7d2ff4896029c8200ee6' package/feeds/packages/rtp2httpd/Makefile

cat <<EOF >> .configg
#CONFIG_PACKAGE_luci-app-honk=y
CONFIG_PACKAGE_kmod-sched-core=y
CONFIG_PACKAGE_kmod-sched-bpf=y
CONFIG_PACKAGE_kmod-veth=y
CONFIG_PACKAGE_kmod-nft-queue=y
CONFIG_PACKAGE_vmlinux-btf=y
EOF

cat <<EOF >> .config
CONFIG_PACKAGE_luci-app-nikki=y
CONFIG_PACKAGE_kmod-dummy=y
EOF
sed -i 's/+mihomo//' feeds/nikki/nikki/Makefile
sed -i 's/+yq//' feeds/nikki/nikki/Makefile

for i in kmod-airoha-xpon kmod-airoha-pon-frontend airoha-pond airoha-ponctl luci-app-pon
do
  echo "CONFIG_PACKAGE_$i=y" >> .config
done
sed -i 's/CONFIG_PACKAGE_airoha-pon-debug=y//' .config
sed -i 's/CONFIG_PACKAGE_luci-theme-argon=y//' .config

#

