#install tidyverse
install.packages("tidyverse")

# load library
library(tidyverse)

# set random seed
seed <- 765 # <Replace '765' with your student ID here.>
set.seed(seed)



# generate alarm id, dates and region vectors
alarms_id.vt <- paste0('alarms_', sample(LETTERS, size = 10, replace = FALSE)) # nolint # nolint
alarms_dates.vt <- paste0('d.',seq(Sys.Date()-60, Sys.Date(), by = '1 day'))  # 60 days back. # nolint
alarms_region.vt <- c('AKL_North', 'AKL_Central', 'Waiheke','AKL_South', 'AKL_Others') # nolint

# generate random alarm frequency counts
alarms_count.mt <- matrix(round(runif(length(alarms_id.vt) * length(alarms_dates.vt))*seed), # nolint
                          nrow = length(alarms_id.vt), ncol=length(alarms_dates.vt)) # nolint
colnames(alarms_count.mt) <- alarms_dates.vt

# set up data frames
alarms_count.df <- data.frame(alarm_id = alarms_id.vt, alarms_count.mt) # nolint
alarms_info.df <- data.frame(alarm_ID = alarms_id.vt, alarms_region = alarms_region.vt) # nolint

alarms_count_long.df <- alarms_count.df  %>%  pivot_longer(cols = !alarm_id, names_to = 'date', values_to= 'frequency') # nolint
alarms_count_long.df <- alarms_count_long.df %>% separate(date, c('prefix',"year",'month','day')) # nolint

alarm_count_sa.df <- alarms_count_long.df %>% select(-prefix) %>% mutate(catrgory = if_else(frequency>=400, 'high', 'low') ) # nolint


alarm_merge.df <- alarm_count_sa.df %>% left_join(alarms_info.df, by =  c("alarm_id" = "alarm_ID"))      # nolint # nolint


#task 2
alarms_insight.df <- alarms_count.df %>%  pivot_longer(cols = !alarm_id, names_to = 'date', values_to = 'frequency') %>%
separate(date, c('prefix','year','month','day')) %>%
  select(-prefix) %>%
  mutate(category = if_else(frequency >= 400,'High','Low')) %>%
  left_join(alarms_info.df, by = c('alarm_id' = 'alarm_ID')) %>%
  group_by(year, month, day, alarms_region) %>%
  summarise(average_count = mean(frequency))



#Task 3
alarms_task3.df <- alarms_count.df  %>%  pivot_longer(cols = !alarm_id, names_to = 'date', values_to= 'frequency') %>% mutate(dd = as.Date(substring(date, 3), format('%Y.%m.%d'))) %>% mutate(week_day = wday(dd, label = TRUE, abbr = TRUE)) %>% select( - date) %>% group_by(week_day) %>% summarise(average_alarm = mean(frequency)) %>% arrange(desc(average_alarm)) # nolint

write.csv(alarms_insight.df, 'task2.csv' )
write.csv(alarms_task3.df,  "task3.csv" )
#setwd("Week_1")
#task2 <-read.csv('task2.csv')
#head(task2)