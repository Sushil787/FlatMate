#!/usr/bin/env bash
# Runs the app on a physical device, pointed at the dev server on this machine's LAN IP.
# Extra args go to `flutter run` (e.g. ./run_device.sh -d <device-id>).
set -euo pipefail
cd "$(dirname "$0")"
ip=$(ip route get 1.1.1.1 | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}')
echo "Server: http://$ip:8080/"
exec flutter run --dart-define=SERVER_URL="http://$ip:8080/" "$@"
