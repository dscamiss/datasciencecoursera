
library(reshape2)

# set up directories

work_dir   <- "C:/users/scott/documents/coursera/data_science_specialization/getting_and_cleaning_data/course_project/"

setwd(work_dir)

data_dir       <- paste0(work_dir, "data/")
train_dir      <- paste0(data_dir, "train/")
test_dir       <- paste0(data_dir, "test/")

# load features corresponding to means and standard deviations
# - assumption is that we only want feature names containing "mean()" and "std()"
# - expand feature names into human-readable descriptions

feat_names     <- read.table(paste0(data_dir, "features.txt"), stringsAsFactors = F)
feat_cols      <- grep("mean\\(\\)|std\\(\\)", feat_names$V2)
feat_names     <- feat_names[feat_cols, ]$V2
feat_names     <- gsub("^t", "time-domain ", feat_names)
feat_names     <- gsub("^f", "frequency-domain ", feat_names)
feat_names     <- gsub("BodyBodyAcc", "BodyAcc", feat_names)
feat_names     <- gsub("BodyBodyGyro", "BodyGyro", feat_names)
feat_names     <- gsub("BodyAcc", "acceleration (body)", feat_names)
feat_names     <- gsub("BodyGyro", "gyroscopic", feat_names)
feat_names     <- gsub("GravityAcc", "acceleration (gravity)", feat_names)
feat_names     <- gsub("Mag", " magnitude", feat_names)
feat_names     <- gsub("Jerk", " jerk", feat_names)
feat_names     <- gsub("-mean\\(\\)", " mean", feat_names)
feat_names     <- gsub("-std\\(\\)", " standard deviation", feat_names)
feat_names     <- gsub("-X", ", X component", feat_names)
feat_names     <- gsub("-Y", ", Y component", feat_names)
feat_names     <- gsub("-Z", ", Z component", feat_names)

# load activities 

act_names      <- read.table(paste0(data_dir, "activity_labels.txt"), stringsAsFactors = F)
act_names      <- tolower(act_names$V2)
act_names      <- gsub("_", " ", act_names)

# load training and test sets, if necessary

if (!exists("df_train")) { 
  df_train_sub <- read.table(paste0(train_dir, "subject_train.txt"), stringsAsFactors = F)
  df_train_in  <- read.table(paste0(train_dir, "X_train.txt"), stringsAsFactors = F)
  df_train_in  <- df_train_in[, feat_cols]
  df_train_out <- read.table(paste0(train_dir, "Y_train.txt"), stringsAsFactors = F)
  df_train     <- cbind(df_train_sub, df_train_in, df_train_out)
}

if (!exists("df_test")) {
  df_test_sub  <- read.table(paste0(test_dir, "subject_test.txt"), stringsAsFactors = F)
  df_test_in   <- read.table(paste0(test_dir,  "X_test.txt"), stringsAsFactors = F)
  df_test_in   <- df_test_in[, feat_cols]
  df_test_out  <- read.table(paste0(test_dir,  "Y_test.txt"), stringsAsFactors = F)
  df_test      <- cbind(df_test_sub, df_test_in, df_test_out)
}

# merge (reduced) training and test sets

if (!exists("df_merge")) {
  df_merge <- rbind(df_train, df_test)
}

# set column names with descriptive names in features.txt

colnames(df_merge) <- c("subject", feat_names, "activity")

# make activities into factors with appropriate labels

if (!is.factor(df_merge$activity)) {
  df_merge$activity <- factor(df_merge$activity, levels = seq(1:6), labels = act_names)
}

# make subjects into factors 

df_melt <- melt(df_merge, id = c("subject", "activity"))

# take means over all subjects and activities

df_mean <- dcast(df_melt, subject + activity ~ variable, mean)

# write out df_mean to tidy.txt

if (exists("tidy.txt")) {
  file.remove("tidy.txt")
}
write.table(df_mean, "tidy.txt", row.names = FALSE, quote = FALSE)
