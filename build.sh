#Import values from config file
MASTER_HOSTNAME=$(grep -A 3 master ./sgecloud.conf | grep hostname | cut -d= -f2)
MASTER_IP=$(grep -A 3 master ./sgecloud.conf | grep ip | cut -d= -f2)
MASTER_CORES=$(grep -A 3 master ./sgecloud.conf | grep cores | cut -d= -f2)
EXEC_HOSTNAMES=$(grep -A 3 exec ./sgecloud.conf | grep hostname | cut -d= -f2)
EXEC_IPS=$(grep -A 3 exec ./sgecloud.conf | grep ip | cut -d= -f2)
EXEC_CORES=$(grep -A 3 exec ./sgecloud.conf | grep cores | cut -d= -f2)
DEFAULT_CORES=$(grep default_cores ./sgecloud.conf | cut -d= -f2)
CLUSTER_NAME=$(grep cluster_name ./sgecloud.conf | cut -d= -f2)
CLUSTER_PRIVATE_KEY=$(grep cluster_private_key ./sgecloud.conf | cut -d= -f2)
CLUSTER_PUBLIC_KEY=$(grep cluster_public_key ./sgecloud.conf | cut -d= -f2)
CLUSTER_NETWORK_CIDR=$(grep cluster_network_cidr ./sgecloud.conf | cut -d= -f2)

#Create hostgroup qconf file
./build/write-hostgroup.sh $MASTER_HOSTNAME $EXEC_HOSTNAMES

#Create /etc/hosts file
echo "127.0.0.1 localhost" > ./etchosts.txt
echo "$MASTER_IP $MASTER_HOSTNAME" >> ./etchosts.txt
for IP in $EXEC_IPS
do
        echo "$IP &" >> ./etchosts.txt
done
for HOSTNAME in $EXEC_HOSTNAMES
do
        sed -i -re "0,/&/s/&/$HOSTNAME/" ./etchosts.txt
done

###PE: Create pe qconf file
#Calculate number of cores for master
#***Note to self: Errors would be if user specified 0, negative, or string other than "default", in the conf file for number of master cores
if [[ $MASTER_CORES == "default" ]] #If user specifies "default" for master cores, substitute that for default cores to ensure calculation below works
then
	MASTER_CORES=$DEFAULT_CORES
fi

if [[ $MASTER_CORES == 1 ]] #If master has more than one core, leave one core out of exec for master processes
then
	MASTER_CORE_COUNT=1
else
	MASTER_CORE_COUNT=$(($MASTER_CORES-1))
fi

#Calculate number of cores for exec nodes
#***Note to self: Errors would be if user specified 0, negative, or string other than "default", in the conf file for number of exec cores
EXEC_CORE_COUNT=0
for CORES_IN_EXEC in $EXEC_CORES

do
	if [[ $CORES_IN_EXEC == "default" ]]
	then
		EXEC_CORE_COUNT=$(($EXEC_CORE_COUNT+$DEFAULT_CORES))
	else
		EXEC_CORE_COUNT=$(($EXEC_CORE_COUNT+$CORES_IN_EXEC))
	fi
done
CORE_COUNT=$(($MASTER_CORE_COUNT+$EXEC_CORE_COUNT))
./build/write-pe.sh $CORE_COUNT #Write qconf file for parallel environment

###QUEUE: Create qconf file
SLOT_STRING=[$MASTER_HOSTNAME=$MASTER_CORE_COUNT],[$(grep -A 2 exec ./sgecloud.conf | cut -d= -f2 | grep -v exec)]
echo $SLOT_STRING > tmp
sed -i -re 's/ /=/g' ./tmp
sed -i -re "s/default/$DEFAULT_CORES/g" ./tmp
sed -i -re 's/=--=/],[/g' ./tmp
./build/write-queue.sh $DEFAULT_CORES,$(cat ./tmp)
echo "" > tmp

###FOR SGE INSTALL: Create response-sge-install.conf file for installation
./build/write-response-sge-install.sh $MASTER_HOSTNAME $EXEC_HOSTNAMES $CLUSTER_NAME

###Set Master hostname in puppet manifest

#Backup puppet manifests to allow for unedited versions
echo "DO NOT MODIFY THIS FILE" > exec.pp.bak
echo "DO NOT MODIFY THIS FILE" > master.pp.bak
cat exec.pp >> exec.pp.bak
cat master.pp >> master.pp.bak

#Fill out variables in the manifests
sed -i -re "s/MASTER-HOSTNAME/$MASTER_HOSTNAME/g" ./exec.pp
sed -i -re "s/CLUSTER-NAME/$CLUSTER_NAME/g" ./exec.pp
sed -i -re "s/CLUSTER-PUBLIC-KEY/$CLUSTER_PUBLIC_KEY/g" ./exec.pp

sed -i -re "s/CLUSTER-NAME/$CLUSTER_NAME/g" ./master.pp
sed -i -re "s/CLUSTER-PRIVATE-KEY/$CLUSTER_PRIVATE_KEY/g" ./master.pp
sed -i -re "s/CLUSTER-NET-CIDR/"$CLUSTER_NETWORK_CIDR"/g" ./master.pp
