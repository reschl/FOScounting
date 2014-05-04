#!/bin/bash

## This script provides functionality to replace topics with an template version 
## while storing the current version, which will not be editable afterwards.
## The overview page will be stored as PDF and mailed to given users using mutt.
##
## For further informations visit the according github repository

## License: GPL v3 or higher
## Author: Lukas Resch
## https://github.com/reschl/FOScounting

# documentdir is where the PDF files will be stored
documentdir="/srv/ftp/pdfs"

# foswikidir is where the foswiki root is
foswikidir="/srv/http/htdocs/foswiki"

# templatedir is where the templates for backuped topics are stored
templatedir="/srv/template"

# mailaddresses all mails the pdf is sent to
mailadderesses="user1@example.com user2@example.com"

tmpfile="/tmp/mail"

today=`date +%Y%m%d`

# data to backup the topic
backupUser="UserName"
backupPW="password"
hostname="example.com"
backupTopic="path/To/BackupTopic"

eval cd $documentdir

wget -O $today.pdf http://$backupUser:$backupPW@$hostname/$backupTopic?contenttype=application/pdf

eval cd $foswikidir/data/Main/

# Userlist
user[0]="ExampleUser1"
user[1]="ExampleUser2"

oldlists="ListTopic"

for i in {0..3}
do
  mv ${user[$i]}$oldlists.txt ${user[$i]}$oldlists$today.txt
  sed -i "s/   \* Set ALLOWTOPICCHANGE =.*/   * Set ALLOWTOPICCHANGE = NobodyGroup/g" ${user[$i]}$oldlists$today.txt
  sed -i "s/   \* Set ALLOWTOPICRENAME =.*/   * Set ALLOWTOPICRENAME = NobodyGroup/g" ${user[$i]}$oldlists$today.txt
  sed -i "/${user[$i]}$oldlists/ a\   * ${user[$i]}$oldlists$today" ${user[$i]}.txt
  cp $templatedir/${user[$i]}$oldlists.txt ${user[$i]}$oldlists.txt
done

cd

touch $tmpfile

printf "Hello,\n\n" >> $tmpfile
printf "Today " date " I have done accounting. Result can be found in the appended file.\n\n" >> $tmpfile
printf "regards\nAccounting Bot"  >> $tmpfile

mutt -s "Balance $(date +%d.%m.%Y)" -a $documentdir/$today.pdf -- $mailadderesses < $tmpfile

rm $tmpfile
