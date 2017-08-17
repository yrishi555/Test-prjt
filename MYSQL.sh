echo "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';FLUSH PRIVILEGES;"  > /home/bitnami/mysql-init
/opt/bitnami/ctlscript.sh stop mysql
/opt/bitnami/mysql/bin/mysqld_safe --pid-file=/opt/bitnami/mysql/data/mysqld.pid --datadir=/opt/bitnami/mysql/data --init-file=/home/bitnami/mysql-init 2> /dev/null &
/opt/bitnami/ctlscript.sh restart mysql
rm /home/bitnami/mysql-init
