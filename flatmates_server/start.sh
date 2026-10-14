#!/usr/bin/env bash
# `serverpod start` on whichever phone is plugged in. It only reads one
# device from pubspec.yaml (flutter_apps: flatmates: device), so this points
# that at a connected phone first: one of the known ones below, else any
# connected phone. It also points the app at this machine's LAN IP.
# Args go to `serverpod start`.
set -euo pipefail
cd "$(dirname "$0")"

known=(112bc353 RZCW82QLD8M)

connected=$(flutter devices --machine 2>/dev/null | python3 -c '
import json, sys
for d in json.load(sys.stdin):
    if d.get("isSupported") and not d.get("emulator") and d["targetPlatform"].startswith(("android", "ios")):
        print(d["id"])
')

device=""
for id in "${known[@]}"; do
  if grep -qx "$id" <<<"$connected"; then device=$id; break; fi
done
device=${device:-$(head -n1 <<<"$connected")}
if [[ -z $device ]]; then
  echo "No phone connected. Plug one in (USB debugging on) and try again." >&2
  exit 1
fi

ip=$(ip route get 1.1.1.1 | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}')
sed -i -E \
  -e "s|^(      device: ).*|\1$device|" \
  -e "s|^(      dart-define: SERVER_URL=http://)[^:]+(:8080/)|\1$ip\2|" \
  pubspec.yaml
echo "Phone: $device · server: http://$ip:8080/"
exec serverpod start "$@"
