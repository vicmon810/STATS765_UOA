# import needed library 
library(tidyverse)
# read data from folder
data <- read.csv("/Users/vicmon/stat765/STATS765_UOA/Assignment_1/rent.csv")

#Time 
time <- data[,0]
#location Id
location_id <- data[,1]
#lodged bonds 
lodged_bonds <- data[,4]
# active bonds 
active_bonds <- data[,5]

lodged_bonds%>%ggplot(aes(time))+geom_bar()

# Auckland 
# Wellington
# Christchurch 
# Hamilton








