library(shiny)
library(plotly)
library(data.table)
library(networkD3)


function(input, output, session) {
  source('network_functions.R')
  my_text_input <- eventReactive(input$goButton, {
    my_l <- strsplit(gsub(pattern = ' ', '', input$name), ',')
    return(my_l[[1]])
   
  })
  
  
  my_reactive_net <- eventReactive(input$goButton,{
    return(get_group_network(my_text_input(), input$my_node, input$type))
  })
  
  output$net <- renderForceNetwork(my_reactive_net())
  
}


