train<-read.csv("train.csv")
test<-read.csv("test.csv")
str(test)
str(train)

summary(train)

train$Hazard<-as.factor(train$Hazard)
install.packages("dplyr")
library(dplyr)

inp=select(train,-(Id))



library(rpart)



library(rpart.plot)



CARTmodel = rpart(Hazard~., data=inp)

prp(CARTmodel)

PredictCART = predict(CARTmodel, newdata = inp)

table(inp$Hazard, PredictCART)



library(randomForest)
library(reldist)
StevensForest = randomForest(Hazard~., data = inp, ntree=200, nodesize=25 )



# Make predictions

PredictForest = predict(StevensForest, newdata = inp)

table(inp$Hazard, PredictForest)
PredictForest = predict(StevensForest, newdata = test)
write.table(data.frame(test$Id,PredictForest),file="submission.csv",sep=",",row.names=FALSE)
Enter file contents here
