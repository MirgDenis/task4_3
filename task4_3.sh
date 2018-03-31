#!/bin/bash
[ -d /tmp/backups ] || mkdir /tmp/backups

if [ "$#" -ne 2 ] #Checking variables
then
	echo -e "Illegal number of parameters.\nUsage: task4_3.sh PATH NUM" >&2
	exit 1
fi

if [ ! -d "$1" ] #Checking directory
then
	echo "Directory does not exist" >&2
	exit 1
fi

re='^[0-9]+$'
if ! [[ $2 =~ $re ]] #Checking numeric
then
	echo "The NUM of backups is not numerical" >&2
	exit 1
fi

#----Backup creating

name=`echo "${1}" | sed 's!/!!' | sed 's!/!-!g'`

#Rm old backups
while [ `ls /tmp/backups | fgrep "$name" | grep "${name}#" | wc -l` -ge $2 ]
do
	rm "/tmp/backups/$( ls -t /tmp/backups | fgrep "$name" | grep "$name#.*" | tail -1 )"
done

tar -cz --file="/tmp/backups/${name}#$(date '+%Y-%m-%d-%H:%M:%S')".tar.gz -C "$1" .

exit 0
