#!/bin/bash
#
# description:
#	fetches  nyc officer complaints files from nypd github
#
# usage: ./01_download_nyc_complaints.sh
#
# requirements: curl or wget
#
# author: Sambhav Shrestha


# set path for complaints data
DATA_DIR=data/

# change to the data directory
cd $DATA_DIR

# download the csv files
#curl -O https://github.com/invinst/chicago-police-data/blob/master/data/unified_data/complaints/complaints-accused.csv.gz
curl -O https://raw.githubusercontent.com/invinst/chicago-police-data/master/data/unified_data/complaints/complaints-complaints.csv.gz
curl -O https://raw.githubusercontent.com/invinst/chicago-police-data/master/data/unified_data/complaints/complaints-accused.csv.gz
curl -O https://raw.githubusercontent.com/invinst/chicago-police-data/master/data/unified_data/complaints/officer-filed-complaints__2017-09.csv.gz

# gunzip all the files
gunzip complaints-complaints.csv.gz
gunzip complaints-accused.csv.gz
gunzip officer-filed-complaints__2017-09.csv.gz

#update the file to current timestamp
touch complaints-complaints.csv
touch complaints-accused.csv
touch officer-filed-complaints__2017-09.csv
