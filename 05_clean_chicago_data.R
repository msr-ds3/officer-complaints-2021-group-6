library(tidyverse)
library(lubridate)
library(scales)
theme_set(theme_bw())

chicago_accused <- read_csv('data/complaints-accused_2000-2018_2018-03.csv')
chicago_complaints <- read_csv('data/complaints-complaints_2000-2018_2018-03.csv')
chicago_officers <- read_csv('data/complaints-accused.csv')

chicago_victims <- read_csv('data/complaints-victims_2000-2018_2018-03.csv')

all_complaints <- read_csv('data/complaints-complaints.csv') %>%
  drop_na(closed_date)
  


# remove incidents not 2007-2017
sub_chicago_complaints <- all_complaints %>%
  # # convert the date of the incident into a Date
  # mutate(complaint_date = as.Date(parse_datetime(complaint_date, "%m/%d/%Y"))) %>%
  # keep only incidents that occurred 2007-2017
  filter(between(complaint_date, as.Date("2007-01-01"), as.Date("2017-12-31")), between(closed_date, as.Date("2007-01-01"), as.Date("2017-12-31"))) %>%
  anti_join(officer_filed, by = "cr_id")


# join the two datasets based on cr_id
complaints <- inner_join(sub_chicago_complaints, chicago_accused, by = "cr_id") %>%
  select(cr_id, UID, accusation_id) %>%
  drop_na(UID)



# there can be more than one allegation in a given complaint
# an incident can contain more than one allegation against the same police officer
# for complaints that name a given officer multiple times, count the officer once
final_complaints <- complaints %>%
  # collapse allegations per officer under complaints
  group_by(accusation_id) %>%
  slice(1) %>%
  ungroup()


# count the number of complaints per officer
result <- final_complaints %>%
  group_by(UID) %>%
  summarize(num_complaints = n())

# add the decile rank and number of complaints in each decile
result <- result %>%
  mutate(decile_rank = ntile(num_complaints, 10)) %>%
  group_by(decile_rank) %>%
  summarize(complaints_in_decile = sum(num_complaints))

# plot the output
result %>%
  ggplot(aes(x = decile_rank, y = complaints_in_decile/sum(complaints_in_decile))) +
  geom_bar(stat = 'identity', aes(fill = decile_rank == 10)) +
  scale_y_continuous(labels = percent)+
  theme(legend.position = "none")
  







