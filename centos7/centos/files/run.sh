#!/bin/bash

bash /usr/local/bin/init.sh

sleep 2

exec /usr/bin/tail --pid=$(cat /var/run/p4d.$P4NAME.pid) -F "$P4ROOT/logs/log"