
# setup
library(tidyverse)
library(lubridate)
library(scales)
theme_set(theme_bw())

# read in philly data
philly_incidents <- read_csv('data/philly_incidents.csv')
View(philly_incidents)

# there can be more than one allegation in a given complaint
# an incident can contain moare than one allegation against the same police officer
# for complaints that name a given officer multiple times, count the officer once
philly_incidents <- philly_incidents %>%
  drop_na(officer_id) %>%
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





