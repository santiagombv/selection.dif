library(shiny)

shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    H <- input$SOB/100
    N <- 200
    Z <- rnorm(N)
    Zp <- Z[Z > quantile(Z, probs = 1-H)]
    Zn <- Z[Z < quantile(Z, probs = H)]
    Ze <- Z[Z > quantile(Z, probs = (1-H)/2) & Z < quantile(Z, probs = H + (1-H)/2)]
    Zd <- Z[Z < quantile(Z, probs = (H)/2) | Z > quantile(Z, probs = 1-(H/2))]
    dat1 <- data.frame(Z,
                       Zp = c(Zp, rep(NA, N-length(Zp))),
                       Zn = c(Zn, rep(NA, N-length(Zn))),
                       Ze = c(Ze, rep(NA, N-length(Ze))),
                       Zd = c(Zd, rep(NA, N-length(Zd))))
    dat2 <- data.frame(ind = c(dat1$Z, dat1[, input$tipo]),
                       pres = c(rep("antes", N), rep("despues", N)),
                       Y = rep(0, N*2))  
    o <- order(dat2$ind)
    m <- qplot(ind, ..count.., data= dat2, geom="density", fill=pres, adjust = 4) 
    m <- m + geom_vline(xintercept = 0) 
    m <- m + geom_vline(xintercept = mean(subset(dat2$ind, dat2$pres == "despues"), na.rm=T))
    m <- m + xlim(-5, 5) + theme_bw() 
    m <- m + theme(legend.position="top", axis.text.y=element_blank(), 
                   axis.title.y = element_blank(), axis.title.x = element_blank(),
                   legend.title = element_blank()) 
    
    n <- qplot(x=ind, y = Y, data=dat2[o,], geom="point", color =pres, position="jitter")
    n  <- n + geom_segment(aes(x = 0, y = 0, 
                               xend = mean(subset(dat2$ind, dat2$pres == "despues"), na.rm=T),
                               yend = 0, size=4), color ="black") 
    n <- n + xlim(-5, 5) + theme_bw()
    n <- n + theme(legend.position="none", axis.title.y=element_blank(), 
                   axis.text.y=element_blank()) 
    
    k <- qplot(x=ind, y = Y, data=dat2[o,], geom="point", color =pres, position="jitter")
    k  <- k + geom_segment(aes(x = -1, y = 0.2, xend = 1, yend = 0.2, size = 4), 
                           color ="red") 
    k  <- k + geom_segment(aes(y= -0.2, yend= -0.2,
                               x = - sd(subset(dat2$ind, dat2$pres == "despues"), na.rm=T),
                               xend = sd(subset(dat2$ind, dat2$pres == "despues"), na.rm=T),
                               size = 4), color ="blue") 
    k <- k + xlim(-5, 5) + theme_bw()
    k <- k + theme(legend.position="none", axis.title.y=element_blank(), 
                   axis.text.y=element_blank()) 
    
    grid.arrange(m, n, k, heights=c(3/5, 1/5, 1/5), ncol=1)
  })
})
