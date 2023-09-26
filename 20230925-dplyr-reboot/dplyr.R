 
library(ClustOfVar) 
library(dplyr) 
library(ggplot2) 

data(dogs)  

### VERBS: select() picks variables based on their names

# look at only the "size" and "weight" columns

dogs %>% select(Size, Weight) 

# look at all columns except "speed" 

dogs %>% select(-Speed)



### VERBS: filter() picks cases based on their values

# Which dogs are "high" in intelligence? 

dogs %>% filter(Intelligence == "high")


# Which dogs are large, in both size and weight? 

dogs %>% filter(Size == "large" & Weight == "large")


# Which dogs are large, in either size or weight? 

dogs %>% filter(Size == "large" | Weight == "large")



### VERBS: arrange() changes the ordering of the rows

# arrange all dogs by their function, in alphabetical order 

dogs %>% arrange(Function)


# arrange all dogs by their function, in reverse alphabetical order 

dogs %>% arrange(desc(Function)) 


### VERBS: mutate() adds new variables that are functions of existing variables 


# add a unique ID for each row (each breed) 

dogs %>% mutate(ID = 1:n()) 


# add an indicator variable to identify "large" (in size) dogs 

# ?ifelse

dogs %>% mutate(Large = if_else(Size == "large", 1, 0)) 


### VERBS: summarise() reduces multiple values down to a single summary 

# how many dogs of each intelligence type are there? 

dogs %>% 
  group_by(Intelligence) %>% 
  summarise(Number = n())



### Changing the data  

# if we want to save the changes we've made to our data frame/tibble, 
# we can either overwrite the original data frame, or create a new one

# new data set 
dogs2 <- dogs %>% mutate(Breed_ID = 1:n()) 

head(dogs2)
head(dogs)

#overwriting 
dogs <- dogs %>% mutate(Breed_ID = 1:n())



# Joining 

# left_join()	Merge two datasets. Keep all observations from the origin table

# right_join()	Merge two datasets. Keep all observations from the destination table

# inner_join()	Merge two datasets. Excludes all unmatched rows
 



# Let's create a sample dataset that we can link to our dogs data 

dogs_new <- data.frame(
  Breed_ID = 20:29, 
  IQ = c(102, 84, 99, 85, 114, 91, 98, 88, 97, 106)
  )

rownames(dogs_new) = c(rownames(dogs)[20:27], "GoldenDoodle", "SmoothCollie")

dogs_new


# left_join()	Merge two datasets. Keep all observations from the origin table 

dogs_new %>% left_join(dogs, by = "Breed_ID") 


# right_join()	Merge two datasets. Keep all observations from the destination table

dogs_new %>% right_join(dogs, by = "Breed_ID") 


# inner_join()	Merge two datasets. Excludes all unmatched rows

dogs_new %>% inner_join(dogs, by = "Breed_ID") 


# full_join()	Merge two datasets. Keeps all observations

dogs_new %>% full_join(dogs, by = "Breed_ID") 

full_join(dogs_new, dogs, by = "Breed_ID") 

#now try with msleep

data(msleep)




