#!/bin/bash

# 检查参数
if [ $# -lt 2 ]; then
    echo "使用方法: $0 <.config 文件路径> <包列表...>"
    echo "示例: $0 .config -luci -uhttpd -luci-app-uhttpd luci-nginx luci-base luci-mod-admin-full"
    exit 1
fi

CONFIG_FILE="$1"
shift # 移除第一个参数（配置文件名），剩下全是要操作的包

# 检查 .config 文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 错误: 找不到文件 $CONFIG_FILE"
    exit 1
fi

echo "🔄 正在处理配置文件: $CONFIG_FILE ..."

# 循环遍历传入的每一个包参数
for item in "$@"; do
    if [[ "$item" =~ ^- ]]; then
        # 1. 如果是以 '-' 开头，说明是需要删除/禁用的包
        PKG_NAME="${item#-}" # 去掉开头的 '-'
        
        # 将现有的配置改为 "is not set" 的注释形式，或者直接移除
        if grep -q "CONFIG_PACKAGE_${PKG_NAME}=" "$CONFIG_FILE"; then
            sed -i "s/CONFIG_PACKAGE_${PKG_NAME}=.*/# CONFIG_PACKAGE_${PKG_NAME} is not set/" "$CONFIG_FILE"
            echo "➖ 已禁用: $PKG_NAME"
        elif grep -q "# CONFIG_PACKAGE_${PKG_NAME} is not set" "$CONFIG_FILE"; then
            echo "ℹ️  已经处于禁用状态: $PKG_NAME"
        else
            # 如果文件中本来就没有，追加一行禁用声明
            echo "# CONFIG_PACKAGE_${PKG_NAME} is not set" >> "$CONFIG_FILE"
            echo "➖ 已添加禁用声明: $PKG_NAME"
        fi
    else
        # 2. 如果是正常的包名，说明是需要启用 (y) 的包
        PKG_NAME="$item"
        
        # 检查是否已经存在该配置
        if grep -q "CONFIG_PACKAGE_${PKG_NAME}=" "$CONFIG_FILE"; then
            sed -i "s/CONFIG_PACKAGE_${PKG_NAME}=.*/CONFIG_PACKAGE_${PKG_NAME}=y/" "$CONFIG_FILE"
            echo "➕ 已启用 (更新): $PKG_NAME"
        elif grep -q "# CONFIG_PACKAGE_${PKG_NAME} is not set" "$CONFIG_FILE"; then
            sed -i "s/# CONFIG_PACKAGE_${PKG_NAME} is not set/CONFIG_PACKAGE_${PKG_NAME}=y/" "$CONFIG_FILE"
            echo "➕ 已启用 (替换): $PKG_NAME"
        else
            # 如果文件中完全没有，直接追加
            echo "CONFIG_PACKAGE_${PKG_NAME}=y" >> "$CONFIG_FILE"
            echo "➕ 已追加启用: $PKG_NAME"
        fi
    fi
done

echo "✅ 处理完成！建议运行 'make defconfig' 让 OpenWrt 自动补全和优化依赖链。"
