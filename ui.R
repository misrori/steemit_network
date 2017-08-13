library(shiny)
library(plotly)
library(DT)
library(data.table)
library(shinycssloaders)
library(networkD3)

# for spinners 2-3 match the background color of wellPanel
options(spinner.color.background="#F5F5F5")

navbarPage(
  title="Steemit network",theme = "cosmo",
  tabPanel("Elemzés",
           withSpinner(forceNetworkOutput('net',height=900),type = 4),

           h2(textOutput('my_text'), align='center'),
           absolutePanel( top=80, left = 40, width = 150,draggable = T,style = "opacity: 0.8",
                          wellPanel(
                            textInput("name", "Name",value = ""),
                               actionButton("goButton", "Get Network!"),
                            radioButtons("type", 'Choose', choiceNames = c('Following', "Followers"), 
                                         choiceValues =c('following', "followers") ),
                               radioButtons("my_node", 'Node size', choiceNames = c('SP', 'REP', 'Following', "Followers", 'Post'), 
                                            choiceValues =c('sp', 'rep', 'following_count', "followers_count", 'post_count') )
                          )#well
           )#abs
  ),#tab 
  tabPanel('Credit')

)#nav
