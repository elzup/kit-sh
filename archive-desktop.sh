today=$(date "+%Y%m%d")
backupdir=~/backup/desktop$today/
mkdir -p $backupdir
\mv ~/Desktop/* $backupdir
echo date: $today
echo backuppath: $backupdir