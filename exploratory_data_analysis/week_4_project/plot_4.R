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

# find coal combustion-related SCC entries (there's probably a more precise way, let's assume this correctly identifies them)

scc_coal <- SCC[grepl("coal", SCC$SCC.Level.Four, ignore.case = T), 1]
nei_coal <- subset(NEI, SCC %in% scc_coal)

# plot the total PM2.5 emissions to investigate the trends

p <- ggplot(nei_coal, aes(factor(year), Emissions)) 
p <- p + geom_col()

print(p)

# save plot as PNG

dev.copy(png, "plot_4.png")
dev.off()

# EOF