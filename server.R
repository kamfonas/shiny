require(datasets)
data("mtcars")
require(ggplot2)
mtcars$am<-factor(mtcars$am,labels = c("Automatic","Manual"))
data<- mtcars[,c(1,4,6,7,9)]
fit1 <- lm(mpg ~ factor(am)*wt,data=data);s1<-summary(fit1)
fit2 <- lm(mpg ~ factor(am)*wt+hp,data=data);s2<-summary(fit2)
fit3 <- lm(mpg ~ factor(am)*wt+qsec,data=data);s3<-summary(fit3)

shinyServer(
    function(input, output) {
        
        output$newPlot <- renderPlot({
            newdata<-data.frame(hp=input$hp,wt=1:4,qsec=input$qsec,am="Manual")
            newdata<- rbind(newdata,data.frame(hp=input$hp,wt=1:5,qsec=input$qsec,am="Automatic"))
            choice <- input$choice

            in.auto <- data.frame(hp=input$hp,wt=input$wt,qsec=input$qsec,am="Manual")
            in.man <- data.frame(hp=input$hp,wt=input$wt,qsec=input$qsec,am="Automatic")
            title="MPG vs. Weight by Transmission Type"
            if(choice == "1") {fit=fit1 ; }
            if(choice == "2") {fit=fit2 ; title=paste(title,"\n for Horsepower=",in.auto$hp)}
            if (choice == "3") {fit=fit3 ; title=paste("MPG vs. Weight\n for Acceleration QSec=",in.auto$qsec)}
            
            pred<- predict.lm(fit,newdata,interval="prediction",level=0.9)
            pred.auto<- predict.lm(fit,in.auto,interval="prediction",level=0.9)
            pred.man<- predict.lm(fit,in.man,interval="prediction",level=0.9)
            
            text.auto<-ifelse(in.man$wt <= 4, 
                              paste("   Manual: avg=",round(pred.auto[1],2)," (",
                             round(pred.auto[2],2), "-", round(pred.auto[3],2),")"),
                             "   Manual: No estimate over 4K pounds")

            text.man<-paste("Automatic: avg=",round(pred.man[1],2)," (", 
                            round(pred.man[2],2), "-", round(pred.man[3],2),")")
            
            X<- cbind(pred,newdata)
            ggplot(data=X)+geom_line(aes(x=wt,y=fit,color=am),stat="identity",lwd=1)+
                geom_ribbon(aes(x=wt,ymin=lwr,ymax=upr,fill=am),alpha=0.2)+
                geom_vline(xintercept=as.numeric(in.auto[2]),lwd=1) +
                ggtitle(title) +
                xlab("Weight in K-Pounds") +
                ylab("Estimated MPG") +
                geom_text(aes(x=3.5,y=40),label=text.auto)+
                geom_text(aes(x=3.5,y=38),label=text.man) 
        })
    }
)
