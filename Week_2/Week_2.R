# import libraries
# install.packages("readxl")
# install.packages("zoo")
# install.packages("purrr")

library(readxl) 
library(zoo)
library(purrr)
library(tidyverse)
library(patchwork)
# loading data 
raw.df <- read_excel("/Users/vicmon/stat765/STATS765_UOA/Week_2/simulation_outpu1_raw.xlsx", col_name = FALSE)
# raw.df <- read_excel"Week_2/simulation_outpu1_raw.xlsx", col_name = FALSE)

# # create column names
#  header_name <- expand.grid(x = c('small', 'medium', 'large'), y = c('office'), z = c('concrete', 'curtain-wall')) %>% mutate( nn = paste(x,y,z, sep ='_')) %>% pull(nn)

# # writing header name into each columns
# names(raw.df) <- c('weather', 'description',  header_name)

## create column names 
header_names <- expand.grid(x = c('small', 'medium', 'large'),
                            y = c('offices'),
                            z = c('concrete', 'curtainWall')) %>% 
  mutate(nn = paste(x, y, z, sep='_')) %>% 
  pull(nn)  

names(raw.df) <- c('weather', 'description', header_names)


## dealing with merged cells, create 'group' e.g. overall, sensible cooling etc
x1 <- as.data.frame(matrix(rep(NA, length(raw.df)), nrow = 1))
names(x1) <- names(raw.df)
df2 <- bind_rows(x1, raw.df) %>% 
  mutate(group = ifelse(is.na(description), 'overall',
                        ifelse(description=='Sensible Cooling', 'sensible_cooling',
                               ifelse(description=='Sensible Heating', 'sensible_heating', NA)))) %>% 
  fill(group, .direction = 'down') %>% 
  fill(weather, .direction = 'down') %>% 
  filter(!(description %in%c(NA, 'Sensible Cooling',
                             'Sensible Heating'))) %>% 
  pivot_longer(cols = small_offices_concrete:large_offices_curtainWall,
               names_to = 'CATEGORY',
               values_to = 'value') %>% 
  separate(CATEGORY, c('office_size', 'office', 'office_type'),
           sep='_') %>% 
  select(-office) 

glimpse(df2)
summary(df2)

# cooling condition 
cool <- df2 %>% filter(group %in% c("sensible_cooling" ))

# plotting Calculated Design Air Flow
desc_air_flow <- cool %>%  filter(description %in% c("Calculated Design Air Flow [m3/s]"))
desc %>%
  filter(office_size %in% c("small", "medium","large") )%>% 
  ggplot(aes(y = weather, x = value, color= interaction(office_size, office_type))) +
  geom_jitter()

# plotting User Design Air Flow 
desc_peak <- cool %>% filter( description %in% c("User Design Air Flow [m3/s]")) #%>%  filter(weather %in% c("Very Hot Humid (Honolulu, HI)")) 

desc_peak %>%
  ggplot(aes(y = weather, x = value, color= interaction(office_size, office_type))) +
  geom_jitter()


# Create the plots for desc_air_flow and desc_peak
plot_air_flow <- desc_air_flow %>%
  filter(office_type %in% c("concrete")) %>%
  filter(office_size %in% c("small", "medium", "large")) %>% 
  ggplot(aes(y = weather, x = value, color = office_size)) +
  geom_jitter() +
  labs(title = "Calculated Design Air Flow")

plot_peak <- desc_peak %>%
  filter(office_type %in% c("concrete")) %>%
  filter(office_size %in% c("small", "medium", "large")) %>%
  ggplot(aes(y = weather, x = value, color = office_size)) +
  geom_jitter() +
  labs(title = "User Design Air Flow")

# Arrange the plots side by side
plot_air_flow + plot_peak + plot_layout(ncol = 2)


# listing Thermostat Setpoint Temperature at Peak Load by weather condition
desc_temp <- cool %>% filter(description %in% c("Thermostat Setpoint Temperature at Peak Load [C]"))
desc_temp %>%
  ggplot(aes(y = weather, x = value, color= interaction(office_size, office_type))) +
  geom_jitter()
# listing Outdoor Temperature at Peak Load by weather condition
desc_out_door <- cool %>%  filter(description %in% c("Outdoor Temperature at Peak Load [C]"))
desc_out_door %>%     ggplot(aes(y = weather, x = value, color = interaction(office_size, office_type))) +
  geom_jitter()

# plotting Outdoor Humidity Ratio at Peak Load by weather condition
desc_hum_rat <- cool %>%  filter((description %in% c("Outdoor Humidity Ratio at Peak Load [kgWater/kgAir]")))
desc_hum_rat  %>%   ggplot(aes(y = weather, x = value, color =  interaction(office_size, office_type))) +
  geom_jitter()


# Heating 
heat <- df2 %>%  filter(group %in% c("sensible_heating"))

# plotting Calculated Design Air Flow
desc_air_flow <- heat %>%  filter(description %in% c("Calculated Design Air Flow [m3/s]"))
desc %>%
  filter(office_size %in% c("small", "medium","large") )%>% 
  ggplot(aes(y = weather, x = value, color= interaction(office_size, office_type))) +
  geom_jitter()

# plotting User Design Air Flow 
desc_peak <- heat %>% filter( description %in% c("User Design Air Flow [m3/s]")) #%>%  filter(weather %in% c("Very Hot Humid (Honolulu, HI)")) 

desc_peak %>%
  ggplot(aes(y = weather, x = value, color= interaction(office_size, office_type))) +
  geom_jitter()


# Create the plots for desc_air_flow and desc_peak
plot_air_flow <- desc_air_flow %>%
  filter(office_type %in% c("concrete")) %>%
  filter(office_size %in% c("small", "medium", "large")) %>% 
  ggplot(aes(y = weather, x = value, color = office_size)) +
  geom_jitter() +
  labs(title = "Calculated Design Air Flow")

plot_peak <- desc_peak %>%
  filter(office_type %in% c("concrete")) %>%
  filter(office_size %in% c("small", "medium", "large")) %>%
  ggplot(aes(y = weather, x = value, color = office_size)) +
  geom_jitter() +
  labs(title = "User Design Air Flow")

# Arrange the plots side by side
plot_air_flow + plot_peak + plot_layout(ncol = 2)


# listing Thermostat Setpoint Temperature at Peak Load by weather condition
desc_temp <- heat %>% filter(description %in% c("Thermostat Setpoint Temperature at Peak Load [C]"))
desc_temp %>%
  ggplot(aes(y = weather, x = value, color= interaction(office_size, office_type))) +
  geom_jitter()
# listing Outdoor Temperature at Peak Load by weather condition
desc_out_door <- heat %>%  filter(description %in% c("Outdoor Temperature at Peak Load [C]"))
desc_out_door %>%     ggplot(aes(y = weather, x = value, color = interaction(office_size, office_type))) +
  geom_jitter()

# plotting Outdoor Humidity Ratio at Peak Load by weather condition
desc_hum_rat <- heat %>%  filter((description %in% c("Outdoor Humidity Ratio at Peak Load [kgWater/kgAir]")))
desc_hum_rat  %>%   ggplot(aes(y = weather, x = value, color =  interaction(office_size, office_type))) +
  geom_jitter()

###te1123

