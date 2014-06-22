This code book explains what the "run_analysis()" function does.  This function depends on the "reshape2" library to perform the "dcast()" function, which allows for grouping of the data.

NOTE: The "Inertial Signals" directory is ignored for this assignment and no data is used from these dir's at all.

The general steps this function takes are the following:

1. Reads in "test" data and performs a "cbind()"" on each individual data set under "/test".  
2. Reads in "training" data and performs a "cbind()"" on each individual data set under "/training". 
3. Performs an rbind(testDataMerged, trainingDataMerged) to have a single data frame (allDataMerged) of both test and training data. 
4. Renames the "Activity" and "Subject" columns of the "allDataMerged" data frame. 
5. Reads in the "features.txt" and performs a transfom on the data so all the column names can have the correct naming.  Without performing the transform the data doesn't have the correct dimensions to easily rename the columns.
6. Read in the activities from "activity_labels.txt" and create an activitiesList that we can use to replace all the "id" based activities.  It just allows a clean replace to happen.
7. Obtain the column names from the "allDataMerged" data frame and use "grep()" to determine only the "mean" & "std" data columns.  grep() retuns the column indexes which allow for easy subsetting to create 2 individual data frames: one for mean and another for std values. 
8. Perform a "cbind(allDataMerged[,1:2], onlyMeanData, onlyStdData)".  This creates a new combined data frame containg the "Activity", "Subject", mean data vars and std data vars.
9. Next we have to "melt()" the data to be tall and skinny.  Here all the variable's that were rows become columns. We create 2 new "melted" data frames following this approach, one for Activity and another for Subject.
10. Now we have to re-shape the data again using "dcast()" so that we can group the data by Activity and Subject.  There is a different data frame for both Activity and Subject.
11. Once we have the grouped Activity and Subject data frames we can run "merge()" to create a single data frame.  Note that we don't have a join column here as we don't want to loose the dimensions we already have from the grouping.
12. Lastly we write the data in TXT format to the file "./combined-activity-subject-variable-means.txt" and place the Activity and Subject columns at the beginning of the data frame via "combinedActivityAndSubjectVariableMeans[,c(68:67,1:66)]" so it's easier to see if you are working with a row that represents an Activity or a Subject. 

If you want a deeper understanding the code has very good inline comments as well.

To execute the "run_analysis" R function you must have the data from this URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The only library that needs loading is "reshape2" prior to executing the script.

Assuming you have the data downloaded and you are running "run_analysis" in your working directory where the "UCI HAR Dataset/" is placed in your current working dir then you should be good to go.  There are good comments so read the inline code comments if you want deeper insights.

The "run_analysis" function will produce a file called "./combined-activity-subject-variable-means.txt" relative to your working directory.
