#!/bin/bash

bash /usr/local/bin/init.sh
p4dctl start -t p4d $P4NAME

sleep 2

exec /usr/bin/tail --pid=$(cat /var/run/p4d.$P4NAME.pid) -F "$P4ROOT/logs/log" &
