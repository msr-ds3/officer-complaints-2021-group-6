
### Cleaning Chicago Data for Replication ######



##########  Importing Required libraries ######################

library(tidyverse)




########## Importing Required Datasets #######################


# contains data of accused officers
chicago_officers <- read_csv('../data/chicago_accused.csv')

# contains all the closed complaints between 2007 and 2017
chicago_all_complaints <- read_csv('../data/chicago_complaints.csv') %>%
  filter(between(complaint_date, as.Date("2007-01-01"), as.Date("2017-12-31")), between(closed_date, as.Date("2007-01-01"), as.Date("2017-12-31")))

# contains complaints id filed by officers
chicago_officer_filed <- read_csv('../data/chicago_officer_filed_complaints.csv')




############# Data Cleaning ################################


# get the complaints filed by civilians only
chicago_only_civilians <- chicago_officers %>% mutate(cr_id = as.numeric(cr_id)) %>%
  filter(!(cr_id %in% chicago_officer_filed$cr_id))


# join the complaints data by complaint id and group by to get distinct officer Id and complaint ID
chicago_incidents <- inner_join(chicago_only_civilians, chicago_all_complaints, by = "cr_id") %>%
  group_by(link_UID, cr_id) %>%
  distinct() %>%
  ungroup()


# get the number of complaints per officer Id
chicago_incidents <- chicago_incidents %>%
  group_by(link_UID) %>%
  summarize(num_complaints = n()) 


# divide the complaints per officer into deciles 
chicago_incidents <- chicago_incidents %>%
  mutate(decile_rank = ntile(num_complaints, 10)) %>%
  group_by(decile_rank) %>%
  summarize(total_complaints = sum(num_complaints))


## outputs complaints_incidents that can be plotted into required bar graph
























