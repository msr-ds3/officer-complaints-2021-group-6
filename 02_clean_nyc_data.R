
# setup
library(tidyverse)
library(lubridate)
library(scales)
theme_set(theme_bw())

# read in nyc data
nyc_incidents <- read_csv('data/nyc_incidents.csv')
# View(nyc_incidents)

# remove incidents not 2007-2017
nyc_incidents <- nyc_incidents %>%
  # convert the date of the incident into a Date
  mutate(IncidentDate = as.Date(parse_datetime(IncidentDate, "%m/%d/%Y"))) %>%
  # keep only incidents that occurred 2007-2017 
  filter(between(IncidentDate, as.Date("2007-01-01"), as.Date("2017-12-31")))

# there can be more than one allegation in a given complaint
# an incident can contain moare than one allegation against the same police officer
# for complaints that name a given officer multiple times, count the officer once
nyc_incidents <- nyc_incidents %>%
  # collapse allegations per officer under complaints
  group_by(OfficerID, ComplaintID) %>%
  slice(1) %>%
  ungroup()

# count the number of complaints per officer
nyc_incidents <- nyc_incidents %>%
  group_by(OfficerID) %>%
  summarize(num_complaints = n())

# divide officers into deciles based on number of complaints
nyc_incidents <- nyc_incidents %>%
  mutate(decile_rank = ntile(nyc_incidents$num_complaints, 10))

# count the number of complaints in each decile
nyc_incidents <- nyc_incidents %>%
  group_by(decile_rank) %>%
  summarize(num_complaints_in_this_decile = sum(num_complaints))