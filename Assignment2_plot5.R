# Loading provided datasets - loading from local machine
setwd("C:/Users/Asus/Desktop/Data Science Coursera/EDA")

unzip("C:/Users/Asus/Desktop/Data Science Coursera/EDA/exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(plyr)
library(ggplot2)

#Merge both NEI and SCC files
Both <- merge(NEI, SCC, by ="SCC")

# We are only interested at datasets of Baltimore for onroad emissions (to find motor vehicle related sources)
Baltimore.onroad <- subset(Both, fips == "24510" & type =="ON-ROAD", c("Emissions", "type", "year"))

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

Total.emissions.mobile <- aggregate(Emissions ~ year, Baltimore.onroad, sum)

##Prepare to plot to png
png(filename="C:/Users/Asus/Desktop/Data Science Coursera/EDA/plot5.png")
g <- ggplot(Total.emissions.mobile, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Mobile Vehicle Emissions from 1999 to 2008 in Baltimore')
print(g)
dev.off()

