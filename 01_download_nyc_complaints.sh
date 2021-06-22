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
#

# set a relative path for the complaints data
# (use data/ directory)
DATA_DIR=data/

# change to the data directory
cd $DATA_DIR

# download the csv file
# alternatively you canuse wget if you don't have curl
# wget $url
url=https://raw.githubusercontent.com/new-york-civil-liberties-union/NYPD-Misconduct-Complaint-Database-Updated/main/CCRB%20Complaint%20Database%20Raw%2004.20.2021.csv
curl -o nyc_incidents.csv $url