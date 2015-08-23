# Loading provided datasets - loading from local machine
setwd("C:/Users/Asus/Desktop/Data Science Coursera/EDA")

unzip("C:/Users/Asus/Desktop/Data Science Coursera/EDA/exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(plyr)
library(ggplot2)

#Merge both NEI and SCC files
Both <- merge(NEI, SCC, by ="SCC")

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == “06037”)
Compare <- subset(Both, (fips == "24510" | fips == "06037") & type =="ON-ROAD", c("Emissions", "year","type", "fips"))

#Rename fips to respective cities' 
Compare <- rename(Compare, c("fips"="City"))

Compare$City[which(Compare$City == "24510")] <- "Baltimore City"

Compare$City[which(Compare$City == "06037")] <- "Los Angeles County"

Compare <- aggregate(Emissions ~ year + City, Compare, sum)

#Total.emissions.mobile <- aggregate(Emissions ~ year, Baltimore.onroad, sum)

##Prepare to plot to png
png(filename="C:/Users/Asus/Desktop/Data Science Coursera/EDA/plot6.png")
g <- ggplot(Compare, aes(factor(year), Emissions, fill = City))
g <- g + geom_bar(stat="identity", position = position_dodge()) +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Comparison of Mobile Vehicle Emissions from 1999 to 2008 for Baltimore and Los Angeles')
print(g)
dev.off()

