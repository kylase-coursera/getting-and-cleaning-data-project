run_analysis <- function() {
  # Create the data directory to store data if it does not exist
  data_dir <- "./data"
  if(!file.exists(data_dir)) {
    dir.create(file.path(data_dir))
  }
  # Download the data file if it does not exist
  src_file_link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  data_path <- file.path(data_dir, "data.zip")
  if(!file.exists(data_path)) {
    print("Downloading data file")
    if(Sys.info()["sysname"] == "Windows") {
      download.file(src_file_link, destfile = data_path)
    } else {
      download.file(src_file_link, destfile = data_path, method = "curl")
    }
    
    print("Data file downloaded")
    } else {
      print("Data file exists")
    }

  # Extract the data out of the archive
  dataset_path <- file.path("./UCI HAR Dataset")
  if(!file.exists(dataset_path)) {
    print("Unzipping data file")
    unzip(data_path)
    print("Unzip completed")
  }

  # Set path for dataset
  dataset_path <- file.path("./UCI HAR Dataset")

  # Set training and test path
  training_set_path <- file.path(dataset_path, "train")
  test_set_path <- file.path(dataset_path, "test")

  test_features_path <- file.path(test_set_path, "X_test.txt")
  train_features_path <- file.path(training_set_path, "X_train.txt")
  test_labels_path <- file.path(test_set_path, "y_test.txt")
  train_labels_path <- file.path(training_set_path, "y_train.txt")

  subject_train_path <- file.path(training_set_path, "subject_train.txt")
  subject_test_path <- file.path(test_set_path, "subject_test.txt")

  # Read Data and Documentation
  features_names <- read.table(file.path(dataset_path, "features.txt"), colClasses = "character", stringsAsFactors = FALSE)
  activity_label_map <- read.table(file.path(dataset_path, "activity_labels.txt"), stringsAsFactors = FALSE, col.names = c("labelInt", "labelString"))

  f <- rbind(read.table(test_features_path, colClasses = "numeric", col.names = features_names[, 2], check.names = TRUE), 
   read.table(train_features_path, colClasses = "numeric", col.names = features_names[, 2], check.names = TRUE))
  a <- rbind(read.table(test_labels_path, colClasses = "integer", col.names = c("Activity")), 
   read.table(train_labels_path, colClasses = "integer", col.names = c("Activity")))
  s <- rbind(read.table(subject_test_path, colClasses = "integer", col.names = c("Subject")),
   read.table(subject_train_path, colClasses = "integer", col.names = c("Subject")))

  library(dplyr)

  a <- mutate(tbl_df(a), Activity = activity_label_map[Activity, 2])

  f_with_mean_and_std <- f[, grep("mean\\(|std\\(", features_names[, 2])]

  combined_column_names <- c("Subject", "Activity", features_names[grep("mean\\(|std\\(", features_names[, 2]), 2])
  combined_column_names <- gsub("\\(\\)", "", combined_column_names)
  combined_df <- cbind(s, a, f_with_mean_and_std)
  names(combined_df) <- combined_column_names
  mean_of_all_columns <- summarise_each(group_by(combined_df, Subject, Activity), funs(mean))
}
