# Loading provided datasets - loading from local machine
setwd("C:/Users/Asus/Desktop/Data Science Coursera/EDA")

unzip("C:/Users/Asus/Desktop/Data Science Coursera/EDA/exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(plyr)
library(ggplot2)

#Merge both NEI and SCC files
Both <- merge(NEI, SCC, by ="SCC")
 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Use grepl to find coal combustion-related sources
coal.related <- grepl("coal", Both$Short.Name, ignore.case=TRUE)
subsetBoth <- Both[coal.related, ]

Total.emissions.coal <- aggregate(Emissions ~ year + type, subsetBoth, sum)

##Prepare to plot to png
png(filename="C:/Users/Asus/Desktop/Data Science Coursera/EDA/plot4.png")
g <- ggplot(Total.emissions.coal, aes(year, Emissions, color = type))
g <- g + geom_line() +
  geom_point(aes(shape=type, size=4)) +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Coal-related Emissions from 1999 to 2008')
print(g)
dev.off()

