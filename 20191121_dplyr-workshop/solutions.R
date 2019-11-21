
# Bind the two rows together, what are the new dimenions of the data frame? 
  
df <- bind_rows(births_2003_2006, births_2007_2018)
dim(df)

#Alternatively
ncol(df)
nrow(df)

# Rmove the first column of the data with the "Notes"
  
df %>% select(-Notes) %>% head()


# Remove all observations where Average.LMP.Gestational.Age has missing values 

df %>% filter(!is.na(Average.LMP.Gestational.Age)) %>% head()


# Calculate the average birth weight by state 

df %>% group_by(State) %>% 
  mutate(avg_bw = mean(Average.Birth.Weight, na.rm = T)) %>% 
  head(2)

df %>% group_by(State) %>% 
  summarise(avg_bw = mean(Average.Birth.Weight)) %>% 
  head(2)


# What were the the states with the 5 highest fertility rates in 2010?  
  
  
df %>% filter(Year == 2010) %>% # restrict to 2010
  group_by(State) %>% # collapse over racial groups
  summarise(avg_fertility = mean(Fertility.Rate)) %>% #calculate new state-level average
  arrange(desc(avg_fertility)) %>% #sort average fertility rates in ascdending order
  top_n(5) %>% #select highest values
  head(5) 



