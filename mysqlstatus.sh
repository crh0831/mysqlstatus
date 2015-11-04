#!/usr/bin/env bash
#===============================================================================
#
#          FILE: mysqlstatus.sh
# 
#         USAGE: ./mysqlstatus.sh 
# 
#   DESCRIPTION: A quick and dirty window into what mysql is doing
# 
#       OPTIONS: 
#  REQUIREMENTS: Port Number
#         NOTES: 
#        AUTHOR: C Hawley (S Fertig)
#  ORGANIZATION: 
#       CREATED: 2013-09-27
#      REVISION: Wed 04 Nov 2015 10:49:20 AM EST
#===============================================================================

set -o nounset                              # Treat unset variables as an error

host="127.0.0.1"							# default to localhost
refresh=.5									# how long between refreshes

# Use default MySQL port unless another port is specified on command line
if [ -z "${1:-}" ]; then
	port=3306
else
	port=$1
fi

# if 2 arguments then accept port and refresh rate
if [ "$#" -eq 2 ]; then
		port=$1
		refresh=$2
fi

# if more than 2 arguments, fail
if [ "$#" -gt 2 ]; then
		echo "Too Many Arguments"
		echo "Usage: mysqlstatus [port] [refresh]"
		exit 1
fi

# Check connection to database
if [[ ! $(mysql -h"${host}" -P"${port}" -e 'show databases;' 2>/dev/null) ]]; then
		echo "Cannot connect to database on port ${port}"
		exit 1
fi

while sleep "${refresh}";do 
	clear; 
	echo "Peeking at non-root activity on port ${port} (refreshing every ${refresh}s) ( <ctrl>-c to quit )"
	echo ""
	mysql -h"${host}" -P"${port}" INFORMATION_SCHEMA -e "
SELECT USER, CPU_TIME, TOTAL_CONNECTIONS, BUSY_TIME, BYTES_RECEIVED, BYTES_SENT, SELECT_COMMANDS, DENIED_CONNECTIONS, LOST_CONNECTIONS FROM USER_STATISTICS 
WHERE USER != 'root' ORDER BY BUSY_TIME DESC, TOTAL_CONNECTIONS DESC LIMIT 20; SELECT DB, USER, COMMAND, TIME, STATE, LEFT(INFO,100) FROM processlist WHERE
USER != 'root' ORDER BY TIME DESC LIMIT 50;
"; 
done
