# The goal is the explore the National  Inventory database

# Loading provided datasets - loading from local machine
setwd("C:/Users/Asus/Desktop/Data Science Coursera/EDA")

unzip("C:/Users/Asus/Desktop/Data Science Coursera/EDA/exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
total.emissions <- aggregate(Emissions ~ year, NEI, sum)

# Generate the graph in the same directory as the source code
png(filename="C:/Users/Asus/Desktop/Data Science Coursera/EDA/plot1.png")

barplot((total.emissions$Emissions)/10^6, names.arg=total.emissions$year, 
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab="PM2.5 Emissions (10^6 Tons)")

dev.off()

