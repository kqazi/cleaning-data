run_analysis <- function(){
        
        # test data and labels
        testData <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
        testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
        subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
        
        # create one data frame for all test data
        testDataMerged <- cbind(testLabels, subjectTest, testData)
        
        # training data and labels
        trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
        trainingLabels <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
        subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
        
        # create one data frame for all training data
        trainingDataMerged <- cbind(trainingLabels, subjectTrain, trainingData)
        
        # merge all data together
        allDataMerged <- rbind(testDataMerged, trainingDataMerged)
                
        # read in features and transpose for column renaming
        features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
        features <- t(features)
                
        # rename the columns based on the feature
        colnames(allDataMerged)[1] <- "Activity"
        colnames(allDataMerged)[2] <- "Subject"
        colnames(allDataMerged)[3:563] <- features[2,] # only want feature names

        
        # read in activities and add description to Activity column
        activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
        activities <- allDataMerged[,1]
        activityList <- c()
        for(i in seq_along(activities)) {
                activityList[i] <- as.character(activityLabels[(activityLabels$V1 == activities[i]),2])
        }
        # Replace all activity id's with actual values
        allDataMerged[,1] <- activityList
        
        # Get col names and get only mean and std cols
        columnNames <- names(allDataMerged)  
        meanCols <- grep("-mean()", columnNames, fixed = TRUE)
        stdCols <- grep("-std()", columnNames, fixed = TRUE)
        onlyMeanData <- allDataMerged[,meanCols]
        onlyStdData <- allDataMerged[,stdCols]
        
        # create combined data set of only activity, subject, mean and std data
        combinedMeanAndStdData <- cbind(allDataMerged[,1:2], onlyMeanData, onlyStdData)

        # re-shape data to be tall and skinny with a row for each variable and only 3 cols (activity, variable, value) 
        activityMelt <- melt(combinedMeanAndStdData, id=c("Activity"), measure.vars=c(colnames(combinedMeanAndStdData)[3:68]))
        subjectMelt <- melt(combinedMeanAndStdData, id=c("Subject"), measure.vars=c(colnames(combinedMeanAndStdData)[3:68]))
        
        
        # group data by activity and subject with the mean for each variable
        variableMeanByActivity <- dcast(activityMelt, Activity ~ variable, mean)
        variableMeanBySubject <- dcast(subjectMelt, Subject ~ variable, mean)
        
        # merge data into one data frame
        combinedActivityAndSubjectVariableMeans <- merge(variableMeanByActivity, variableMeanBySubject, all=TRUE)
        
        # write data to CSV and place Activity and Subject columns at the front of the data frame
        write.table(combinedActivityAndSubjectVariableMeans[,c(68:67,1:66)], "./combined-activity-subject-variable-means.txt", sep=" " )
        
}
