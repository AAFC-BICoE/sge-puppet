qconf -dh $1
qconf -dattr hostgroup hostlist $1 @allhosts
qconf -Mp qconf-pe-smp.txt
qconf -Mq qconf-queue.txt
qconf -de $1
cat etchosts.txt > /etc/hosts
