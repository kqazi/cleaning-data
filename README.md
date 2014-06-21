o execute the "run_analysis" R function you must have the data from this URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The only library that needs loading is "reshape2" prior to executing the script.

Assuming you have the data downloaded and you are running "run_analysis" in your working directory where the "UCI HAR Dataset/" is placed in your current working dir then you should be good to go.  There are good comments so read the inline code comments if you want deeper insights.

The "run_analysis" function will produce a file called "./combined-activity-subject-variable-means.txt" relative to your working directory.
