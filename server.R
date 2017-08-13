library(shiny)
library(plotly)
library(data.table)



function(input, output, session) {
  
  my_text_input <- eventReactive(input$goButton, {
    return(input$name)
    
  })
  
  
  output$my_text <- renderText("fejlesztés")
  
}


