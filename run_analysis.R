# Step 1: Preapare the training data
# 1-1. Read the subject and activity columns
sbjtr <- read.table("./train/subject_train.txt",header=FALSE)
actvtr <- read.table("./train/y_train.txt",header=FALSE)

# 1-2. Read the training data, and extract only the mean and std measurements 
datatr <- read.table("./train/X_train.txt",header=FALSE)
features <- read.table("features.txt",header=FALSE)
selfeatures <- grep("mean\\(\\)|std\\(\\)",features[,2],value=TRUE)
indices <- grep("mean\\(\\)|std\\(\\)",features[,2])
seldatatr <- datatr[,indices]

# 1-3. Combine subject and activity columns with extracted measurements
alldatatr <- cbind(sbjtr,actvtr,seldatatr)

# Step 2: Prepare the testing data following the procedure performed for the training data
sbjts <- read.table("./test/subject_test.txt",header=FALSE)
actvts <- read.table("./test/y_test.txt",header=FALSE)
datats <- read.table("./test/X_test.txt",header=FALSE)
seldatats <- datats[,indices]
alldatats <- cbind(sbjts,actvts,seldatats)

# Step 3: Combine the training and testing datasets
alldata <- rbind(alldatatr,alldatats)

# Step 4: Label the data set with descriptive variable names
names(alldata) <- c("subject","activityId",selfeatures)

# Step 5: Uses descriptive activity names to name the activities in the data set
actvlabel <- read.table("activity_labels.txt",header=FALSE)
names(actvlabel) <- c("activityId","activityType")
alldata2 <- merge(alldata,actvlabel,by="activityId",all.x=TRUE)

# Step 6: Calculate the average of each variable for each activity and each subject.
library(reshape2)
dataMelt <- melt(alldata2,id=c("subject","activityType"),measure.vars=selfeatures)
tidyData <- dcast(dataMelt, subject + activityType ~variable,mean)

# Step 7: Write a txt file with the above tidy data set
write.table(tidyData,file="tidyData.txt",row.names=FALSE)