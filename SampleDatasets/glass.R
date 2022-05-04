library(nnet)
glass<-read.csv("glass.data", header=FALSE)
names(glass)<-c("id", "RI", "Na", "Mg", "Al", "Si", "K", "Ca", "Ba", "Fe","Type")
glass$id<-NULL
glass$Type=factor(glass$Type)
set.seed(4365677)
glass_sampling_vector<-createDataPartition(glass$Type,p=0.8,list=FALSE)
glass_train=glass[glass_sampling_vector,]
glass_test=glass[-glass_sampling_vector,]
# next we will normalize our input data
glass_pp<-preProcess(glass_train[1:9],method="range")
glass_train<-cbind(predict(glass_pp,glass_train[1:9]),Type=glass_train$Type)
glass_test<-cbind(predict(glass_pp,glass_test[1:9]),Type=glass_test$Type)
## now the model is trained with the package nnet()##
#one of the advantages of this package to neuralnet() is, that te function nnet() ##
## will automatically detect outputs that are factors####

glass_model<-nnet(Type~.,data=glass_train,size=10)
##size=10 represents the number of hidden nodes in the single hidden layer##
glass_model<-nnet(Type~.,data=glass_train,size=10, maxit=1000)

##investigate the accuracy of the model##
train_predictions<-predict(glass_model,glass_train[,1:9],type="class")
mean(train_predictions==glass_train$Type)

##Increase the complexity of the model in order to obtain a better fit##
glass_model2<-nnet(Type~.,data=glass_train,size=60, maxit=10000)
train_predictions2<-predict(glass_model2,glass_train[,1:9],type="class")
mean(train_predictions2==glass_train$Type)

##now investigate the testset##
test_predictions2<-predict(glass_model2,glass_test[,1:9],type="class")
mean(test_predictions2==glass_test$Type)

##use weight decay##
glass_model3<-nnet(Type~.,data=glass_train,size=10, maxit=10000,decay=0.01)
train_predictions3<-predict(glass_model3,glass_train[,1:9],type="class")
mean(train_predictions3==glass_train$Type)

##now investigate the testset##
test_predictions3<-predict(glass_model3,glass_test[,1:9],type="class")
mean(test_predictions3==glass_test$Type)
