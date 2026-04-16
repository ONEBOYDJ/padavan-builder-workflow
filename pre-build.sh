#!/bin/bash
# Фикс: добавить недостающие CAN/IFLA define в исходник iplink.c
# Ядро 3.4 MT7628 не содержит этих определений
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