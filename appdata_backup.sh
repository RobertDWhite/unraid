
#!/bin/bash

#change if path is different in your environment
appdataDirectory='/mnt/user/appdata'

#add a backup path
backupDirectory='/PATH/TO/BACKUP/DIR/'

#number of days to keep backup
days=7

/usr/local/emhttp/plugins/dynamix/scripts/notify -s "AppData Backup" -d "Starting Backup..."

now="$(date +"%Y-%m-%d"@%H.%M)" 
mkdir """$backupDir"""$now""

for path in "$appdataDir"*

do
    name="$(basename "$path")"
    path=""$appdataDir""$name""
 
    cRunning="$(docker ps -a --format '{{.Names}}' -f status=running)"

    if echo $cRunning | grep -iqF $name; then
    echo "Stopping $name"
        docker stop -t 60 "$name"
        cd ""$backupDir""$now""
        tar cWfC "./$name.tar" "$(dirname "$path")" "$(basename "$path")"
    echo "Starting $name"
        docker start "$name"
    else
        cd ""$backupDir""$now""
        tar cWfC "./$name.tar" "$(dirname "$path")" "$(basename "$path")"
    echo "$name was stopped before backup, ignoring startup"
    fi

done

find "$backupDir"* -type d -mtime +"$days" -exec rm -rf {} +

/usr/local/emhttp/plugins/dynamix/scripts/notify -s "AppData Backup" -d "Backup complete..."
