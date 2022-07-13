library(shiny)
library(dplyr)
server <- function(input, output) {
  
  mydata <- reactive({
    
    inFile <- input$fileBeer
    
    inFile2 <- input$fileBrew
    if (is.null(inFile) & is.null(inFile2))
      return(NULL)
    beers<- read.csv(inFile$datapath)
    brews <- read.csv(inFile2$datapath)
    
    dat<- left_join(beers, brews, by= c("Brewery_id"= "Brew_ID"))%>%
      rename("BeerName"= "Name.x", Brewery.Name="Name.y" )
    return(dat)
  })
  #output$table.output <- renderTable({
  #data = filter(mydata(),grepl('IN',State))
  #})
  
  output$ABVPlot <-renderPlot({
    
    state <- input$States
    if(state != "ALL"){
      BeerABV = filter(mydata(),!is.na(ABV),grepl(state,State))
      
    }
    else{
      BeerABV = mydata()%>% filter(!is.na(ABV))
      
    }
    x <- BeerABV$ABV
    bins <- seq(min(x), max(x), length.out = input$binsABV + 1)
    
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "ABV",
         main = "Histogram of ABV")
    
  })
  output$IBUPlot <-renderPlot({
    state <- input$States
    if(state != "ALL"){
      BeerIBU = filter(mydata(),!is.na(IBU),grepl(state,State))
      
    }
    else{
      BeerIBU = mydata()%>% filter(!is.na(IBU))
      
    }
    x <- BeerIBU$IBU
    bins <- seq(min(x), max(x), length.out = input$binsIBU + 1)
    
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "IBU",
         main = "Histogram of IBU")
    
  })
  
  
  output$ABVBox <-renderPlot({
    
    state <- input$States
    
    if(state != "ALL"){
      BeerABV = filter(mydata(),!is.na(ABV),grepl(state,State))
      
    }
    else{
      BeerABV = mydata()%>% filter(!is.na(ABV))
      
    } 
    x <- BeerABV$ABV
    boxplot(x, col = "#75AADB",
            ylab = "ABV",
            main = "Boxplot of ABV")
    
  })
  
  output$IBUBox <-renderPlot({
    state <- input$States
    if(state != "ALL"){
      BeerIBU = filter(mydata(),!is.na(IBU),grepl(state,State))
      
    }
    else{
      BeerIBU = mydata()%>% filter(!is.na(IBU))
    }
    
    x <- BeerIBU$IBU
    boxplot(x, col = "#75AADB",
            ylab = "IBU",
            main = "Boxplot of IBU")
    
  })
  
  output$BeerPlotLm <-renderPlot({
    
    state <- input$States
    if(state != "ALL"){
      Beer = filter(mydata(),!is.na(IBU),!is.na(ABV),grepl(state,State))
      
    }
    else{
      Beer = mydata()%>% filter(!is.na(IBU) & !is.na(ABV))
    }
    x <- Beer$ABV
    y <- Beer$IBU
    
    plot(x,y, col = "black",pch=20,
         ylab = "IBU",
         xlab = "ABV",
         main = "ABV vs IBU")
    abline(lm(y ~ x),col="red",lwd=3)
  })
  
  output$BeerPlot <-renderPlot({
    state <- input$States
    if(state != "ALL"){
      Beer = filter(mydata(),!is.na(IBU),!is.na(ABV),grepl(state,State))
      
    }
    else{
      Beer = mydata()%>% filter(!is.na(IBU) & !is.na(ABV))
    }
    x <- Beer$ABV
    y <- Beer$IBU
    
    plot(x,y, col = "black",pch=20,
         ylab = "IBU",
         xlab = "ABV",
         main = "ABV vs IBU")
  })
  
}