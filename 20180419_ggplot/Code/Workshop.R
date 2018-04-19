#If you haven't already, please follow the instructions in setup.md before proceeding!

#Read in the first dataset
BlackWhite_results <- read.csv("./Data/BlackWhite_results.csv")

#Let's first use the viewer to look at these data.
# 1. Click the data icon next to BlackWhite_results in the environment tab
# Or run the code:
View(BlackWhite_results)

#These are some results from a study I did on the inequality in life expectancy between blacks and whites in the US.
#Let's first examine the structure of the dataset:
str(BlackWhite_results)

#Hmm, what are the first three variables?
#Use the dollar sign to access the variables within the data frame:
head(BlackWhite_results$X.2) #first six
tail(BlackWhite_results$X.2) #last six
identical(BlackWhite_results$X.1, BlackWhite_results$X.2) #are these variables the same?
#it looks like they just count the rows. Let's remove them from the dataset:

#Data manipulation is best done using functions from the package "dplyr"

#install.packages("dplyr") #if you haven't installed this package before, you need to do it now!
library(dplyr) #load this package
#notice the output in the console. These pink notes are called "messages"
#These messages are telling you that the functions "filter" and "lag" from dplyr are named the same thing
#as functions from the pre-loaded stats package. So now when you call the function filter() or lag()
#you will use the dplyr version of those functions. It also has functions that are the same names as 
#four functions from the base R package.

#Use the select() function from dplyr to select the rows you want to keep in the dataset. 
#Here we use subtractive select with the negative sign to remove the rows.

cleaned.data <- select(BlackWhite_results, -X, -X.1, -X.2)
#notice how the number of variables has changed in the environment tab vs. the original data

#now let's erase cleaned.data using the remove function, rm():
rm(cleaned.data)

#and recreate it using the piping operator:
cleaned.data <- BlackWhite_results %>% select(-X, -X.1, -X.2)

#We can View() cleaned.data or remind ourselves of the variables contained in the data frame:
names(cleaned.data)

#let's examine some of the variables a little more closely
table(cleaned.data$sex)
table(cleaned.data$state)
table(cleaned.data$year)
table(cleaned.data$state, cleaned.data$Census_Region)

#also useful is the unique() function:
unique(cleaned.data$sex)
unique(cleaned.data$Census_Division)
length(unique(cleaned.data$Census_Division))

#much less useful for continuous data!:
unique(cleaned.data$LE_black_lcl)

str(cleaned.data$state)
#let's talk about factors 
#factors have levels and levels are ordered.
#by default factors are ordered alphabetically if they are words.
levels(cleaned.data$state) #this prints a vector of the factor levels in their order
length(levels(cleaned.data$state)) #this prints the length

#some other useful dplyr functions:
#1. filter()
#2. group_by(), summarise()
Alabama.data <- cleaned.data %>% filter(state == "Alabama", sex == "Male")

Alabama.data %>% summarise(overall.mean.white = mean(LE_white_mean), overall.mean.black = mean(LE_black_mean))
#EXERCISE: extend the above statement to also compute the mean of the variable "LE_wbgap_mean"

#Rather than doing the above in two separate steps you can "pipe" the steps together:

cleaned.data %>%
  filter(state == "Alabama", sex == "Male") %>%
  summarise(overall.mean.white = mean(LE_white_mean), overall.mean.black = mean(LE_black_mean))

#What if you wanted to compute the summary for females and for males?
#Hint: we need to use the group_by() function as one of our commands, and also slightly modify the filter() command.

#SOLUTION:
#we will fill this in together, and I will send a complete file with solutions after class.

#EXERCISE: Compute the summary for females and males in every state.

#SOLUTION:

######################################################################################################
#What we've learned so far:

#IMPORTING DATA
#read.csv() for importing .csv data. There is also read.table for .txt data
#to read data exported from state you will need to load the foreign library and use read.dta()
#to read files exported from Stata version 13 you need to load the readstata13() package and use read.dta13()

#LOOKING AT THE DATASET
#View(), str(), head(), tail(), table(), length(), unique()

#summary() is another good function. Useful for continuous data:
summary(Alabama.data$LE_white_mean)

#and so is quantile()
quantile(Alabama.data$LE_black_mean)
quantile(Alabama.data$LE_black_mean, 0.3)

#MANIPULATE THE DATA
#select(), filter(), group_by(), summarise()
#Note that summarise computes a variety of summary functions -- our example focused on computing the mean.
#Other common summary functions: median(), sum(), first(), last(), n(), min(), max(), sd()

#Summarise the number of rows per stratum:
cleaned.data %>% 
  group_by(sex, state) %>%
  summarise(num.per.strata = n())
#Alternatively, we could have written:
cleaned.data %>% 
  group_by(sex, state) %>%
  tally()
#This is really useful if you have panel data and want to know the number of visits per patient, say.
#Or, before running a multi-level model, you could check the cluster sizes for all your clusters

################################################################################################################

#SECTION 2: DATA VISUALIZATION

#In R, there are "base R graphics", but most folks prefer the ggplot2 graphing library
library(ggplot2) #remember to first install the package if you haven't done so already

#the main function in ggplot2 is "ggplot"!

#this function creates a plotting window that reflects the range of X and Y in the data.frame
ggplot(data = Alabama.data, aes(x = year, y = LE_white_mean))

#we need to tell it how to plot the time series of the mean life expectancy for whites.
#Let's start by plotting points:
ggplot(data = Alabama.data, aes(x = year, y = LE_white_mean)) +    
  geom_point()                                  

#NOTE: the plus sign needs to always be at the end of the line. The following code WILL NOT add the geom_point() command:
ggplot(data = Alabama.data, aes(x = year, y = LE_white_mean))
+ geom_point() 

#Within the geom_point() function, you can customize the appearance of the points:
ggplot(data = Alabama.data, aes(x = year, y = LE_white_mean)) + 
  geom_point(col = "red", size = 2, pch = 3)

#Would you prefer to have a line instead?
#EXERCISE: how do you think you'd plot a line in ggplot? Give it a go. Hint: change geom_point to another type of "geom"
#SOLUTION:

#EXERCISE: Titles
#ggtitle("This is a title") adds a title to the ggplot. Add one!
#Also use xlab() and ylab() to update the assigned x and y labels.

#SOLUTION

#How can we choose nice colours?
#Nice online colour pickers:
#http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
#http://tristen.ca/hcl-picker/#/hlc/6/1/15534C/E2E062
#pick a colour you like and copy its HEX value, including the "#". Then specify col = "#12345", where 12345 is the HEX value.
#some nice colours: #1c9099, #7F526D

#SOLUTION

#It would be nice to also plot the life expectancy for females during the same time period.

#EXERCISE: user dplyr functions on the cleaned.data to create and store a new dataset that 
#contains the Alabama data for both males and females. Call the new dataset Alabama.both.genders:

#SOLUTION:

#Let's plot the Alabama data using the previous code: 
ggplot(data = Alabama.both.genders, aes(x = year, y = LE_white_mean)) + 
  geom_line(col = "#7F526D", size = 2) + #ho boy, what is happening here? any guesses?
  xlab("Year") + ylab("Mean life expectancy (years)") 

#Try:
ggplot(data = Alabama.both.genders, aes(x = year, y = LE_white_mean)) + 
  geom_point(col = "#7F526D", size = 2) + #better, but still not ideal. What would make this better?
  xlab("Year") + ylab("Mean life expectancy (years)") 

#Option 1: Different colours for each gender:
ggplot(data = Alabama.both.genders, aes(x = year, y = LE_white_mean)) + 
  geom_point(aes(col = sex), size = 2) + 
  xlab("Year") + ylab("Mean life expectancy (years)") 

#Option 2: Separate panels (aka "facets") for each gender:
ggplot(data = Alabama.both.genders, aes(x = year, y = LE_white_mean)) + 
  geom_point(size = 2) + 
  facet_wrap(~sex) +
  xlab("Year") + ylab("Mean life expectancy (years)") 

#Let's use these same skills to look at a larger dataset

#EXERCISE
#PART 1: Use dplyr functions to create a new dataset containing data on only females. Call it data.females
#You now have time series data for 40 states for black and white females.

#SOLUTION

#PART 2: plot the mean life expectancy for white females using geom_point or geom_line. 
#Use one of the options learned in the previous step to plot a separate line for each state.
#Which option do you like best?

#SOLUTION A

#SOLUTION B

#For the previous plot, it would be really helpful if we could more easily tell which line is which
#Plotly is a graphing package that adds interactive components: hover, zoom, highlighting
#For many ggplots, you can pipe them to ggplotly() to easily add these interactive components:

library(plotly) # don't forget to install first if you haven't done so already

#here, we're saving the ggplot plot and calling it "our.plot"
our.plot <- ggplot(data = data.females, aes(x = year, y = LE_white_mean)) + 
  geom_line(aes(col = state)) + 
  xlab("Year") + ylab("Mean life expectancy (years)")

#then, we send the ggplot to the plotly() function ggplotly() to add hover text:
our.plot %>% ggplotly()

###EXERCISE: Incorporate information on Census_Divsion or Census_Region into the ggplot to make it more readable. 
#Hint: Use both aes(col) and facet_wrap(~). Use one of the census variables, as well as the state variable.
#Once you have a plot you like, make it interactive using ggplotly.

#first, remind yourself what the census variables are named:
names(data.females)

#SOLUTION

######################################################################################################
#What have we learned so far:
#geom_point(), geom_line()
#how to set colour to a fixed value, e.g., col("red") or col(#7F526D)
#how to set colour according to the value of a variable, e.g. aes(col = state). The aes() wrapper is crucial!
#facet_wrap() to make separate panels for each level of a variable
#labels: ggtitle(), xlab(), ylab()
#ggplotly() to make a ggplot interactive. Works on most ggplots!
######################################################################################################

#EXERCISE 1: Start with cleaned.data() and use a dplyr function to keep only data from the years 1969 and 2013
#HINT: In R "|" is the OR operator and "&" is the AND operator.
#Use one of these operators inside a filter() statement to fiter these two years of data

#SOLUTION 1:

#Alternatively, use the %in% operator. 
#SOLUTION 2:
 
#EXERCISE 2: make a histogram of black life expectancy, with separate panels for year and sex.
#You'll need to use two new functions: geom_histogram() and facet_grid(var1~var2).
#HINT: Since histograms are univariate, you only need to set x in the ggplot() command.

#SOLUTION

#EXERCISE 3: This is kind of ugly. Change the colour. Did that do as you expected? Try also changing the fill.

#SOLUTION 1:

#SOLUTION 2:

#EXERCISE 4: Update the colour to "white", and change the fill to be a function of sex. Remember aes()!

#SOLUTION:

#If you don't like the grey background, an easy way to remove it is to modify the underlying theme:  
#tab through the themes and apply them to find the one you like.

#SOLUTION:

################################################################################################################

#SECTION 3: ANOTHER DATASET, ANOTHER DATA VISUALIZATION

#Here is some data on global cesarean delivery rates
CS.data <- read.csv("./Data/Cesarean.csv")
#Check out CS.data using some of the commands we learned earlier.
#There is a variable called "X2006". This variable is the gross domestic product in 2006 for the corresponding country.
#Let's use the dplyr function rename() to give this variable a better name.
# example.data <- example.data %>% rename(new.name = old.name)

CS.data <- CS.data %>% rename(gdp.2006 = X2006)

#CS_Rate2 is the cesarean delivery rate as a proportion < 1. For graphing purposes, it will be nice to have this variable
#have an upper bound of 100.
#Use the dplyr function mutate() to create a new variable based on CS_Rate2 that is multiplied by 100.
# example.data <- example.data %>% mutate(mutated.var = function(existing.var)). 

CS.data <- CS.data %>% mutate(CS_Rate = CS_Rate2*100)

#Drop two of the country variables and keep the third. Use View() to look at the values and choose the best variable to keep
#Also drop the old CS_Rate2 variable
CS.data <- CS.data %>% select(-Country.y, -Country.x, CS_Rate2)

#EXERCISE
#Visually assess the relationship between GDP and cesarean delivery rate using a scatter plot (i.e., geom_point).
#Start simple and then keep enhancing the ggplot until it is awesome.
#Remember: col(), fill(), and size(). Also, remember the themes.
#Experiment with geom_text(). Type ?geom_text into the console to open a help window and learn about it or google it!

#The very basics
ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point()

#There is a lot of data smushed near 0, especially on the x-axis -- could a transformation help?
#we can transform the x-axis to log using scale_x_log10()

#much better!
ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(col = Region)) +
  scale_x_log10()

#where should size of the points come in?
ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(col = Region, size = Births_Per_1000)) +
  scale_x_log10()

#I want the points to all be BIGGER! You can adjust the max point size using scale_size_area(max_size = ##)
ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(col = Region, size = Births_Per_1000)) +
  scale_x_log10() + 
  scale_size_area(max_size = 20)

#oh boy, the legend is massive -- let's remove it. And some points are overlapping -- you can make the points semi-transparent
#by setting the alpha parameter to a value between 0 and 1:
ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(col = Region, size = Births_Per_1000, alpha = 0.5)) +
  scale_x_log10() + 
  scale_size_area(max_size = 50, guide = "none")

#which country is which?
ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(col = Region, size = Births_Per_1000, alpha = 0.5)) +
  scale_x_log10() + 
  scale_size_area(max_size = 50, guide = "none") +
  geom_text(aes(label = Country_Name))

#too many labels. Let's use an ifelse() statement to selectively display labels for a certain set of countries
ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(col = Region, size = Births_Per_1000, alpha = 0.5)) +
  scale_x_log10() +
  scale_size_area(max_size = 50, guide = "none") +
  geom_text(aes(label = ifelse(Region == "North America", as.character(Country_Name), "")))

ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(col = Region, size = Births_Per_1000, alpha = 0.5)) +
  scale_x_log10() +
  scale_size_area(max_size = 50, guide = "none") +
  geom_text(aes(label = ifelse(Births_Per_1000 > 1000, as.character(Country_Name), "")))

#some more style changes: add axis labels, change the theme
ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(col = Region, size = Births_Per_1000, alpha = 0.5)) +
  scale_x_log10() +
  scale_size_area(max_size = 50, guide = "none") +
  scale_alpha_continuous(guide = "none") +
  geom_text(aes(label = ifelse(Births_Per_1000 > 1000, as.character(Country_Name), ""))) +
  xlab("GDP") + ylab("Cesarean delivery rate (%)") + theme_minimal()

#changes the format of the x axis labels:
cs.plot <- ggplot(data = CS.data, aes(x = gdp.2006, y = CS_Rate)) + 
  geom_point(aes(fill = Region, size = Births_Per_1000, alpha = 0.5), col = "black", shape = 21) +
  scale_x_log10(breaks = c(1, 100, 1000, 10000), labels = c(1, 100, 1000, 10000)) +
  scale_size_area(max_size = 50, guide = "none") +
  scale_alpha_continuous(guide = "none") +
  geom_text(aes(label = ifelse(Births_Per_1000 > 700, as.character(Country_Name), ""))) +
  xlab("GDP") + ylab("Cesarean delivery rate (%)") + theme_minimal() 
  
cs.plot %>% ggplotly()

######################################################################################################
#What else did we learn:
#dplyr functions rename() to change variable names, and mutate() to add new variables based on existing variables
#alpha() to control transparency, shape() to change shape of geom_point()
#scale_x_log10() to use a log-transformed x-axis
#geom_text() to add labels to the plot
#ifelse() operator. If true then do: ...., else, do: ....

#Really useful resources for learning ggplot2 and dplyr:
#ggplot2 cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
#dplyr cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

