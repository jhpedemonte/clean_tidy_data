## UCI Human Activity Recognition data

The provided script `run_analysis.R` merges, manipulates and tidies up the data from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), which contains measurements from activity trackers as users went through a series of different activities. The full dataset is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).


## Running the script

The script assumes that the directory contain the data is in the current working directory. You can do the following to get the data and run the script:

```
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile="URI_HAR_Dataset.zip")
unzip("URI_HAR_Dataset.zip")
source("run_analysis.R")
```

## Script details

The script itself is pretty well documented, so check that first. Overall, the script merges several different data files from the UCI dataset to create a master merged dataset, with properly named variables.

Also, the script replaces the numeric activity values (1-6) with their more descriptive labels (i.e. "WALKING").

Finally, it creates a tidied dataset showing the average of all of the "mean" and "standard deviation" measurements, grouped by subject (user) and activity type.