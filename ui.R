library(shiny)
library(plotly)
library(DT)
library(data.table)
library(plotly)
library(shinycssloaders)


# for spinners 2-3 match the background color of wellPanel
options(spinner.color.background="#F5F5F5")

navbarPage(
  title="Crypto report",theme = "cosmo",
  tabPanel("Elemzés",
           #withSpinner(plotlyOutput('summary_plot', height = 720),type = 4),
           h2(textOutput('my_text'), align='center'),
           absolutePanel( top=80, left = 40, width = 150,draggable = T,style = "opacity: 0.8",
                          wellPanel(
                            textInput("name", "Name",value = ""),
                               actionButton("goButton", "Get Network!"),
                               radioButtons("my_node", 'Node size', choiceNames = c('SP', 'REP', 'Following', "Followers", 'Post'), 
                                            choiceValues =c('sp', 'rep', 'following', "followers", 'post_count') )
                          )#well
           )#abs
  ),#tab 
  tabPanel('Credit')

)#nav
