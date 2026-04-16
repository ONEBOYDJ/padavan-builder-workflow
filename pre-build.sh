#!/bin/bash
# Фикс: патч iplink.c - убрать CAN support (несовместим с ядром 3.4)
cd padavan-ng/trunk
find . -name "iplink.c" -path "*/busybox*" | while read f; do
  sed -i '/do_set_can/,/^}/{ s/CAN_CTRLMODE_FD_NON_ISO/0x08/g; s/CAN_CTRLMODE_FD/0x04/g; s/CAN_CTRLMODE_PRESUME_ACK/0x40/g; s/IFLA_CAN_TERMINATION/999/g; }' "$f"
done

# Универсальный фикс: добавить все недостающие define в заголовок
find . -name "iplink.c" -path "*/busybox*" | while read f; do
  sed -i '1i #ifndef CAN_CTRLMODE_FD\n#define CAN_CTRLMODE_FD 0x04\n#endif\n#ifndef CAN_CTRLMODE_FD_NON_ISO\n#define CAN_CTRLMODE_FD_NON_ISO 0x08\n#endif\n#ifndef CAN_CTRLMODE_PRESUME_ACK\n#define CAN_CTRLMODE_PRESUME_ACK 0x40\n#endif\n#ifndef IFLA_CAN_TERMINATION\n#define IFLA_CAN_TERMINATION 22\n#endif' "$f"
done
cd ../..