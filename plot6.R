# load ggplot2 package
library(ggplot2)

# Set the working directory to the directory where the data is saved
setwd("/roger/Coursera//Exploratory_Analysis/Exploratory_Data_Analysis_Course_Project2/exdata-data-NEI_data/")

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting SCC for Emissions Source from Motor Vehicle 
MV_SCC <- SCC$SCC[grep("Motor", SCC$SCC.Level.Three)]

# Subsetting all Emissions data in Baltimore related to Motor Vehicles 
Baltimore_MV <- subset(NEI, NEI$fips == "24510" & NEI$SCC %in% MV_SCC)
Baltimore_EMV <- aggregate(Emissions ~ year, Baltimore_MV, sum)
Baltimore_EMV$City <- "Baltimore"

# Subsetting all Emissions data in Los Angeles related to Motor Vehicles
LA_MV <- subset(NEI, NEI$fips == "06037" & NEI$SCC %in% MV_SCC)
LA_EMV <- aggregate(Emissions ~ year, LA_MV, sum)
LA_EMV$City <- "Los Angeles"

# Combine the Aggregated results of Baltimore and LA
EMV_TwoCities <- rbind(Baltimore_EMV, LA_EMV)

# Plotting the barplots for total emissions from Motor Vehicle Sources in 
# Baltimore vs that in LA across years
png("plot6.png", height = 500, width = 600)
ggplot(EMV_TwoCities, aes(x = factor(year), y = Emissions, fill = City)) +
    geom_bar(stat = "identity") + facet_grid(. ~ City) + xlab("Years") + 
    ylab("Total PM2.5 Emissions (Tonnes)") + 
    ggtitle("Total PM2.5 Emissions by Motor Vehicles \n Baltimore Vs. Los Angeles, 1999-2008") + 
    scale_fill_discrete(name = "Cities") +
    theme(axis.title.x = element_text(face = "bold", size = 16), 
          axis.title.y = element_text(face = "bold", size = 16),
          plot.title = element_text(face = "bold", size = 16),
          axis.text.x = element_text(face = "bold", size = 12),
          axis.text.y = element_text(face = "bold", size = 12))
dev.off()



