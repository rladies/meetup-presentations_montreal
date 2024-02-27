# The Basics

# The "#" are used to add comments, they don't do anything when you run code!
# But they're really great for adding notes about your programs.

# Let's make an object: 
my_fav_number <- 17

# Perform any numerical calculations on your object:
my_fav_number * 2
my_fav_number / 456

cos(1/(my_fav_number * pi))

# But these are just printed out, not retained!

# Assign a new object name:
new_fav_number <- cos(1/(my_fav_number * pi))
print(new_fav_number)

# Now make a list:
list <- c(2, 3, 5, 7, 11, 13)

# Performing calculations across the entire list:
list / new_fav_number

# What is wrong here?
list / New_fav_number


# Calling functions

# R has many built-in functions to complete specific tasks. 
# Each function has a name and a list of arguments.
seq(from = 1, to = 100)

# You don't always have to list the argument names for the function to work:
seq(1, 100)

# There are thousands of functions to choose from, in base R and in different packages.
# If you need help with the arguments (or with functions in general):
?seq()

