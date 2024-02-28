#install tidyverse
install.packages("tidyverse")

# load library
library(tidyverse)

# set random seed
seed <- 765 # <Replace '765' with your student ID here.>
set.seed(seed)

print("hell")

# generate alarm id, dates and region vectors
alarms_id.vt <- paste0('alarms_', sample(LETTERS, size = 10, replace = FALSE))
alarms_dates.vt <- paste0('d.',seq(Sys.Date()-60, Sys.Date(), by = '1 day'))  # 60 days back.
alarms_region.vt <- c('AKL_North', 'AKL_Central', 'Waiheke','AKL_South', 'AKL_Others')

# generate random alarm frequency counts
alarms_count.mt <- matrix(round(runif(length(alarms_id.vt) * length(alarms_dates.vt))*seed),
                          nrow = length(alarms_id.vt), ncol=length(alarms_dates.vt))
colnames(alarms_count.mt) <- alarms_dates.vt

# set up data frames
alarms_count.df <- data.frame(alarm_id = alarms_id.vt, alarms_count.mt)
alarms_info.df <- data.frame(alarm_ID = alarms_id.vt, alarms_region = alarms_region.vt)

alarms_count_long.df <- alarms_count.df  %>%  pivot_longer(cols = !alarm_id, names_to = 'date', values_to= 'frequency')
#print(alarms_count_long.df)
alarms_count_long.df <- alarms_count_long.df %>% separate(date, c('prefix',"year",'month','day'))
#print(alarms_count_long.df)
alarm_count_sa.df <- alarms_count_long.df %>% select(-prefix) %>% mutate(catrgory = if_else(frequency>=400, 'high', 'low') )
#print(alarm_count_sa.df)

alarm_merge.df <- alarm_count_sa.df %>% left_join(alarms_info.df, by =  c("alarm_id" = "alarm_ID"))     
#print(alarm_merge.df)

alarm_sum.df <- alarm_merge.df %>% group_by(year,month,day, alarms_region) %>% summarise(total = sum(frequency), percent_high = 100 * sum(catrgory == "high") / n())
print(alarm_sum.df)

