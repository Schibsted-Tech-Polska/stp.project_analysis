#! /bin/bash

cd /home/mno/strategiske-tjenester/rubrikk/regionene-felles/xtra_jobbdirekte/history/

tar -czf xml__history-$(date +%F).tar.gz *.xml

rm jobbdirektebackup*.xml