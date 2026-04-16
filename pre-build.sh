#!/bin/bash
# Фикс 1: CAN defines для ядра 3.4
IPLINK="padavan-ng/trunk/user/busybox/busybox-1.37.0/networking/libiproute/iplink.c"
if [ -f "$IPLINK" ]; then
  cat > /tmp/can_fix.h << 'EOF'
#ifndef CAN_CTRLMODE_FD
#define CAN_CTRLMODE_FD 0x04
#endif
#ifndef CAN_CTRLMODE_FD_NON_ISO
#define CAN_CTRLMODE_FD_NON_ISO 0x08
#endif
#ifndef CAN_CTRLMODE_PRESUME_ACK
#define CAN_CTRLMODE_PRESUME_ACK 0x40
#endif
#ifndef IFLA_CAN_TERMINATION
#define IFLA_CAN_TERMINATION 22
#endif
EOF
  cat /tmp/can_fix.h "$IPLINK" > /tmp/iplink_fixed.c
  cp /tmp/iplink_fixed.c "$IPLINK"
  echo "Patched iplink.c with CAN defines"
fi

# Фикс 2: ProductID MI-4A_100M -> MI-4A-100M
BOARD_H="padavan-ng/trunk/configs/boards/XIAOMI/MI-4A_100M/board.h"
if [ -f "$BOARD_H" ]; then
  sed -i 's/MI-4A_100M/MI-4A-100M/g' "$BOARD_H"
  echo "Patched board.h ProductID"
fi
# Также в .config если он уже сгенерирован
find padavan-ng/trunk -name ".config" -maxdepth 1 | while read f; do
  sed -i 's/MI-4A_100M/MI-4A-100M/g' "$f"
done