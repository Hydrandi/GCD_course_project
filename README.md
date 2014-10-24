READ ME for course project Getting and Cleaning Data
====================

### Packages and obtaining data

To run the script "run_Analysis.R" the dplyr package is required. 
The script first sets the working directory, then checks whether the zipped data set already exists in the working directory and if not downloads and unzips it. 

### Merging single objects into total data frame

Then the individual text files are loaded into R from the corresponding locations. It then merges the separate objects by first column binding for both train and test data sets the objects containing the measurements on each variable with the two objects specifying the subjects and the activities performed. The resulting objects are merged using row-bin to obtain a complete data set. 

### Tidying up data

In a next step, meaningful names are assigned to the single variables using the names() function and passing it the object feat containing a list of the names of the measurements.

### Filtering for mean and std variables

Then the data set is filtered for all measurements/variables containing the strings "mean" or "std" using the function grep (non case-sensitive) and assigned to a new object "vars".

### Assigning labels to activities

After column-binding "vars" with the columns giving the subject and activity IDs, descriptive activity labels are assigned to the activity IDs using the factor() function with 6 levels and the labels specified in the object "actlab". 

### Tidying variable names

The script then erases all punctuation from the variable names of the dataset, makes all cases lower and replaces some abbreviations with their full terms. For this the functions gsub() and tolower() were used. 

### Creating new data frame with average of each variable for each subject and activity

Finally the dplyr package is used to group the data set by subject and activity (group_by()) and to assign the average (summarise_each(mean)) of each measurement to the unique combinations of subject and activity. The resulting object "final" is eventually exported as a text file with the name "final.txt" using the write.table() function. 


