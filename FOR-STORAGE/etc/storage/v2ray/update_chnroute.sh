#!/bin/sh

set -e -o pipefail

#[ "$1" != "force" ] && [ "$(nvram get ss_update_chnroute)" != "1" ] && exit 0
CHNROUTE_URL="$(nvram get chnroute_url)"

logger -st "chnroute" "Starting update..."
rm -f /tmp/chinadns_chnroute.txt

if [ -z "$CHNROUTE_URL" ]; then
	curl -k -s --connect-timeout 5 --retry 3 http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest | \
		awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /tmp/chinadns_chnroute.txt
else
	curl -k -s --connect-timeout 5 --retry 3 -o /tmp/chinadns_chnroute.txt "$CHNROUTE_URL"
fi

mv -f /tmp/chinadns_chnroute.txt /tmp/v2ray/chnroute.txt

logger -st "chnroute" "Update done"
