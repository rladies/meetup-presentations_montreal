# CRAN
## install.packages("plotly")

# or live dangerously w/ the development version
## devtools::install_github("ropensci/plotly")

# If you want to post to Plot.ly to save your charts 
# you can set your username and API key 
## Sys.setenv("plotly_username"="your_plotly_username")
## Sys.setenv("plotly_api_key"="your_api_key")

# Super simple example to make sure everything is set up ;)
library(plotly) 
sessionInfo() # updated/current: 4.7.1.9

# Create a super simple box plot
p <- plot_ly(midwest, x = ~percollege, color = ~state, type = "box") 
## plot in R studio viewer
p

## send to Plot.ly
api_create(p, filename = "boring_test_ex")

# ggplot2 w/ ggplotly() 

library(plotly)

p <- ggplot(diamonds, aes(x = price)) + 
  geom_density(aes(fill = color), alpha = 0.5) + 
  ggtitle("Kernel Density Estimates by Group")

p <- ggplotly(p)

# Send to Plotly
api_create(p, filename="kernel-plot")
