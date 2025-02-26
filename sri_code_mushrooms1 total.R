getwd()
setwd("C:/Users/SRIKA/Documents")
mushrooms <- read.csv("secondary_data.csv", sep = ";")
names(mushrooms)
a<-as.factor(mushrooms$class)
b<-as.numeric(a)

#linear regression
m<-lm(b~.,data=mushrooms)
summary(m)
#logistic regression
M_logis<- glm(a~., family = binomial, data = mushrooms)
 #M_logis13 <- glm(a~veil.type+season+does.bruise.or.bleed+veil.color+spore.print.color+has.ring+habitat+stem.root+cap.color+cap.diameter+gill.attachment+stem.surface+gill.color+stem.height-stem.color-cap.surface+cap.shape+gill.spacing+stem.width, family = binomial, data = mushrooms)

summary(M_logis)
plot(M_logis)
par(mfrow=c(1,4))
#reduced modal
 M_logis1 <- glm(a~.-veil.type-season-does.bruise.or.bleed-veil.color-spore.print.color-has.ring, family = binomial, data = mushrooms)
summary(M_logis1)
AIC(M_logis,M_logis1)
plot(M_logis1)
par(mfrow=c(1,4))
#Feature selection
library(randomForest)
install.packages("randomForest")
rf_model <- randomForest(a ~ ., data = mushrooms, importance = TRUE)
varImpPlot(rf_model)
#model 
P_logis <- predict(M_logis, newdata = mushrooms, type = "response")
C_logis <- rep(0, length(a))
C_logis[P_logis>0.5] <- 1
table(C_logis, a)
#reduced model
P_logis1 <- predict(M_logis1, newdata = mushrooms, type = "response")
C_logis1 <- rep(0, length(a))
C_logis[P_logis1>0.5] <- 1
table(C_logis1, a)
accuracy=sum(C_logis==a)/length(a)
accuracy1=sum(C_logis1==a)/length(a)



#NB
library(e1071)
M_NB <- naiveBayes(a~., data = mushrooms)
P_NB <- predict(M_NB, newdata = mushrooms, type = "raw")
C_NB <- predict(M_NB, newdata = mushrooms, type = "class")
table(C_NB, a)
accuracy_nb=sum(C_NB==a)/length(a)
#reduced model
M_NB1 <- naiveBayes(a~.-veil.type-season-does.bruise.or.bleed-veil.color-spore.print.color-has.ring, data = mushrooms)
P_NB1 <- predict(M_NB1, newdata = mushrooms, type = "raw")
C_NB1 <- predict(M_NB1, newdata = mushrooms, type = "class")
table(C_NB1, a)
accuracy_nbr=sum(C_NB1==a)/length(a)



#LDA
library(MASS)
M_LDA <- lda(class ~., data = mushrooms)
P_LDA <- predict(M_LDA)$posterior
C_LDA <- predict(M_LDA)$class
table(C_LDA, a)
accuracy_lda=sum(C_LDA==a)/length(a)
#reduced model
M_LDA1 <- lda(class~.-veil.type-season-does.bruise.or.bleed-veil.color-spore.print.color-has.ring, data = mushrooms)
P_LDA1 <- predict(M_LDA1)$posterior
C_LDA1 <- predict(M_LDA1)$class
table(C_LDA1, a)
accuracy_lda1=sum(C_LDA1==a)/length(a)

data(mushrooms)

#QDA
library(MASS)

M_QDA <- qda(a~., data = mushrooms)
P_QDA <- predict(M_QDA)$posterior
C_QDA <- predict(M_QDA)$class
table(C_QDA, a)
accuracy_qda=sum(C_QDA==a)/length(a) 
accuracy_qda
#reduced model
M_QDA1 <- qda(a~.-veil.type-season-does.bruise.or.bleed-veil.color-spore.print.color-has.ring, data = mushrooms)
P_QDA1 <- predict(M_QDA1)$posterior
C_QDA1 <- predict(M_QDA1)$class
table(C_QDA1, a)
accuracy_qda1=sum(C_QDA1==a)/length(a)
accuracy_qda1
#KNN

set.seed(123)
mush <- c("veil.type","season+does.bruise.or.bleed","veil.color","spore.print.color","has.ring","habitat","stem.root","cap.color","cap.diameter","gill.attachment","stem.surface","cap.surface","cap.shape","gill.spacing","stem.width")
h<- -mushrooms[mush]

train<- sample(1:nrow(h), size = 0.8*nrow(h), replace = FALSE)
train <- h[train, ]
test <- h[-train, ]
install.packages("caret")
library(caret)
library(class)
m.knn <- knn(train[, -1], test[, -1], mushrooms$class, k = 5)
summary(m.knn)
table(m.knn, test$class)
plot(m.knn)
mean(m.knn==test$class)



#ROC curve
library(ROCR)
install.packages("ROCR")
prd_logis <- prediction(P_logis, a)
perf_logis <- performance(prd_logis,"tpr","fpr")
plot(perf_logis, col = "red",
     asp = 1, lwd = 2,
     main = paste0("ROC curves for logistic regression"))
abline(h = 0:5*.2, v = 0:5*.2, lty = 2)

prd_NB <- prediction(P_NB[,2], a)
perf_NB <- performance(prd_NB,"tpr","fpr")
plot(perf_NB, col = "black",
     asp = 1, lwd = 2,
     main = paste0("ROC curves for naive bayes"))
abline(h = 0:5*.2, v = 0:5*.2, lty = 2)

prd_LDA <- prediction(P_LDA[,2], a)
perf_LDA <- performance(prd_LDA,"tpr","fpr")
plot(perf_LDA, col = "blue", asp =1, lwd = 2,main = paste0("ROC curves for LDA"))
abline(h = 0:5*.2, v = 0:5*.2, lty = 2)

prd_QDA <- prediction(P_QDA[,2], a)
perf_QDA <- performance(prd_QDA,"tpr","fpr")
par(new=TRUE)
plot(perf_QDA, col = "green", lwd = 2, asp =1)

#AUC
AUC_logis <- performance(prd_logis,"auc")@y.values[[1]]
AUC_NB <- performance(prd_NB,"auc")@y.values[[1]]
AUC_LDA <- performance(prd_LDA,"auc")@y.values[[1]]
#AUC_QDA <- performance(prd_QDA,"auc")@y.values[[1]]
legend(0.05, 0.1, legend = c("AUC scores:", paste0("by logis: ", round(AUC_logis, digits=3)), paste0("by NB: ", round(AUC_NB, digits=3)),paste0("by LDA: ", round(AUC_LDA, digits=3))), col = c(NA,"red", "black", "blue", "green"), lwd = 2, cex = 0.8)
