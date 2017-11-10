#!/bin/bash

BACKUP=home_backup_$(date +%T)_$(date +%d.%m.%Y).tar.gz
HOME="home"
function backup {
	$(tar -C / -cf - $HOME | pigz -p 4 > $BACKUP);
} 
function backup_delete {
	args=($(find /home/jurica/*.tar.gz -type f -print0 | xargs -0 ls -t))
if [[ ${#args[@]} -le 1 ]]; then
		echo "[$(date +%T) $(date +%d.%m.%Y)] No backup to delete." >> /home/jurica/backup.log
		exit 0
elif [[ $(rm ${args[-1]}) ]]; then
	 	echo "[$(date +%T) $(date +%d.%m.%Y)] Old backup wasn't deleted succesfully!" >> /home/jurica/backup.log
	 else 
	 	echo "[$(date +%T) $(date +%d.%m.%Y)] Old backup was deleted succesfully." >> /home/jurica/backup.log
fi 
}


	if [[ $(find /home/jurica/$BACKUP -type f -size +1k) ]]; then
		echo "[$(date +%T) $(date +%d.%m.%Y)] Backup $BACKUP succesfully created." >> /home/jurica/backup.log
			else
				echo "[$(date +%T) $(date +%d.%m.%Y.)] Backup wasn't created succesfully!" >> /home/jurica/backup.log
	fi
fi

backup_delete