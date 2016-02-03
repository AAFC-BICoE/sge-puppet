echo "$2 $1" >> /etc/hosts
qconf -aattr hostgroup hostlist $1 @allhosts
qconf -Mp qconf-pe-smp.txt
qconf -Mq qconf-queue.txt
qconf -ah $1
