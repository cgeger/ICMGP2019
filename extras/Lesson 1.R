# ICMGP Workshop Part I
# Caitlin Eger

# please download data folder from github

# Loading sand Managing data
#where is your working directory?
getwd()

#setting the working directory manually:
#"Files" >> three dots >> navigate to folder >> "Open"
#encoding the working directory: (can copy line and paste to top of file)
setwd("E:/ICMGP2019")

#Reading in .csv data
#read.csv() in base R
#Honnedaga lake dataset
Hon <- read.csv("data/All_Honnedaga_water_chemistry.csv")
head(Hon) #look at the top of dataset
str(Hon) #this object is a data.frame, note size and classes of each variable

#Reading in .xlsx files
install.packages("readxl") #this package contains functions that reliably read excel files
library(readxl) #load the package into the workspace
# warning message ?
R.Version() #this is the version we are running

Hon_xl1 <- read_excel("data/All_Honnedaga_water_chemistry.xlsx")
head(Hon_xl1) #look at what the dataset looks like -- slightly different
str(Hon_xl1) #this object is a tibble "tbl", and a "data.frame"
dplyr::glimpse(Hon_xl1) #"tidyverse" version of str
#note that the NAs read in as CHARACTERS!!!

Hon_xl2 <- read_excel("data/All_Honnedaga_water_chemistry.xlsx",na = "NA")
head(Hon_xl2) #top of the dataset looks almost the same as Hon_xl1, but the classes of the variables are different
str(Hon_xl2) #better!
rm(Hon_xl1) #removes the object from the workspace

#naming a df (good to keep units in column names, if possible)
names(Hon)
Hon$X
Hon$X.1
names(Hon)[[11]] <- "Time_Sampled"
names(Hon)[[12]] <- "AM_PM"
names(Hon) #now the new names are present

# group of .csvs
#read in files into a data frame
csvs <- dir("data/Fluoroprobe_Data_2018")
csv_paths <- paste("data/Fluoroprobe_Data_2018", csvs, sep = "/")

#using a for loop
stack <- NULL #initialize an object to save our outputs into
for(i in seq_along(csv_paths)){ #iterate along the vector of csvs in the Fluoroprobe directory
  stack[[i]] <- read.csv(csv_paths[[i]])
}

#examine the results:
str(stack) #this is a list of 26 data frames!
head(stack[[1]]) #note that there are some issues with the read.csv command -- 
#need to skip some lines, rename columns and prevent strings from becoming factors.

#easier way to do it using R's vectorized operations: lapply
rm(stack) #not strictly necessary, just a reminder for you that we are overwriting the object "stack"

stack <- lapply(csv_paths, read.csv) #this one line does exactly what the for loop did!
str(stack[[1]])

# Skipping rows, strings as factors and NAs
?read.csv #understanding read.csv's arguments
stack <- lapply(csv_paths, read.csv, 
                stringsAsFactors = F, 
                skip = 2, 
                header = F, 
                na.strings = c("","NA"))

str(stack[[1]])

#stack them up into a single dataframe!
install.packages("data.table")
FLP2018 <- data.table::rbindlist(stack) #all the fluoroprobe data in one dataset

#read in files into a data frame
#files <- dir()[grep("csv$", dir())] #makes a list of .csv files in the working directory
#stack <- lapply(files, read.csv, stringsAsFactors = F, skip = 1)
#FLP2018 <- rbindlist(stack)
#rename dataframe variables
read.csv(csv_paths[[1]], nrow = 1, header = F)
names <- c("DateTime", "GreenAlgae", "Bluegreen", "Diatoms", "Cryptophyta", "Yellowsubs", "Totalconc", "Trans", "Depth", "Temp", "Site")
names(FLP2018) <- names
str(FLP2018)

#create Date column
FLP2018$Date <- as.Date(FLP2018$DateTime, format = "%m/%d/%Y %H:%M")


#reading from a url online
url <- "https://tinyurl.com/Kachemak" #this is .txt data from the MusselWatch dataset at Kachemak, AK
Kmak <- read.delim(url)
head(Kmak)
str(Kmak)

#reading from a .Rdata file
urls  <- readRDS("data/MW_urls.Rdata")
str(urls) #vector of strings, but Rdata can be in any R object class

#reading a bunch of urls online:
#some of these .txt files are in .csv format and some are in tab-delimited format
csvs <- urls[c(6,15,26)] #3 are csv
urls <- urls[-c(6,15,26)] #25 are tabbed

#download datasets from all urls (might take a minute)
DAT1 <- lapply(urls, read.delim, stringsAsFactors = F) #these are the tab-delimited files
DAT2 <- lapply(csvs, read.delim, stringsAsFactors = F, sep = ",") #these are comma-separated

#look at the lists
str(DAT1)
str(DAT2)

#check to see if column names match up
#multiple function operations in one step
table(unlist(lapply(DAT1, names))) #all have the same names

library(dplyr) #use dplyr for the %>% pipe operator
lapply(DAT1, names) %>% unlist() %>% table() #all have the same names, using dplyr
lapply(DAT2, names) %>% unlist %>% table #there is one data frame (DAT2[[3]]) with different names
head(DAT2[[3]])
DAT2[[3]] %>% head

#match the names for all data frames
names(DAT2[[3]]) <- names(DAT2[[2]])
lapply(DAT2, names) %>% unlist %>% table #now all of them are the same

#stack dataframes into one big dataset
install.packages("data.table")
library(data.table)
DAT1 <- rbindlist(DAT1)
DAT2 <- rbindlist(DAT2, fill = T)
names(DAT2) == names(DAT1) #one column still has different names
#all names need to be the same if we want to stack them into one big datset
names(DAT2)[[1]] <- names(DAT1)[[1]]

#finally we rbind! (row bind)
DAT <- rbind(DAT1, DAT2, fill = T)

#look at structure of new dataset
str(DAT) #77786 observations of fish and mussel tissue
summary(DAT) #not very useful, because all the factors are in character class
DAT$study <- as.factor(DAT$study)
DAT <- DAT %>% mutate_if(is.character, as.factor) #conditional mutate
summary(DAT) #better!

#look at all data
table(DAT$Parameter)

all_params <- split(DAT, DAT$Parameter)
str(all_params) #this is a list of dataframes again, but we split by parameter instead of by site!
Hg <- all_params[["Mercury"]]
str(Hg)
summary(Hg)

#now we have a nice big mercury dataset!
table(Hg$Matrix) %>% sort #mostly mussels and oysters


#subsetting
#selecting a whole column
names(Hg)
Hg$Matrix
Hg["Matrix"]
Hg[[8]]
Hg[,8]

#selecting a whole row
Hg[4,]

#selecting a single observation
Hg$Matrix[4]
Hg$Matrix[[4]]
Hg[4,8]


#selecting with dplyr
Hg %>% dplyr::select(Matrix)

#using a selector vector; k <- which(logical)
k <- which(Hg$Matrix == "Oyster")
Hg[k,]
Hg$Scientific_Name[k]

#correct Sample site B125  -- selector vector!
k <- which(FLP2018$Site %in% c(paste("B", 126:161, sep = "")))
FLP2018$Site[k] <- "B125"
table(FLP2018$Site)

#filter out samples that are "between" sites (not valid data)
FLP2018 <- FLP2018 %>% filter(Site %in% c("3MB",  "B109",  "B125", "Shack"))
FLP2018$Site <- as.factor(FLP2018$Site)
summary(FLP2018)

#get rid of rows that were incorrectly calibrated
k <- which(Shack$Depth > 11)
Shack <- Shack[-k,]

#dplyr filtering rows
Mussels <- Hg %>% dplyr::filter(Matrix == "Mussel")
head(Mussels)

#summarizing datasets
summary(Hg) #by column, not by row

#summarizing by category (6 core dplyr functions: group_by, arrange summarize, mutate, select, filter)
Hg %>% group_by(Matrix) %>% summarise(avgHg = mean(Result)) %>% arrange(desc(avgHg))
Hg %>% group_by(Matrix) %>% 
  summarise(avgHg = mean(Result),
            stdevHg = sd(Result),
            n = n()) %>% 
  arrange(desc(avgHg))

Hg %>% group_by(Matrix, Scientific_Name) %>% 
  summarise(avgHg = mean(Result),
            stdevHg = sd(Result),
            n = n()) %>% 
  arrange(desc(avgHg))


#STOP##
# API ################################33
# NWIS and RNOAA
install.packages("rnoaa")
library(rnoaa) #click on package help

buoy_stations(Kmak$General_Location)

# Cleaning and joining




# Merge or full, anti, semi, right, left join
