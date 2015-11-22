#Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California
# (fips == 06037). Which city has seen greater changes over time in motor 
# vehicle emissions?

library(ggplot2)

#download file and unzip
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=url,destfile="data.zip")
unzip("data.zip")

#read in datasets
NEI <- readRDS("summarySCC_PM25.rds")
NEI_subset <- subset(NEI,(fips=="24510" | fips=="06037") & type=="ON-ROAD")
#SCC <- readRDS("Source_Classification_Code.rds")

pm25_yearly <- with (NEI_subset,
                     aggregate(list(total_emission=Emissions),
                               by=list(year=year, fips=fips),sum)) 

#create plot
png(file="plot6.png",width=500,height=400)
q <- with(pm25_yearly,
        qplot(x=year, y=total_emission, col=fips, geom="line",
           main = "Yearly total emission for Baltimore (\"24510\") 
           and LA County (\"06037\") from motor vehicles"))
q + geom_text(aes(label=round(total_emission)),hjust=0.5,vjust=1)
dev.off()
