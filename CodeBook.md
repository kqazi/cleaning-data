---
title: "CodeBook.md"
author: "Karim Qazi"
date: "June 20, 2014"
output: html_document
---

<h2>Summary:</h2>

The "run_analysis()" function uses the data sets collected by the study conducted at this URL here: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

It utilizes the data provided by this study from this URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should read the "ReadMe" file contained in this data set to fully understand what the actual code does.  In general the data provided by this study for the "test" and "train" data sets was of equal dimensionality for the respecitve data sets, so it was just a matter of combining the "test" and "train" data sets via "rbind()" to have a single data set that could be used to further manipulate the data as the assignment specified.

The funciton "run_analysis()" produces a "tidy" data set that has the following charateristics:

* Produces a file called: "combined-activity-subject-variable-means.txt", relative to the working dir. The file is " " delimited.
* This file is made up of a total of 36 rows and 68 columns. The "Subject" and "Activity" columns denote the differnt types of data that exist in this data set.  These are the first 2 columns in the data set.  The remaining 66 columns represent the actual measurements that were taken during the study.  Each of those 66 columns is the actual "mean" of that given measurement for the "Subject" (person who participated in study) or "Activty" (what the person was doing during that measurement: "LAYING", "SITTING", etc).   
* There are 36 rows because there were "30 subjects" and "6 activities" and there were 66 variables that corresponded to either "mean" or "std" measurments so 66 measurments + 2 indicator columns (Activity or Subject) = 68 columns.
* Each of the 66 columns that are not "Subject" or "Activity" are data that was collected from the orignal study from the link at the beginning of the study, I just calculated the "mean()" of that particular variable and grouped it by either "Subject" or "Activity".  Also please read the file "features_info.txt" to understand what each of the variable's are.  This file is included in the zip file from the study.
* The presence of "NA" in the "Activity" or "Subject" (but not both for a given row)  column denotes the type of record: "Activity" or "Subject".  A record can only be one or the other.


<b>NOTE</b>:  After looking at others submissions for their data set I can see that I probably did too much by grouping the data by Activity or Subject.  The text in the instructions which read: "Creates a second, independent tidy data set with the average of each variable for each activity and each subject. " is what confused me, which is why I did the mean by either "Activity" or "Subject".  IMO these instructions were very unclear and I can easily see how I could have done it with much less work if the instructions were just a little more clear.  For example I could have just done this single call and skip all the melt(), dcast(), etc:

``` r
  # to get required data set.
  activitiesAndSubjectByMean <- aggregate(combinedMeanAndStdData[,3:68], 
                                                by = list(activity=combinedMeanAndStdData$Activity,
                                                          subject = combinedMeanAndStdData$Subject),
                                                mean)
```
