### Reading train data

train <- read.table(file.choose(new))
head(train)[,1:5]
names(train)

test <- read.table(file.choose(new))
head(test)[,1:5]

### Features Description

feature <- read.table(file.choose(new), header = FALSE )  ## Choose any feature text file.
dim(feature)
feature <- as.data.frame(feature)
variable <- feature[,1]
variable
length(variable)

names(train) <- variable ## variable names are added
names(train)[1:12]

names(test) <- variable ## variable names are added

### activity labels

y <- read.table(file.choose(new), header = FALSE) ### choose the y_train.txt 
activity <- y[,1]

activity.level <- NULL
activity.level[activity==1] <- "walk"
activity.level[activity==2] <- "walkup"
activity.level[activity==3] <- "walkdown"
activity.level[activity==4] <- "sitting"
activity.level[activity==5] <- "standing"
activity.level[activity==6] <- "laying"

train$activity <- activity.level

y.test <- read.table(file.choose(new), header = FALSE) ### choose the y_test.txt 
activity <- NULL
activity <- y.test[,1]

activity.level <- NULL
activity.level[activity==1] <- "walk"
activity.level[activity==2] <- "walkup"
activity.level[activity==3] <- "walkdown"
activity.level[activity==4] <- "sitting"
activity.level[activity==5] <- "standing"
activity.level[activity==6] <- "laying"

table(activity.level)
test$activity <- activity.level


### Subject Identifier

subject <- read.table(file.choose(new), header=FALSE) ### choose the subject_train.txt
dim(subject)
head(subject)
subject[3500:4500,]
table(subject)
subject <- subject[,1]
train$subject <- subject

train[1:10,555:563]


subject <- NULL
subject <- read.table(file.choose(new), header=FALSE) ### choose the subject_test.txt
dim(subject)
head(subject)
subject[500:1000,]
table(subject)
subject <- subject[,1]
test$subject <- subject

test[,555:563]
dim(train)
dim(test)
### merging two datasets
merged.data <- NULL

unique(test$subject)
unique(train$subject)

merged.data <- rbind(train, test)
dim(merged.data)

### mean and sd for each variable

measure.mean <- NULL
measure.sd <- NULL

for(i in 1:563) {
  measure.mean[i] <- mean(merged.data[,i], na.rm=TRUE)
  measure.sd[i] <- sd(merged.data[,i], na.rm = TRUE)
}

measure.mean[3]
measure.sd[3]
length(measure.mean)
library(dplyr)

### Making tidy data

merged.data <- merged.data[ order(merged.data$subject),]

tidy.data <- aggregate(merged.data[,1:561], 
                         by = merged.data[c("subject","activity")], FUN=mean)

