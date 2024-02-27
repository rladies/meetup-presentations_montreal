# Trying out ggplot2:

# First download ggplot2 package from CRAN:
install.packages("ggplot2")

# Now install into your "Packages" System library:
# You need to do this each time you open RStudio! Or just click the check box in your System Library.
library("ggplot2")

# Need to check for updates often. 
# Just go to System Library, click green "Update" button. Or check:
?update.packages()

# Now we need some data to practice with!
# Let's look at datasets that are provided with our loaded packages:
data(package = .packages(all.available = TRUE))

# If we just want to see the datasets available by a single package (e.g. ggplot2):
data(package = "ggplot2")

# Let's use the "diamonds" dataset. Let's load it:
data("diamonds")
# Now look at your Global Environment, you'll see "diamonds" listed under data.

# We can use functions to look at our data:
summary(diamonds) # statistical summary of the dataset

# To view the first n places of a dataset:
head(x = diamonds, n = 5)


# Making a plot with our diamonds dataset:

# Use the basic ggplot2 outline, and build up complexity as needed:

# 1: Super simple!!
ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point()

# 2: Add aesthetics based on other variables and observations:
ggplot(diamonds, aes(x = carat, y = price, colour = cut)) + 
  geom_point()

# 3: Or break down aesthetics using facets:
ggplot(diamonds, aes(x = carat, y = price, colour = cut)) + 
  geom_point() +
  facet_wrap(~cut) 

# 4: Add a smoothing geom to better understand scatter plots with lots of noise:
ggplot(diamonds, aes(x = carat, y = price, colour = cut)) + 
  geom_point() +
  geom_smooth(se = TRUE, colour = "black") +
  facet_wrap(~cut) 

# 5: Now force fit a linear line model (lm)! Lots of different model fits to explore and try.
ggplot(diamonds, aes(x = carat, y = price, colour = cut)) + 
  geom_point() +
  geom_smooth(se = TRUE, colour = "black", method = lm) +
  facet_wrap(~cut) 

# So many different types of graphs to explore and try!
# When in doubt, ask chatgpt to give you some lines of code. But always double check!!!

# Save your image:
ggsave("my_plot.png", 
       width = 25, # if your plot looks funny, make sure your width/height are large enough to resolve the plot
       height = 25,
       units = "cm",
       )

# Your plot will be saved in your working directory.
# To see what is your working directory:
getwd()

# To change your working directory (i.e. the folder you want to save your plot in):
setwd(path/to/your/directory)
# e.g. setwd("/Users/mcella/Desktop")
