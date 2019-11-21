
# install.packages('dplyr')

library(dplyr)

# Data source: https://wonder.cdc.gov/

births_2003_2006 <- readRDS("data/births_2003_2006.rds")
births_2007_2018 <- readRDS("data/births_2007_2018.rds")
names(births_2007_2018)


# Activity

#Using dplyr and the example data, complete the following exercises: 

#  (1) Bind the two data frames into a single data frame. What are the new dimensions of the data frame? 
#  (2) Delete the first column of the data with the "Notes"
#  (3) Remove all observations where Average.LMP.Gestational.Age has missing values
#  (4) Calculate the average birth weight by state using mutate and summarise. How are the results different? 
#  (5) What were the the states with the 5 highest fertility rates in 2010 (tricky question!) 
  