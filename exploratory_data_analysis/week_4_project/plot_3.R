library(ggplot2)

course_dir <- "C:/Users/Scott/Documents/coursera/data_science_specialization/exploratory_data_analysis/week_4/project/"
setwd(course_dir)

# read data, if necessary
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# get baltimore-specific data

bmore_data <- subset(NEI, fips == "24510")

# plot the total PM2.5 emissions from 1998 to 2002 to investigate the trends

p <- ggplot(bmore_data, aes(factor(year), Emissions)) 
p <- p + geom_col()
p <- p + facet_grid(. ~ type)

print(p)

# save plot as PNG

dev.copy(png, "plot_3.png")
dev.off()

# EOF