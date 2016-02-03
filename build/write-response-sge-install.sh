echo "SGE_ROOT=\"/opt/sge\"" >> response-sge-install.conf
echo "SGE_QMASTER_PORT=6444">> response-sge-install.conf
echo "SGE_EXECD_PORT=6445">> response-sge-install.conf
echo "SGE_ENABLE_SMF=\"false\"" >> response-sge-install.conf
echo "SGE_CLUSTER_NAME=$3">> response-sge-install.conf
echo "SGE_JMX_PORT=\"Please enter port\"" >> response-sge-install.conf
echo "SGE_JMX_SSL=\"false\"" >> response-sge-install.conf
echo "SGE_JMX_SSL_CLIENT=\"false\"" >> response-sge-install.conf
echo "SGE_JMX_SSL_KEYSTORE=\"Please enter absolute path of server keystore file\"" >> response-sge-install.conf
echo "SGE_JMX_SSL_KEYSTORE_PW=\"Please enter the server keystore password\"" >> response-sge-install.conf
echo "SGE_JVM_LIB_PATH=\"Please enter absolute path of libjvm.so"\" >> response-sge-install.conf
echo "SGE_ADDITIONAL_JVM_ARGS=\"-Xmx256m"\" >> response-sge-install.conf
echo "CELL_NAME=\"default\"" >> response-sge-install.conf
echo "ADMIN_USER=sgeadmin">> response-sge-install.conf
echo "QMASTER_SPOOL_DIR=\$SGE_ROOT/\$CELL_NAME/spool/qmaster">> response-sge-install.conf
echo "EXECD_SPOOL_DIR=\$SGE_ROOT/\$CELL_NAME/spool">> response-sge-install.conf
echo "GID_RANGE=\"20000-20100\"" >> response-sge-install.conf
echo "SPOOLING_METHOD=\"classic\"" >> response-sge-install.conf
echo "DB_SPOOLING_DIR=\"spooldb"\" >> response-sge-install.conf
echo "PAR_EXECD_INST_COUNT=\"20\"" >> response-sge-install.conf
echo "ADMIN_HOST_LIST=\"$1 $2\"" >> response-sge-install.conf
echo "SUBMIT_HOST_LIST=\"$1\"" >> response-sge-install.conf
echo "EXEC_HOST_LIST=\"$1 $2\"" >> response-sge-install.conf
echo "EXECD_SPOOL_DIR_LOCAL=\"\"" >> response-sge-install.conf
echo "HOSTNAME_RESOLVING=\"true\"" >> response-sge-install.conf
echo "SHELL_NAME=\"ssh\"" >> response-sge-install.conf
echo "COPY_COMMAND=\"scp\"" >> response-sge-install.conf
echo "DEFAULT_DOMAIN=\"none\"" >> response-sge-install.conf
echo "ADMIN_MAIL=\"root\"" >> response-sge-install.conf
echo "ADD_TO_RC=\"true\"" >> response-sge-install.conf
echo "SET_FILE_PERMS=\"true\"" >> response-sge-install.conf
echo "RESCHEDULE_JOBS=\"wait\"" >> response-sge-install.conf
echo "SCHEDD_CONF=\"1\"" >> response-sge-install.conf
echo "SHADOW_HOST=\"\"" >> response-sge-install.conf
echo "EXEC_HOST_LIST_RM=\"\"" >> response-sge-install.conf
echo "REMOVE_RC=\"true\"" >> response-sge-install.conf
echo "WINDOWS_SUPPORT=\"false\"" >> response-sge-install.conf
echo "WIN_ADMIN_NAME=\"Administrator\"" >> response-sge-install.conf
echo "WIN_DOMAIN_ACCESS=\"false\"" >> response-sge-install.conf
echo "CSP_RECREATE=\"true\"" >> response-sge-install.conf
echo "CSP_COPY_CERTS=\"false\"" >> response-sge-install.conf
echo "CSP_COUNTRY_CODE=\"\"" >> response-sge-install.conf
echo "CSP_STATE=\"\"" >> response-sge-install.conf
echo "CSP_LOCATION=\"\"" >> response-sge-install.conf
echo "CSP_ORGA=\"\"" >> response-sge-install.conf
echo "CSP_ORGA_UNIT=\"\"" >> response-sge-install.conf
echo "CSP_MAIL_ADDRESS=\"\"" >> response-sge-install.conf