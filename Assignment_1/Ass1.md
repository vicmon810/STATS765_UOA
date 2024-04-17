# Milestone 1: Analysis rental hosing on market in New Zealand/Aotearoa

## Objective

### The ojective of my project is to analysis the rental market trends in New zealand/Aotearoa in pass 30 years(1993 - 2023)

## Data

My data analysis project will focused on Aotearoa rental market, I will utilize data obtained from mainly [tenancy servicer](https://www.tenancy.govt.nz/about-tenancy-services/data-and-statistics/rental-bond-data/) collection and  privoing open resource dataset. In the given dataset it records 66  regoin with  time ,median rentail price, mean rentail price, and differenct kinds of  bonds. 

By spcicify different kind of bonds are able to identitfy the rent hours move in status, lodged_bonds can be idenitify as aecurity deposites held by landloards or managing agents to safeguard the potential damages or unpaied rent during a tenancy. active_bond, refer Security deposite currently in use to secure rental properties which means the house is renting now. Cloes bond security deposits returned or no longer in effect following the end of a tenancy. 

In addition in the datset also given upper quartile rent which refers to the 75th percentile of rental price; lower quartile rent refers to the 25th percentile of rental price; and logarithm of standard devation of weekly rent which refers to the logarithms of the standard devation of weekly rental price, 



## Exploratory Ideas

1. Trend analysis of rental prices across regions over time: 
   - explore how median and mean tenal price changes over time across in Aotearoa
   - compare the distribution of rental prices in different regions
2. Analysis of rental price variability and affordability
   - calculate the upper and lower quarile rent for each regoin and examine their distrbution
   - Identify regions with high rental price variability or affordability challenges and poential facotors contributing to these trends.



## Approach

To start with, I need to have enough data from NZ's rental market. After wrangling and tidying data set, I am able to extract potental useful dataset into a human friendly format. Next setp is to filter unneed data to make my spread sheet from human friendly format into machine friendly format which requires all the columns are atomic.

## Challenges

- Use the NZ rental bond data to investigate if the law change in Feb did lead to more rentals drop off the market resulting in less rentals.