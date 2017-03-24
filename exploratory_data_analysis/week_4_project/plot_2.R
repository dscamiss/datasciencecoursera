course_dir <- "C:/Users/Scott/Documents/coursera/data_science_specialization/exploratory_data_analysis/week_4/project/"
setwd(course_dir)

# read data, if necessary
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# get baltimore total PM2.5 emissions from 1999 to 2008

bmore_data      <- subset(NEI, fips == "24510")
total_pm25_1999 <- sum(subset(bmore_data, year == 1999)$Emissions)
total_pm25_2002 <- sum(subset(bmore_data, year == 2002)$Emissions)
total_pm25_2005 <- sum(subset(bmore_data, year == 2005)$Emissions)
total_pm25_2008 <- sum(subset(bmore_data, year == 2008)$Emissions)
total_pm25      <- c(total_pm25_1999, total_pm25_2002, total_pm25_2005, total_pm25_2008)

# plot the total PM2.5 emissions to investigate the trend

plot(total_pm25, xaxt = 'n')
axis(side = 1, at = 1:4, labels = c("1999", "2002", "2005", "2008"))

# save plot as PNG

dev.copy(png, "plot_2.png")
dev.off()

# EOF