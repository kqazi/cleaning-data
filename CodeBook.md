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

You should read the "ReadMe" file contained in this data set to fully understand what it is comprised of.

The funciton "run_analysis()" produces a "tidy" data set that has the following charateristics:

* Produces a file called: "combined-activity-subject-variable-means.txt", relative to the working dir.
* This file is made up of a total of 36 rows and 68 columns. The "Subject" and "Activity" columns denote the differnt types of data that exist in this data set.  These are the first 2 columns in the data set.  The remaining 66 columns represent the actual measurements that were taken during the study.  Each of those 66 columns is the actual "mean" of that given measurement for the "Subject" (person who participated in study) or "Activty" (what the person was doing during that measurement: "LAYING", "SITTING", etc)
* Each of the 66 columns that are not "Subject" or "Activity" are data that was collected from the orignal study from the link at the beginning of the study. 
* The presence of "NA" in the "Activity" or "Subject" (but not both for a given row)  column denotes the type of record: Activity or Subject
