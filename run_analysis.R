### 1. Merges the training and the test sets to create one data set                                                                        
## Set working directory
setwd("C:/Users/aallender/Desktop/Coursera/UCI HAR Dataset/")

## Read features and activity data
	features     <- read.table('./features.txt',header=FALSE) 			#features.txt
	activity	 <- read.table('./activity_labels.txt',header=FALSE) 		#activity_labels.txt


## Read train data
	subjectTrain <- read.table('./train/subject_train.txt',header=FALSE)	#subject_train.txt
	xTrain       <- read.table('./train/x_train.txt',header=FALSE) 		#x_train.txt
	yTrain       <- read.table('./train/y_train.txt',header=FALSE)		#y_train.txt

	## Assign column names to train data
	colnames(activity)  <- c('activityId','activity')
	colnames(subjectTrain)  <- "subjectId"
	colnames(xTrain)        <- features[,2] 
	colnames(yTrain)        <- "activityId"

	## Create train data set - yTrain, subjectTrain, & xTrain
	trainData <- cbind(yTrain, subjectTrain, xTrain)


## Read test data
	subjectTest <- read.table('./test/subject_test.txt',header=FALSE)		#subject_test.txt
	xTest       <- read.table('./test/x_test.txt',header=FALSE)			#x_test.txt
	yTest       <- read.table('./test/y_test.txt',header=FALSE)			#y_test.txt


	## Assign column names to test data
	colnames(subjectTest) <- "subjectId"
	colnames(xTest)       <- features[,2]
	colnames(yTest)       <- "activityId"

	# Create test data set - yTest, subjectTest, & xTest and data
	testData <- cbind(yTest, subjectTest, xTest)


# Combine train & test data                
	tblData <- rbind(trainData,testData)
                                     

# Create vector for tblData column names - used to select mean() & stddev() columns
	colNames  <- colnames(tblData) 



### 2. Extracts only the measurements on the mean and standard deviation for each measurement
# Create logical vector - contains TRUE values for ID, mean(), & stddev() columns; FALSE for remaining columns
	logV <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Subset tblData based on the logV to keep only desired columns
	tblData <- tblData[logV == TRUE]



### 3. Uses descriptive activity names to name the activities in the data set
# Merge tblData w/ activity tbl to include descriptive activity names
	tblData <- merge(tblData , activity, by = 'activityId', all.x = TRUE)

# Update colNames vector to include the new column names
	colNames  <- colnames(tblData)



### 4. Appropriately labels the data set with descriptive variable names. 
# Clean up variable names
	for (i in 1:length(colNames)) 
	{
  	colNames[i] <- gsub("\\()","",colNames[i])
  	colNames[i] <- gsub("-std$","_StdDev",colNames[i])
  	colNames[i] <- gsub("-mean","_Mean",colNames[i])
  	colNames[i] <- gsub("^t","time",colNames[i])
  	colNames[i] <- gsub("^f","freq",colNames[i])
  	colNames[i] <- gsub("BodyBody","Body",colNames[i])
  	colNames[i] <- gsub("Mag","Magnitude",colNames[i])
	}

# Reassign new column names in finalData
	colnames(tblData) <- colNames



### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Create tblData_xactivity tbl - w/o activity column
	tblData_xactivity <- tblData[,names(tblData) != 'activity']

# Create tidyData tbl - includes variable means for each activity & subject
	tidyData <- aggregate(tblData_xactivity[,names(tblData_xactivity) != c('activityId','subjectId')],by=list(activityId=tblData_xactivity$activityId,subjectId = tblData_xactivity$subjectId),mean)


# Merge tidyData w/ activity to include descriptive activity names
	tidyData <- merge(tidyData,activity,by='activityId',all.x=TRUE)

# Export tidyData set to active directory
	write.table(tidyData, './tidyData.txt',row.names=FALSE,sep='\t')



