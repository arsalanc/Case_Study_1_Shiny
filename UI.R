library(shiny)
library(dplyr)
ui <- fluidPage(
  
  # App title ----
  titlePanel("Unit 12 assignment"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      fileInput('fileBeer', 'Choose Beers File',
                accept=c('text/csv', 'text/comma-separated- values,text/plain', '.csv')),
      
      fileInput('fileBrew', 'Choose Breweries File',
                accept=c('text/csv', 'text/comma-separated- values,text/plain', '.csv')),
      
      radioButtons("rbtn","Switch Plot",
                   choices = c("Histogram", "Box Plot"),
      ),
      
      # Input: Slider for the number of bins ----
      conditionalPanel(condition = "input.rbtn=='Histogram'",
                       sliderInput(inputId = "binsABV",
                                   label = "Number of bins for ABV:",
                                   min = 1,
                                   max = 50,
                                   value = 30),
                       sliderInput(inputId = "binsIBU",
                                   label = "Number of bins for IBU:",
                                   min = 1,
                                   max = 50,
                                   value = 30)
      ),
      selectInput(choices=c('ALL','AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA', 'HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME', 'MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM', 'NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX', 'UT','VA','VT','WA','WI','WV','WY'),inputId="States", label ="State"),
      
      radioButtons("regression","Linear Regression",
                   choices = c("On", "Off"),
      )
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      conditionalPanel(condition = "input.rbtn=='Histogram'",plotOutput(outputId ='ABVPlot'),plotOutput(outputId='IBUPlot')),
      conditionalPanel(condition = "input.rbtn=='Box Plot'",plotOutput(outputId ='ABVBox'),plotOutput(outputId='IBUBox')),
      conditionalPanel(condition = "input.regression=='On'", plotOutput(outputId = "BeerPlotLm")),
      conditionalPanel(condition = "input.regression=='Off'", plotOutput(outputId = "BeerPlot")),
      #tableOutput(outputId = 'table.output')
    )
  )
)