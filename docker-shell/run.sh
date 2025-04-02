GPUID=${GPUID:-"all"}
NAME=${NAME:-"jostc"}
JOSTCDIR=${JOSTCDIR:-"/hogehoge"}
SCRIPT_DIR=$(cd $(dirname $0); pwd)

MOUNT_OPTION=" "
if [ "$EXEUSER" = "root" ] ; then
USER_OPTION=""
MOUNT_OPTION="${MOUNT_OPTION} -v ${SCRIPT_DIR}/homedir:/root"
else
USERNAME=`whoami`
USERID=`id -u`
GROUPID=`id -g`
USER_OPTION="-u ${USERID}:${GROUPID}"
MOUNT_OPTION="${MOUNT_OPTION} -v ${SCRIPT_DIR}/homedir:/home/${USERNAME}"
fi

if [ -e ${JOSTCDIR} ] ; then
MOUNT_OPTION="${MOUNT_OPTION} -v ${JOSTC}:/JoSTC"
fi

set -x 
xhost +
chmod u+w /JoSTC

docker run -it --rm \
--gpus $GPUID \
--shm-size=16gb \
--net=host \
${USER_OPTION} \
-v /etc/passwd:/etc/passwd:ro \
-v /etc/group:/etc/group:ro \
-v /etc/localtime:/etc/localtime:ro \
${MOUNT_OPTION} \
-v ${SCRIPT_DIR}/../../dataset:/dataset \
-v ${SCRIPT_DIR}/..:/userdir -w /userdir \
--name ${NAME} \
jostc-docker bash