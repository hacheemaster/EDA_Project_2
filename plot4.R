#Question 4:
# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999-2008?

library(ggplot2)

#download file and unzip
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=url,destfile="data.zip")
unzip("data.zip")

#read in datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge them on SCC
merged <- merge(NEI,SCC,by="SCC",all.x=TRUE)

#find coal matches
coalMatches <- grepl("coal",merged$Short.Name,ignore.case=TRUE)
mergedSubset <- merged[coalMatches,]

pm25_yearly <- with (mergedSubset,
                     aggregate(list(total_emission=Emissions),
                               by=list(year=year),sum)) 

#create plot
png(file="plot4.png",width=400,height=400)
with(pm25_yearly,
     qplot(x=year, y=total_emission, geom="line",
           main = "Yearly total emission from combustion"))

dev.off()
