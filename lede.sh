#!/bin/bash

################################
addfeeds() {
cat <<EOF >>feeds.conf.default

src-git rtp2httpd https://github.com/stackia/rtp2httpd.git;main
#src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main

EOF
sed -i '/helloworld/c\' feeds.conf.default
#git clone https://github.com/luanmuc/luci-app-airoha-npu.git package/luci-app-airoha-npu
}

################################
# ./scripts/feeds update -a
# ./scripts/feeds install -a
################################

delpkg() {

for i in coremark luci-app-ddns ddns-scripts-services ddns-scripts_aliyun ddns-scripts_dnspod ddns-scripts luci-app-upnp luci-theme-design luci-app-autoreboot luci-app-filetransfer luci-app-vsftpd vsftpd miniupnpd-nftables luci-app-ssr-plus luci-app-vlmcsd vlmcsd luci-app-accesscontrol 3proxy xray-core microsocks iptables ip6tables kmod-ipt-nat6 kmod-ipt-raw iptables-mod-tproxy kmod-tun iptables-mod-extra luci-theme-argon airoha-pon-debug
do
  sed -i "/CONFIG_MODULE_DEFAULT_$i=/c\CONFIG_MODULE_DEFAULT_$i=n" .config
  sed -i "/CONFIG_PACKAGE_$i=/c\CONFIG_PACKAGE_$i=n" .config
  sed -i "s/$i //" include/target.mk
done
}

addpkg() {

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
CONFIG_PACKAGE_vmlinux-btf=y
EOF

cat <<EOF >> .config
CONFIG_PACKAGE_luci-app-nikki=y
CONFIG_PACKAGE_kmod-dummy=y
EOF
sed -i 's/+mihomo//' package/feeds/packages/nikki/Makefile
sed -i 's/+yq//' package/feeds/packages/nikki/Makefile

for i in kmod-airoha-xpon kmod-airoha-pon-frontend airoha-pond airoha-ponctl luci-app-pon
do
  echo "CONFIG_PACKAGE_$i=y" >> .config
done


}
################################
