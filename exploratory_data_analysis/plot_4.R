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
png(filename = "plot_4.png")

# set up for multiple plots
par(mfrow = c(2, 2))

# time series of global active power
plot(df_power$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "", xaxt = "n")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# time series of voltage
plot(df_power$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# time series of sub-metering 1, 2, 3
plot(df_power$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")
lines(df_power$Sub_metering_2, col = "red") 
lines(df_power$Sub_metering_3, col = "blue")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), lwd = c(2.5, 2.5, 2.5), col = c("black", "blue", "red"))

# time series of global reactive power
plot(df_power$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

dev.off()

# EOF