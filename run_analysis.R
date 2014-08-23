## Getting and Cleaning Data project
## Merge training and testing set into one data and clean to create tidy data set
## Assumes UCI HAR Dataset folder is in working directory

## Read features and take values from column two
features <- read.table("./UCI HAR Dataset/features.txt", sep="")
features <- features[,2]

## Read test files and assign column names
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
testY <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
colnames(testSet) <- features
colnames(testY) <- c("Activity")
colnames(testSubject) <- c("Subject")

## Extract columns with mean and standard deviation
testSet <- testSet[,grepl("mean|std", features)]

## Bind test data
test <- cbind(testSubject, testY, testSet)

## Read train files and assign column names
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
colnames(trainSet) <- features
colnames(trainY) <- c("Activity")
colnames(trainSubject) <- c("Subject")

## Extract columns with mean and standard deviation
trainSet <- trainSet[,grepl("mean|std", features)]

## Bind train data
train <- cbind(trainSubject, trainY, trainSet)

## Bind test and train data
allData <- rbind(test, train)

## Create descriptive activity names
allData$Activity[allData$Activity == 1] <- "WALKING"
allData$Activity[allData$Activity == 2] <- "WALKING UPSTAIRS"
allData$Activity[allData$Activity == 3] <- "WALKING DOWNSTAIRS"
allData$Activity[allData$Activity == 4] <- "SITTING"
allData$Activity[allData$Activity == 5] <- "STANDING"
allData$Activity[allData$Activity == 6] <- "LAYING"


## Write tidy dataset
write.table(allData, "./tidy.txt", row.name=FALSE)