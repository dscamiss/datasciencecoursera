library(ggplot2)
library(gridExtra)

course_dir <- "C:/Users/Scott/Documents/coursera/data_science_specialization/exploratory_data_analysis/week_4/project/"
setwd(course_dir)

# read data, if necessary
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# find motor vehicle-related SCC entries (there's probably a more precise way, let's assume this correctly identifies them)

scc_vehicle       <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case = T), 1]

# in baltimore

bmore_data        <- subset(NEI, fips == "24510")
bmore_nei_vehicle <- subset(bmore_data, SCC %in% scc_vehicle)

# in los angeles

la_data           <- subset(NEI, fips == "06037")
la_nei_vehicle    <- subset(la_data, SCC %in% scc_vehicle)

# plot the total PM2.5 emissions to investigate the trends

par(mfrow = c(1, 2))

p <- ggplot(bmore_nei_vehicle, aes(factor(year), Emissions)) 
p <- p + geom_col() + labs(title = "Baltimore")

q <- ggplot(la_nei_vehicle, aes(factor(year), Emissions)) 
q <- q + geom_col() + labs(title = "Los Angeles")

grid.arrange(p, q, ncol = 2)

# save plot as PNG

dev.copy(png, "plot_6.png")
dev.off()

# EOF