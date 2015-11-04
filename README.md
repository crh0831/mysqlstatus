<div><img style="float:right; padding 0px 0px 10px 10px;" alt="linux" src="http://i.imgur.com/DhIX0Vn.png"</img></div>
<div><img style="float:right; padding 0px 0px 10px 10px;" alt="mysql" src="http://i.imgur.com/Bjn4Ik7.png"</img></div>
# mysqlstatus

Bash script that allows you to peek at non-root user actions on a Percona MySQL database. (may work with MariaDB)

Requires user_statistics enabled ( `userstat=1` under \[mysqld\] in `/etc/my.cnf`)

Also accounts for databases on non-standard ports:

USAGE:

Peek at instance on default port with a refresh of .5s

	mysqlstatus.sh

Peek at instance on default port with a refresh of .25s

	mysqlstatus.sh 3306 .25

Peek at instance on port 3317 with a refresh of 1s

	mysqlstatus.sh 3317 1
