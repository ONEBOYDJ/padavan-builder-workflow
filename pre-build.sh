#!/bin/bash
# Отключить CAN support в busybox (несовместимо с ядром 3.4 MT7628)
BB_CONFIG="padavan-ng/trunk/user/busybox/busybox-1.37.0/.config"
if [ -f "$BB_CONFIG" ]; then
  sed -i 's/CONFIG_FEATURE_IP_LINK=y/# CONFIG_FEATURE_IP_LINK is not set/' "$BB_CONFIG"
fi

# Также можно через defconfig
BB_DEFCONFIG=$(find padavan-ng/trunk/user/busybox/ -name "config" -path "*/configs/*" | head -1)
if [ -f "$BB_DEFCONFIG" ]; then
  sed -i 's/CONFIG_FEATURE_IP_LINK=y/# CONFIG_FEATURE_IP_LINK is not set/' "$BB_DEFCONFIG"
fi