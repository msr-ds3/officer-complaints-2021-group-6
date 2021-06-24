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
mkdir data
DATA_DIR=data/

# change to the data directory
cd $DATA_DIR


## New York
# comment all lines below to chicago to not download new york files
# download the csv file
# alternatively you canuse wget if you don't have curl
# wget $url
url=https://raw.githubusercontent.com/new-york-civil-liberties-union/NYPD-Misconduct-Complaint-Database-Updated/main/CCRB%20Complaint%20Database%20Raw%2004.20.2021.csv
curl -o nyc_incidents.csv $url

# update the file to current timestamp
touch nyc_incidents.csv


## Chicago
# comment all the lines below to philadelphia to not download chicago files
# download the csv files
curl -O chicago_complaints.csv.gz https://raw.githubusercontent.com/invinst/chicago-police-data/master/data/unified_data/complaints/complaints-complaints.csv.gz
curl -O chicago_accused.csv.gz https://raw.githubusercontent.com/invinst/chicago-police-data/master/data/unified_data/complaints/complaints-accused.csv.gz
curl -O chicago_officer_filed_complaints.csv.gz https://raw.githubusercontent.com/invinst/chicago-police-data/master/data/unified_data/complaints/officer-filed-complaints__2017-09.csv.gz

# gunzip all the files
gunzip chicago_complaints.csv.gz
gunzip chicago_accused.csv.gz
gunzip chicago_officer_filed_complaints.csv.gz

#update the file to current timestamp
touch chicago_complaints.csv
touch chicago_accused.csv
touch chicago_officer_filed_complaints.csv 


# Philadelphia
# comment all line below to not download philadelphia files
# download the csv files
# alternatively you can use wget if you don't have curl
# wget $url
url1="https://phl.carto.com/api/v2/sql?q=SELECT+*+FROM+ppd_complaints&filename=ppd_complaints&format=csv&skipfields=cartodb_id,the_geom,the_geom_webmercator"
curl -o philly_incidents_complaints_from_open_data_philly.csv $url1
touch philly_incidents_complaints_from_open_data_philly.csv

url2="https://phl.carto.com/api/v2/sql?q=SELECT+*+FROM+ppd_complaint_disciplines&filename=ppd_complaint_disciplines&format=csv&skipfields=cartodb_id,the_geom,the_geom_webmercator"
curl -o philly_incidents_findings_from_open_data_philly.csv $url2
touch philly_incidents_findings_from_open_data_philly.csv

url3="https://raw.githubusercontent.com/sdl60660/philly_police_complaints/master/raw_data/ppd_complaints.csv"
curl -o philly_incidents_complaints_from_sam_learner.csv $url3
touch philly_incidents_complaints_from_sam_learner.csv

url4="https://raw.githubusercontent.com/sdl60660/philly_police_complaints/master/raw_data/ppd_complaint_disciplines.csv"
curl -o philly_incidents_disciplines_from_sam_learner.csv $url4
touch philly_incidents_disciplines_from_sam_learner.csv

url5="https://phl.carto.com/api/v2/sql?q=SELECT+*+FROM+ppd_complainant_demographics&filename=ppd_complainant_demographics&format=csv&skipfields=cartodb_id,the_geom,the_geom_webmercator"
curl -o philly_complainant_demographics_from_open_data_philly.csv $url5
touch philly_complainant_demographics_from_open_data_philly.csv

