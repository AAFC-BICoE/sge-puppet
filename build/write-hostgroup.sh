HOSTLIST=""
for HOST in $*
do
	HOSTLIST="$HOSTLIST $HOST"
done

echo "group_name @allhosts" > ./qconf-hostgroup.txt
echo "hostlist$HOSTLIST" >> ./qconf-hostgroup.txt
