# The Data
The data we are working with comes from the following publication:

* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity     Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

It is inertial data collected from 30 subjects performing 6 activities while wearing a smartphone.
The data is provided as raw text files in a zip, so we need to do some **tidying up**.

The following process is scripted in 'run_analysis.R' this CodeBook explains the data processing steps taken and describes the final analyzed data.

## Step one: Get the data
We download and extract the data

## Step two: Merge test and train datasets
The HAR dataset has been randomly broken up into two sets, *test* and *train*.
We are interested in the whole dataset, so we will combine the data with simple row binds.
First we load all the data from each set, then we create a new dataframe out of the mergerd data.

## Step three: Label our data
We have names for each of the 561 features in the HAR data, so let's
label our columns. We'll create a vector of feature names
and loop through each column of the "x" table applying the name to the column.

In the raw data each activity is coded 1 through 6. We have labels for each
of those activity codes, so lets loop through our "y" tabel and replace the
coded value with the human-readable label.

## Step four: bring it all together
We now have our combo data for each subject, each activity, and each feature recorded.
Let's put them on one table, "ourdata"

## Step five: pruning
We don't need every bit of information in each of those 561 features, 
let's prune off everything except the mean and standard deviation measurements.
We'll do this by greping column names.

## Step six: Do some reshaping and summarizing
We have multiple observations of each subject doing each activity. Let's drill
in to that data and get at some insights! We will group our data into one
row for each activity each subject performed. The values for each feature in
this row are the means of all observations of that subject performing that activity.

## Step seven: Record our results!
The table we created in the previous step is output as "Analyzed_Data.txt"
It contains 180 rows and 81 columns. The first column is the Subject ID, indicating
which of the thirty subjects the data describes. The second column is the activity
performed by the subject. All remaining columns are means of all observations of the given subject peforming the given activity for each feature as named in the original HAR dataset
