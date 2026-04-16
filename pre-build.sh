#!/bin/bash
# Фикс CAN defines
IPLINK="padavan-ng/trunk/user/busybox/busybox-1.37.0/networking/libiproute/iplink.c"
if [ -f "$IPLINK" ]; then
  HEADER="#ifndef CAN_CTRLMODE_FD\n#define CAN_CTRLMODE_FD 0x04\n#endif\n#ifndef CAN_CTRLMODE_FD_NON_ISO\n#define CAN_CTRLMODE_FD_NON_ISO 0x08\n#endif\n#ifndef CAN_CTRLMODE_PRESUME_ACK\n#define CAN_CTRLMODE_PRESUME_ACK 0x40\n#endif\n#ifndef IFLA_CAN_TERMINATION\n#define IFLA_CAN_TERMINATION 22\n#endif\n"
  printf "$HEADER" | cat - "$IPLINK" > /tmp/iplink_fixed.c && cp /tmp/iplink_fixed.c "$IPLINK"
fi
# Фикс BOARD_PID: подчёркивание на дефис
sed -i 's/MI-4A_100M/MI-4A-100M/g' padavan-ng/trunk/configs/boards/XIAOMI/MI-4A_100M/board.h