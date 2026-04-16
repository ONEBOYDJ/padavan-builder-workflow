#!/bin/bash
# Фикс: добавить недостающие CAN define для ядра 3.4
IPLINK="padavan-ng/trunk/user/busybox/busybox-1.37.0/networking/libiproute/iplink.c"
if [ -f "$IPLINK" ]; then
  sed -i '1i\
#ifndef CAN_CTRLMODE_FD\n#define CAN_CTRLMODE_FD 0x04\n#endif\n#ifndef CAN_CTRLMODE_FD_NON_ISO\n#define CAN_CTRLMODE_FD_NON_ISO 0x08\n#endif\n#ifndef CAN_CTRLMODE_PRESUME_ACK\n#define CAN_CTRLMODE_PRESUME_ACK 0x40\n#endif' "$IPLINK"
fi