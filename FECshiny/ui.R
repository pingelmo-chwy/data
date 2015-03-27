library(shiny)
library(shinythemes)
shinyUI(fluidPage(theme = shinytheme("spacelab"),
  
  titlePanel("US Presidential Spending by Category, 2012"),
  sidebarLayout(
    sidebarPanel(
                 sliderInput("cats","Choose categories to display:",min=1,max=15,value = 8,step = 1),
                 radioButtons("candidate","Select the candidate:",
                              list("Obama, Barack","Romney, Mitt","Paul, Ron","Perry, Rick","Santorum, Rick","Bachmann, Michele","Cain, Herman","Gingrich, Newt"))),           
      
    mainPanel(
              h3(textOutput("candidate")),
              h4(textOutput("cats")),
              plotOutput("plot"),
              dataTableOutput("spend")
      )
    )
  )
)
  
