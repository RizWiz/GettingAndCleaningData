# Set the path
setwd("E:/program for R")

# Step 0 : Downloading and unzipping dataset
if(!file.exists("./data")){dir.create("./data")} #create the place to restore the data

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/projectData_getCleanData.zip")

listZip <- unzip("./data/projectData_getCleanData.zip", exdir = "./data") #unzip the data

#--------------------------------------------------------------------------------------------------#

#Step 1 : Merging the training and the test sets to create one data set.

##Step 1.1 : load training data

train_x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

##Step 1.2 : load test data

test_x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")


## step 1.3 : merge train and test data
trainData <- cbind(train_subject, train_y, train_x)
testData <- cbind(test_subject, test_y, test_x)
fullData <- rbind(trainData, testData)

#--------------------------------------------------------------------------------------------------#

# Step 2 : Extract only the measurements on the mean and standard deviation for each measurement. 

##Step 2.1 : load feature name
feature_Name <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]

##Step 2.2 : mean and sd(standar deviation) for each measurement
feature_Index <- grep(("mean\\(\\)|std\\(\\)"), feature_Name)
T_Data <- fullData[, c(1, 2, feature_Index + 2)]
colnames(T_Data) <- c("Subject_ID", "Activity", feature_Name[feature_Index])

#--------------------------------------------------------------------------------------------------#

# Step 3 : Uses descriptive activity names to name the activities in the data set

##Step 3.1 : load activity data 
activityName <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

##Step 3.2 : replace by activity names
T_Data$Activity <- factor(T_Data$Activity, levels = activityName[,1], labels = activityName[,2])

#--------------------------------------------------------------------------------------------------#

# Step 4 :Appropriately labels the data set with descriptive variable names.

names(T_Data) <- gsub("\\()", "", names(T_Data))
names(T_Data) <- gsub("^t", "time", names(T_Data))
names(T_Data) <- gsub("^f", "frequence", names(T_Data))
names(T_Data) <- gsub("-mean", "Mean", names(T_Data))
names(T_Data) <- gsub("-std", "Std", names(T_Data))

#--------------------------------------------------------------------------------------------------#

# Step 5 :From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
SecT_Data <- T_Data %>%
        group_by(Subject_ID, Activity) %>%
        summarise_each(funs(mean))

write.table(SecT_Data, "./SecT_Data.txt", row.names = FALSE)

#----------------------------------The end of the code---------------------------------------------#

