
# setup
library(tidyverse)
library(lubridate)
library(scales)
theme_set(theme_bw())

##################################
# Process data from OpenDataPhilly
##################################

# read in data
philly_incidents_complaints_from_open_data_philly <- read_csv('data/philly_incidents_complaints_from_open_data_philly.csv')

philly_incidents_findings_from_open_data_philly <- read_csv('data/philly_incidents_findings_from_open_data_philly.csv')

# clean philly_incidents_complaints_from_open_data_philly
philly_incidents_complaints_from_open_data_philly <- philly_incidents_complaints_from_open_data_philly %>%
  # keep needed columns only
  select(complaint_id, date_received)

# clean philly_incidents_findings_from_open_data_philly
philly_incidents_findings_from_open_data_philly <- philly_incidents_findings_from_open_data_philly %>%
  # keep needed columns only
  select(complaint_id, officer_id) %>%
  # drop rows where the officer id is not specified
  drop_na(officer_id)

# join philly_incidents_complaints_from_open_data_philly and philly_incidents_findings_from_open_data_philly
philly_incidents_from_open_data_philly <- 
  inner_join(philly_incidents_complaints_from_open_data_philly, 
             philly_incidents_findings_from_open_data_philly, 
             by="complaint_id")
# View(philly_incidents_from_open_data_philly)


###############################
# Process data from Sam Learner
###############################

# read in data
philly_incidents_complaints_from_sam_learner <- read_csv('data/philly_incidents_complaints_from_sam_learner.csv',
                                                         guess_max = 100000)

philly_incidents_disciplines_from_sam_learner <- read_csv('data/philly_incidents_disciplines_from_sam_learner.csv', 
                                                          guess_max = 100000)

# clean philly_incidents_complaints_from_sam_learner
philly_incidents_complaints_from_sam_learner <- philly_incidents_complaints_from_sam_learner %>%
  # convert date from character to Date
  mutate(date_received = as.Date(parse_datetime(date_received, "%m/%d/%y"))) %>%
  # keep needed columns only
  select(complaint_id, date_received)

# clean philly_incidents_disciplines_from_sam_learner
philly_incidents_disciplines_from_sam_learner <- philly_incidents_disciplines_from_sam_learner %>%
  # keep needed columns only
  select(complaint_id, officer_id) %>%
  # drop rows where the officer id is not specified
  drop_na(officer_id)

# join philly_incidents_complaints_from_sam_learner and philly_incidents_disciplines_from_sam_learner
philly_incidents_from_sam_learner <- inner_join(philly_incidents_complaints_from_sam_learner, 
                                                philly_incidents_disciplines_from_sam_learner, 
                                                by="complaint_id")

# keep only incidents that occurred April 1, 2015 - Jan 20, 2016
philly_incidents_from_sam_learner <- philly_incidents_from_sam_learner %>%
  filter(between(date_received, as.Date("2015-04-01"), as.Date("2016-01-10")))
# View(philly_incidents_from_sam_learner)


#########################################################
# join data from OpenDataPhilly and data from Sam Learner
#########################################################

# join philly_incidents_from_open_data_philly and philly_incidents_from_sam_learner
philly_incidents <- full_join(philly_incidents_from_open_data_philly, philly_incidents_from_sam_learner)

# there can be more than one allegation in a given complaint
# an incident can contain moare than one allegation against the same police officer
# for complaints that name a given officer multiple times, count the officer once
philly_incidents <- philly_incidents %>%
  # collapse allegations per officer under complaints
  group_by(officer_id, complaint_id) %>%
  slice(1) %>%
  ungroup()

# count the number of complaints per officer
philly_incidents <- philly_incidents %>%
  group_by(officer_id) %>%
  summarize(num_complaints = n())

# divide officers into deciles based on number of complaints
philly_incidents <- philly_incidents %>%
  mutate(decile_rank = ntile(philly_incidents$num_complaints, 10))

# count the number of complaints in each decile
philly_incidents <- philly_incidents %>%
  group_by(decile_rank) %>%
  summarize(num_complaints_in_this_decile = sum(num_complaints))
# View(philly_incidents)





