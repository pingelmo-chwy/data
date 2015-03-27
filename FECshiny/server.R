library(shiny)
library(dplyr)
library(ggplot2)
library(scales)

pres12 <- read.csv("pres2012.csv",header=T)
spend <- pres12 %>% group_by(candidate_name,disbursement_description) %>% summarize(amt=sum(disbursement_amount)) %>% arrange(desc(amt))
names(spend) <- c("candidate_name","expense_description","expense_amount")

shinyServer(
  function(input,output){
    
    output$candidate <- renderText(input$candidate)
    output$cats <- renderText(paste("Display top ", input$cats, " categories"))
    output$plot <- renderPlot(spend %>% filter(candidate_name==input$candidate,row_number()<=input$cats) %>%  
                                ggplot(aes(x=reorder(expense_description,-expense_amount),y=expense_amount,fill=expense_description)) +
                                geom_bar(stat="identity")+theme(axis.title.x=element_blank(),axis.title.y=element_blank(),axis.text.x=element_text(angle=30,size=8,vjust=.5),legend.position="none",plot.title=element_text(size=rel(1.5)))+
                                scale_y_continuous(labels=dollar)+ggtitle("US Presidential Spending by Category, 2012"))
    output$spend <- renderDataTable(spend %>% filter(candidate_name==input$candidate), options = list(pageLength = 10,pagingType="simple",searchable=FALSE))
  }
)