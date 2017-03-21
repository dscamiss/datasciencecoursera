course_dir <- "C:/users/scott/documents/coursera/data_science_specialization/exploratory_data_analysis/week_1/project/"
setwd(course_dir)
txt_file   <- paste0(course_dir, "household_power_consumption.txt")

# read txt file
if (!exists("df_power")) {
  df_power <- read.csv(txt_file, sep = ";", header = T, skip = 66636, nrows = 2880, stringsAsFactors = F, na.strings = "?")
}

# re-assign column names
colnames(df_power) <- read.csv(txt_file, sep = ";", header = F, nrows = 1, stringsAsFactors = F);

# save plot to PNG
png(filename = "plot_1.png")

# histogram of global active power
hist(df_power$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylim = c(0, 1200))

dev.off()

# EOF