python scripts/xdist/pytest_container_manager.py -a up -n ${NUM_WORKERS} \
-t ${TASK_NAME} \
-s ${SUBNET} \
-sg ${SECURITY_GROUP}

ip_list=$(<pytest_container_ip_list.txt)

for ip in $ip_list
do
    cmd=$cmd"ssh ubuntu@$ip 'cd /edx/app/edxapp/edx-platform; git pull -q; git checkout -q ${CI_BRANCH}; source /edx/app/edxapp/edxapp_env; pip install -qr requirements/edx/development.txt' & "
done
cmd=$cmd" wait"

echo "Executing commmand: $cmd"
eval $cmd
