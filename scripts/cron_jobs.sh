#!/bin/bash

echo "***cronjobs before cleanup***"
getent passwd | awk -F: '{ print $1 }' | xargs -I% sh -c 'crontab -l -u % | sed "/^$/d; /^#/d; s/^/% /"' 2>/dev/null

arr=$(getent passwd | awk -F: '{ print $1 }' | xargs -I% sh -c 'crontab -l -u % | sed "/^$/d; /^#/d; s/^/% /"' 2>/dev/null | awk '{ print $1 }')
echo "'" $arr "'" users has crontab entries
for i in $arr; do runuser -u $i -- crontab -r; done

echo "***cronjobs after cleanup***"
getent passwd | awk -F: '{ print $1 }' | xargs -I% sh -c 'crontab -l -u % | sed "/^$/d; /^#/d; s/^/% /"' 2>/dev/null

echo "***************************************"

echo "***other cron entries before cleanup***"
cat /etc/crontab /etc/anacrontab 2>/dev/null | sed '/^$/d; /^#/d;'
run-parts --list /etc/cron.hourly || true;
run-parts --list /etc/cron.daily || true;
run-parts --list /etc/cron.weekly || true;
run-parts --list /etc/cron.monthly || true;

rm -rf /etc/cron* 2>/dev/null

echo "***other cron entries after cleanup***"
cat /etc/crontab /etc/anacrontab 2>/dev/null | sed '/^$/d; /^#/d;'
run-parts --list /etc/cron.hourly || true;
run-parts --list /etc/cron.daily || true;
run-parts --list /etc/cron.weekly || true;
run-parts --list /etc/cron.monthly || true;