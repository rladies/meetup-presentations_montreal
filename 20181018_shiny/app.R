# R-Ladies Montreal
# Intro to Shiny tutorial

pacman::p_load(shiny, readr, ggplot2, tidyr, dplyr)

# Read dataset for recent graduates
recent_grads <- read_csv("recent-grads.csv")

#Remove scientific notation for labelling
options(scipen=10000)

# Plot the share of women in a field as a function of the median income
ggplot(recent_grads, aes(x=Median, y=ShareWomen)) + 
  geom_point(aes(color=Major_category))

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("How much do female college graduates make in the US?"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
        #When you add an input, the first argument is an inputID
        #The second input is the label for the input in your application
         selectizeInput("major",
                     "Major:",
                     choices = recent_grads$Major_category,
                     options = list(maxItems=16)
                     )
      ),
      
      # Define the plot in the UI
      mainPanel(
         plotOutput("collegePlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #Subset data using the user selected inputs for major categories
  #Make data reactive
  
  data <- reactive({
    majors <- subset(recent_grads, Major_category == input$major)
    return(majors)
    
  }) 
  
  #Here is where we write the code that renders the plot
   output$collegePlot <- renderPlot({
  
     #Instead of using the original dataset, we use the reactive data
     #that is subsetted using the user inputs
       ggplot(data(), aes(x=Median, y=ShareWomen)) + 
       geom_point(aes(color=Major_category)) +
       ylab("Share that are women") +
       guides(color=guide_legend(title="Type of major")) 
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

