rm etchosts.txt qconf-hostgroup.txt qconf-pe-mpi.txt qconf-pe-smp.txt qconf-queue.txt response-sge-install.conf
rm exec.pp master.pp
mv exec.pp.bak exec.pp
mv master.pp.bak master.pp
sed -i '/DO NOT MODIFY THIS FILE/d' ./exec.pp
sed -i '/DO NOT MODIFY THIS FILE/d' ./master.pp
