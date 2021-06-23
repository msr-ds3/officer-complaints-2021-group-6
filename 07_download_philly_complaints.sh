#!/bin/bash
#
# description:
#	fetches  philly officer complaints files from OpenDataPhilly
#
# usage: ./07_download_philly_complaints.sh
#
# requirements: curl or wget
#
# author: Adina Scheinfeld
#

# set a relative path for the complaints data
# (use data/ directory)
DATA_DIR=data/

# change to the data directory
cd $DATA_DIR

# download the csv files
# alternatively you can use wget if you don't have curl
# wget $url
url1="https://phl.carto.com/api/v2/sql?q=SELECT+*+FROM+ppd_complaints&filename=ppd_complaints&format=csv&skipfields=cartodb_id,the_geom,the_geom_webmercator"
curl -o philly_incidents_complaints_from_open_data_philly.csv $url1

url2="https://phl.carto.com/api/v2/sql?q=SELECT+*+FROM+ppd_complaint_disciplines&filename=ppd_complaint_disciplines&format=csv&skipfields=cartodb_id,the_geom,the_geom_webmercator"
curl -o philly_incidents_findings_from_open_data_philly.csv $url2

url3="https://raw.githubusercontent.com/sdl60660/philly_police_complaints/master/raw_data/ppd_complaints.csv"
curl -o philly_incidents_complaints_from_sam_learner.csv $url3

url4="https://raw.githubusercontent.com/sdl60660/philly_police_complaints/master/raw_data/ppd_complaint_disciplines.csv"
curl -o philly_incidents_disciplines_from_sam_learner.csv $url4

