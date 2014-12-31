# load ggplot2 package
library(ggplot2)

# Set the working directory to the directory where the data is saved
setwd("/roger/Coursera//Exploratory_Analysis/Exploratory_Data_Analysis_Course_Project2/exdata-data-NEI_data/")

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting Coal Combustion-related Emission Source's SCC
CCR_SCC <- SCC$SCC[grep("Comb+(*.)+Coal", SCC$EI.Sector)]

# Subsetting all Emissions data across the US for Coal Combustion-related Source
NEI_CCR <- subset(NEI, SCC %in% CCR_SCC)
Emissions_CCR <- aggregate(Emissions ~ year, NEI_CCR, sum)

# Plotting the total emissions from Coal Combustion-related Source Types across
# the US in four years

png("plot4.png", height = 500, width = 600)
ggplot(Emissions_CCR, aes(x = factor(year), y = Emissions/10^3)) + 
    geom_bar(stat = "identity", fill = c("Black", "Red", "Blue", "Green")) + xlab("Years") + 
    ylab("Total PM2.5 Emissions (1000 Tonnes)") + 
    ggtitle("Total PM2.5 Emissions by \n Coal Combustion-realted Sources in US, 1999-2008") + 
    theme(axis.title.x = element_text(face = "bold", size = 16), 
          axis.title.y = element_text(face = "bold", size = 16),
          plot.title = element_text(face = "bold", size = 16),
          axis.text.x = element_text(face = "bold", size = 12),
          axis.text.y = element_text(face = "bold", size = 12))
dev.off()


