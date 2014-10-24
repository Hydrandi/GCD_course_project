Code Book for course project in "Getting and Cleaning Data"
====================

Contributors: Hydrandi
Date: October 24, 2014

### The task

The task of this short project was to grab data from the web on human activity patterns obtained using accelerometers and gyroscopes built into smartphones, tidy up the raw data by changing and selecting specific variable names and to create a new, final tidy data set containing a summary of the initial data. 

### The raw data

The raw data was downloaded from the [web](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), unzipped and loaded into R. The raw data is compromised of measurements obtained from the accelerometers and gyroscopes built into Samsung Galaxy S smartphones that were worn by 30 volunteers while performing the following six activities that were in the centre of attention of this study:

* Walking
* Walking upstairs
* Walking downstairs
* Sitting
* Standing
* Laying

The instruments captured the 3-axial linear acceleration and the 3-axial angular velocity at a constant rate of 50 Hz. Records were split into test (30%) and train (70%) datasets. The data contained in the raw input data set has already been pre-processed through the application of noise filters. 

The downloaded data package consists of separate text files. For both "train" and "test" datasets, it is provided a text file containing data on

a) the measured variables (X train, X test),  
b) the integer ids of the monitored subjects/volunteers
c) the names of the measured variables
d) which of the six activities (1-6) was untertaken during specific record
e) how activity IDs refer to the activities 

Each measurement was split into three variables (x,y,z) representing the 3 dimensional space. 


### Data processing

After downloading, unzipping and loading the single text files into R, I firstly merged for both train and test datasets the recorded values for the variables with the record id and the subject id (labeled with the prefix x,y and sub respectively). The obtained train and test datasets (dimensions: 7352 observations of 563 variables and 2947 observations of 563 variables respectively) were subsequently row bound to obtain a complete dataset "tot" specifying for each of its 10299 observations which volunteer/subject performed which activity and the 561 single measurements spanning the 3D space. 

After reassigning new variable names to the columns of the dataset (using the text file containing the names of the measured variables) the dataset was filtered for variable names containing the string "mean" (average) and/or "std" (standard deviation).  

Subsequently the activity identifiers were replaced by labelling them with the activity names specified in text tile e. To give meaningful names to the separate mean and std measurements and thus enhance human readability of the data variable the following name adaptations were carried out:

* all characters to lower case; *tolower()*
* remove all punctuation; *gsub()*
* substitute acc with acceleration, gyro with gyroscope, bodybody with body, and mag with magnitude; using *gsub()*

The majority of variables starts with the prefix f for frequency or t for time as each measurement on time was transformed into frequencies. 


### The tidy data set

Finally, a second, independent tidy data set was computed from the previous one by calculating the average of each variable for each activity and each subject. This was done using the dplyr functions "group_by()" and "summarise_each()". The resulting data set was exported using the function write.table() and called "final.txt".
  
The tidy data set "final" consists of 180 observations (6 activities times 30 subjects) and 88 variables (86 measurements, subject and activity label). All values represent averages per activity label and subject.   
  








