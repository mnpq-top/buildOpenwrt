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

CONFIG_PACKAGE_luci-app-airoha-npu=y

EOF

for i in i2c-tools libi2c
do
  sed -i "s/CONFIG_MODULE_DEFAULT_$i=/# CONFIG_MODULE_DEFAULT_$i is not set/g" .config
  sed -i "s/CONFIG_PACKAGE_$i=/# CONFIG_PACKAGE_$i is not set/g" .config
done

#for i in tc-full kmod-sched-core kmod-sched-act-vlan kmod-sched-flower
#do
#  echo "CONFIG_PACKAGE_$i=y" >> .config
#done
for i in luci uhttpd luci-app-uhttpd
do
  sed -i '/CONFIG_PACKAGE_$i=/d' .config
done
for i in luci-nginx luci-base luci-mod-admin-full
do
  echo "CONFIG_PACKAGE_$i=y" >> .config
done
for i in curl nano luci-proto-wireguard luci-app-https-dns-proxy
do
  echo "CONFIG_PACKAGE_$i=y" >> .config
done

echo 'CONFIG_PACKAGE_luci-app-rtp2httpd=y' >> .config

cat <<EOF >> .config
CONFIG_PACKAGE_luci-app-nikki=y
CONFIG_PACKAGE_kmod-dummy=y
#CONFIG_PACKAGE_yq=y
EOF
sed -i 's/+mihomo//' feeds/nikki/nikki/Makefile
sed -i 's/+yq//' feeds/nikki/nikki/Makefile

for i in kmod-airoha-xpon kmod-airoha-pon-frontend airoha-pond airoha-ponctl airoha-pon-debug luci-app-pon
do
  echo "CONFIG_PACKAGE_$i=y" >> .config
done

sed -i 's/CONFIG_PACKAGE_luci-theme-argon=y//' .config

#

