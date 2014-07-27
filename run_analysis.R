library(reshape2)
# Step 1: Prepare test data
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
X_test_sel <- X_test[,c(201:202,214:215,227:228,240:241,253:254,
                        503:504,516:517,529:530,542:543)]
testdata <- cbind(subject_test$V1,y_test$V1,X_test_sel)

# Step 2: Prepare train data
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
X_train_sel <- X_train[,c(201:202,214:215,227:228,240:241,253:254,
                          503:504,516:517,529:530,542:543)]
traindata <- cbind(subject_train$V1,y_train$V1,X_train_sel)

# Step 3: Merge test and train datasets
names(testdata)[1:2] <- c("subject","Activity_type")
names(traindata)[1:2] <- c("subject","Activity_type")
alldata <- rbind(testdata,traindata)

# Step 4: Replace the activity label with descriptive activity names
alldata1 <- alldata[which(alldata$Activity_type == 1),]
alldata1$Activity <- c("Walking")
alldata2 <- alldata[which(alldata$Activity_type == 2),]
alldata2$Activity <- c("Walking_upstairs")
alldata3 <- alldata[which(alldata$Activity_type == 3),]
alldata3$Activity <- c("Walking_downstairs")
alldata4 <- alldata[which(alldata$Activity_type == 4),]
alldata4$Activity <- c("Sitting")
alldata5 <- alldata[which(alldata$Activity_type == 5),]
alldata5$Activity <- c("Standing")
alldata6 <- alldata[which(alldata$Activity_type == 6),]
alldata6$Activity <- c("Laying")
alldatanew <- rbind(alldata1,alldata2,alldata3,alldata4,alldata5,alldata6)
alldatanew$Activity_type <- alldatanew$Activity
alldatanew <- alldatanew[,1:20]
# Here I replace the original "Activity_type" column with the 
# new "Activity" column, and then delete one redundant activty
# column to have only 20 columns in total

# Step 5: Label the column names of the dataset with descriptive variable names
names(alldatanew) <- c("Subject","Activity","tBodyAccMag-mean",
"tBodyAccMag-std","tGravityAccMag-mean","tGravityAccMag-std",
"tBodyAccJerkMag-mean","tBodyAccJerkMag-std","tBodyGyroMag-mean",
"tBodyGyroMag-std","tBodyGyroJerkMag-mean","tBodyGyroJerkMag-std",
"fBodyAccMag-mean","fBodyAccMag-std","fBodyAccJerkMag-mean",
"fBodyAccJerkMag-std","fBodyGyroMag-mean","fBodyGyroMag-std",
"fBodyGyroJerkMag-mean","fBodyGyroJerkMag-std")

# Step 6: Create a tidy dataset to show the average of each variable for each activity of each subject
dataMelt <- melt(alldatanew,id=c("Subject","Activity"),measure.vars=names(alldatanew)[3:20])
tidyData <- dcast(dataMelt, Subject + Activity ~variable,mean)
write.table(tidyData,file="tidyData.txt")