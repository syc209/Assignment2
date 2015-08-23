# Loading provided datasets - loading from local machine
setwd("C:/Users/Asus/Desktop/Data Science Coursera/EDA")

unzip("C:/Users/Asus/Desktop/Data Science Coursera/EDA/exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
Baltimore.NEI  <- NEI[NEI$fips=="24510", ]
Baltimore.emissions <- aggregate(Emissions ~ year + type, Baltimore.NEI, sum)

##Prepare to plot to png
png(filename="C:/Users/Asus/Desktop/Data Science Coursera/EDA/plot3.png")
g <- ggplot(Baltimore.emissions, aes(year, Emissions, color = type))
g <- g + geom_line() +
  geom_point(aes(shape=type, size=4)) +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')
print(g)
dev.off()

