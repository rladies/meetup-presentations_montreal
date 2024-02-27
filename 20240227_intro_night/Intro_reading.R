# Reading in your data

# Let's try reading in the same data set but in two different file types! 
# A plain text file and Excel spreadsheet (same data):

#!!!!IMPORTANT: Your files will be "read in" from your working directory.
#!!!!IMPORTANT: If your file is NOT in your working directory, you need to add the path to the file (or change your working directory, see Intro_ggplot2.R):
# e.g. path = "/User/mcella/Desktop/"

# Excel file:

# Install the readxl package and load to your library:
install.packages("readxl")
library("readxl")

# If you need help:
?readxl
?read_excel()

# Now read in your excel file! 
# Save it as an object (my_data)
my_data <- read_excel("Example_data.xlsx", col_names = TRUE) # column names are "x" and "y" in this example.

str(my_data) # Get info about your dataset

head(my_data, n = 5)
View(my_data) # View all of the data in table form (pop up appears!)

# CSV file ("comma separated values")

# Comma (,) separates the data, but other delimiters like semicolons (;), tabs (\t), or pipes (|) can also be used.
# You need to specify!
# Save this as an object also (my_data2)

my_data2 <- read.table("Example_data.csv", header = TRUE, sep = ",")

str(my_data2)
head(my_data2, n = 5)
View(my_data2)

# Now plot this data using what you learned with ggplot2! What is the shape of the graph?

# You can recycle this code using any data set you want.
# Just remember to change column names (col_names), delimiters, etc. 


