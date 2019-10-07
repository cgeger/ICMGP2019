ICMGP 2019 Lesson 1
================
Caitlin Eger
9/8/2019

Loading and Managing data
-------------------------

Please download data folder from github at: <https://github.com/cgeger/ICMGP2019/tree/master/data>

### The working directory

##### Where is your working directory?

This is the address or path that represents the location where R is currently working. You can only have one working directory active at a time

``` r
getwd()
```

##### What is in your working directory?

This is what R can "see" in the directory. If you want to access something that's not in the directory, you'll need to give R more explicit instructions (more on this later).

``` r
dir()
```

Many, many errors that occur happen because a function is trying to access an object that doesn't reference the correct directory or path. Make sure you know where you're working!

### Setting the working directory manually:

To set the working directory in the RStudio IDE, navigate to the "Files" tab &gt;&gt; click on the three dots &gt;&gt; navigate to your data folder &gt;&gt; click "Open" To encode the working directory: (copy the line and paste to top of your .R script file)

``` r
# setwd("~/ICMGP2019")
```

Reading Datasets into R
-----------------------

#### Reading in `.csv` data

Use the function `read.csv()` in base R Example: Honnedaga lake dataset

``` r
Hon <- read.csv("data/All_Honnedaga_water_chemistry.csv")
head(Hon) #look at the top of dataset
#tail(Hon, 10) #these are the last 10 rows of the dataset
str(Hon) #this object is a data.frame, note size and classes of each variable
```

##### Loading a package from CRAN

There are lots of packages available that contain specialized functions written by other R users. For example, you can use an R package called `readxl` that contains functions to reliably read in excel files. This is how to download and install a package from CRAN:

``` r
#install.packages("readxl") #this package contains functions that 
library(readxl) #load the package into the workspace
# You may get a warning message ?
R.Version() #this is the version you are running, should be okay
```

#### Reading in `.xlsx` files using `read_excel()`

Your code should follow the following structure: `read_excel("pathway/to/file.xlsx")`

``` r
Hon_xl1 <- read_excel("data/All_Honnedaga_water_chemistry.xlsx")
head(Hon_xl1) #look at what the dataset looks like -- slightly different than .csv version
str(Hon_xl1) #this object is a tibble "tbl", and a "data.frame"
dplyr::glimpse(Hon_xl1) #"tidyverse" version of str
```

Note that unlike the `read.csv()` function, the `NA`s read in as CHARACTERS, which is not a numeric class in R. We can explicitly tell the read\_excel function what values are representing `NA` in the dataset. Common values for this kind of data include an empty quote, whitespace, "NA", "NaN", "-", "-999" and other characters, depending on the dataset. Sometimes excel will default fill blank cells to zero, which is not the same as `NA`, so be careful to understand what `NA` means in the context of your dataset.

``` r
Hon_xl2 <- read_excel("data/All_Honnedaga_water_chemistry.xlsx",na = "NA")
head(Hon_xl2) #top of the dataset looks almost the same as Hon_xl1, but the classes of the variables are different
str(Hon_xl2) #better!
```

The `Hon_xl1` object isn't the version we want to keep, so this command removes the object from the workspace

``` r
rm(Hon_xl1) 
```

Notice that the object is now gone from my working environment.

##### Naming columns in a data frame

Let's look at the names of our new data frame:

``` r
names(Hon)
```

Two of them are hard to understand. What data is in there?

``` r
Hon$X
Hon$X.1
```

Let's clean these names up. We'll use the "assignment" character to do this, it looks like a little arrow `<-` and means "Make this equal to".

``` r
names(Hon)[[11]] <- "Time_Sampled"
names(Hon)[[12]] <- "AM_PM"
names(Hon) 
```

Now the new names are present in the dataset! It's good to keep units in column names, if possible, so that you don't have data lying around that has ambiguous units.

#### Read data from a group of `.csv` files

Let's say we have a bunch of files in `.csv` format that we want to read in and combine into a data frame. In the data folder there is a subfolder called "Fluoroprobe\_Data\_2018". It contains Fluoroprobe data from twenty six weekly sampling trips during May to November of 2018, taken by the Cornell Biological Field Station crew at Shackelton Point on Oneida Lake in New York. If we want to look at what's happening throughout the whole sampling season, we'll first need to get the weekly trips into a single file.

Let's start by getting the names of each of the files:

``` r
csvs <- dir("data/Fluoroprobe_Data_2018")
csv_paths <- paste("data/Fluoroprobe_Data_2018", csvs, sep = "/")
csv_paths
```

Next we can use a `for` loop to read in each file:

``` r
stack <- NULL #initialize an object to save our outputs into
for(i in seq_along(csv_paths)){ #iterate along the vector of csvs in the Fluoroprobe directory
  stack[[i]] <- read.csv(csv_paths[[i]])
}
```

Okay, let's examine the results of the `for` loop:

``` r
#look in the working environment #this is a list of 26 data frames!
#str(stack)
head(stack[[1]]) 
```

Note that there are some issues with the `read.csv()` command -- we'll need to skip some lines at the top of each file, rename a few columns and prevent strings from automatically becoming factors. We can do this in the `for` loop, but there is an easier way to do it using a function that takes advantage of R's vectorized operations: `lapply()`

``` r
rm(stack) 
```

This step is not strictly necessary, just a reminder for you that we are overwriting the object "stack". You'll notice that the giant `stack` list object is no longer in your working environment.

Okay, let's try again using `lapply()`

``` r
stack <- lapply(csv_paths, read.csv) 
str(stack[[1]])
```

This one line does exactly what the `for` loop did! Great!

Now let's clean up how we read things in by:

1.  skipping the non-data rows at the top of each `.csv`,
2.  fixing the `stringsAsFactors` command to get numeric classes instead of characters, and
3.  telling R how to handle `NA` values.

``` r
#?read.csv #understanding read.csv's arguments
stack <- lapply(csv_paths, read.csv, 
                skip = 2, header = F, #we'll drop the column names and name at the end
                stringsAsFactors = F, #tells R not to convert all characters to factors
                na.strings = c("","NA")) #tells R what NA values to recognize

str(stack[[1]])
```

##### Naming the list

Each `.csv` looks clean now, so let's go ahead and match the names. Fortunately, all our .csv datasets have the same exact format and same column order. This means we can simply wait until after we bind them into a single dataframe to name them. However, sometimes you will have a dataframe that is not quite the same, so be careful not to rename columns with incorrect field names. We can view the columns if we want to check they are the same:

``` r
names_list <- lapply(csv_paths, read.csv, nrow = 1, header = F)
names_list
```

We can use the data.table package to zip all the names from the list of names into a single data frame:

``` r
#install.packages("data.table")
library(data.table)
rbindlist(names_list)
```

Names are looking good!!

Okay, so let's stack up all our fluoroprobe data into a single dataframe! The `data.table` package is very nimble, so we can use the same data.table function, `rbindlist()` to handle our giant list just like it did the smaller list with the names.

``` r
FLP2018 <- rbindlist(stack) #all the fluoroprobe data in one dataset
```

Now let's rename the dataframe's variables. Here are names of the original dataset:

``` r
read.csv(csv_paths[[1]], nrow = 1, header = F)
```

Let's clean them up a bit by copying them from the console and pasting them into the script. We will use the `c()` function to combine them into a new vector called `names`. Then we can use the `names()` function to label the `FLP2018` data frame. Note that the `names` vector and the `names()` function are not the same.

``` r
names <- c("DateTime", "GreenAlgae", "Bluegreen", "Diatoms", "Cryptophyta", "Yellowsubs", "Totalconc", "Trans", "Depth", "Temp", "Site")
names(FLP2018) <- names
str(FLP2018)
```

##### Create a Date column

``` r
#?strptime
FLP2018$Date <- as.Date(FLP2018$DateTime, format = "%m/%d/%Y %H:%M")
```

If you have more than one type of file in your directory and you want to select only a certain file extension, you can use the following method:

``` r
files <- dir("~/ICMGP2019")[ grep("Rmd$", dir("~/ICMGP2019")) ] #makes a list of .Rmd files in the working directory
files
```

#### Reading data from a url online

This tinyurl is a shortcut to `.txt` file from the MusselWatch dataset at Kachemak, Alaska. You can view it in your browser and then read it directly into R.

``` r
url <- "https://tinyurl.com/Kachemak" #this is .txt data from the MusselWatch dataset at Kachemak, AK
Kmak <- read.delim(url)
head(Kmak)
str(Kmak)
```

#### Reading data from a .Rdata file'

This `.Rdata` file contains a list of urls from the MusselWatch dataset.

``` r
urls  <- readRDS("data/MW_urls.Rdata")
str(urls) #vector of strings, but Rdata can be in any R object class
```

#### Reading data from a bunch of urls online

Reading data from a list of urls is almost the same as reading in data from a bunch of `.csv` files on your local hard drive. However, in the the urls from the MusselWatch dataset, some of the `.txt` files are in `.csv` format and some are in tab-delimited format, so we want to read them in seperately. Let's make one vector containing urls with the csv-formatted data and the other vector with the tab-delimited datasets.

``` r
csvs <- urls[c(6,15,26)] #3 are csv
urls <- urls[-c(6,15,26)] #25 are tabbed
```

Now we can download datasets from all the urls using `lapply()` again. (This step might take a minute).

``` r
DAT1 <- lapply(urls, read.delim, stringsAsFactors = F) #these are the tab-delimited files
DAT2 <- lapply(csvs, read.delim, stringsAsFactors = F, sep = ",") #these are comma-separated
```

Each list has the right number of items (25 in DAT1 and 3 in DAT2)

##### Check column names to see if they match up

This is a nested function call that looks at all the names. Nested calls run from the inside out.

``` r
table(unlist(lapply(DAT1, names)))
```

##### Using multiple function operations in one step with dplyr

We can also use the pipe operator for the same call, which creates code that is easier to read and understand than nested function calls.

``` r
library(dplyr) #use dplyr for the %>% pipe operator
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:data.table':
    ## 
    ##     between, first, last

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
lapply(DAT1, names) %>% unlist() %>% table() 
lapply(DAT2, names) %>% unlist %>% table 
```

All the data frames in `DAT1` have the same names, but the third data frame in object `DAT2` has different names. We can look at `DAT2[[3]]` to see that there are some names with `.` instead of `_` in between words. Here are a couple other examples of how the pipe operator works.

``` r
head(DAT2[[3]])
DAT2[[3]] %>% head
```

Because the columns are all in the same order, in this case we can just take the names for one of the data frames

``` r
names(DAT2[[3]]) <- names(DAT2[[2]])
lapply(DAT2, names) %>% unlist %>% table #now all of them are the same
```

Now we can stack all the dataframes from the MusselWatch urls into one big dataset and check if DAT1 and DAT2 have the same names:

``` r
DAT1 <- rbindlist(DAT1)
DAT2 <- rbindlist(DAT2, fill = T)
names(DAT2) == names(DAT1) 
```

The first column still has different names, `names(DAT2)[[1]]` and `names(DAT1)[[1]]` don't match each other. All names need to be the same if we want to stack them into one big datset

``` r
names(DAT2)[[1]] <- names(DAT1)[[1]]
```

Finally we rbind! (row bind two data frames `DAT1` and `DAT2` together)

``` r
DAT <- rbind(DAT1, DAT2, fill = T)
str(DAT) #77786 observations of fish and mussel tissue
summary(DAT) #not very useful, because all the factors are in character class
```

Now we've just created a dataset with 77,786 observations of trace metals in fish and mussel tissue from across the coastal United States! Great work!

#### Quick summary using `summary()` and `table()`

``` r
DAT$study <- as.factor(DAT$study)
DAT <- DAT %>% mutate_if(is.character, as.factor) #conditional mutate
summary(DAT) #better!
table(DAT$Parameter) 
```

Subsetting datasets
-------------------

##### Splitting a dataset by factor

The `split()` function takes a data frame and makes a list of smaller data frames based on a factor. It's kind of like the opposite of rbindlist

``` r
all_params <- split(DAT, DAT$Parameter)
str(all_params) #this is a list of dataframes again, but we split by parameter instead of by site!
Hg <- all_params[["Mercury"]]
str(Hg)
summary(Hg)

#now we have a nice big mercury dataset!
table(Hg$Matrix) %>% sort #mostly mussels and oysters
```

##### Selecting a whole column

``` r
names(Hg)
Hg$Matrix
Hg["Matrix"]
Hg[[8]]
Hg[,8]
```

##### Selecting a whole row

``` r
Hg[4,]
```

##### Selecting a single observation

``` r
Hg$Matrix[4]
Hg$Matrix[[4]]
Hg[4,8]
```

##### Selecting columns with dplyr

``` r
Hg %>% dplyr::select(Matrix)
```

##### Selecting using a selector vector

A selector vector is an index of rows that meet a logical criteria in the form `k <- which(logical == T)`. I always use the variable `k` to denote a selector vector, so that I know it can always be overwritten after being used. You can name your selector vector something more informative if you know you're going to be using it throughout the code.

``` r
k <- which(Hg$Matrix == "Oyster")
k
Hg[k,]
Hg$Scientific_Name[k]
```

Here is an example of when a selector vector is useful. We need to correct some of the Fluoroprobe data. When someone entered data for sample site B125 in Excel, they accidentally auto-filled the data so that each row increased by 1. See what it looks like:

``` r
unique(FLP2018$Site)
```

Let's use our knowledge of selector vectors to correct this

``` r
k <- which(FLP2018$Site %in% c(paste("B", 126:161, sep = "")))
FLP2018$Site[k] <- "B125"
table(FLP2018$Site)
```

We can also use a selector vector to get rid of rows that were incorrectly calibrated.

``` r
k <- which(FLP2018$Depth > 11)
FLP2018 <- FLP2018[-k,]
```

Notive that I haven't changed the name of the object FLP2018, I just overwrite it with corrected data.

##### Filtering data with dplyr

Some of the Fluoroprobe samples are from measurements that occurred "between" sites, while the vessel was moving across the lake. They don't contain valid data, so we want to filter them out. The correct data are labelled in the `Site` column.

``` r
FLP2018 <- FLP2018 %>% filter(Site %in% c("3MB",  "B109",  "B125", "Shack"))
FLP2018$Site <- as.factor(FLP2018$Site)
summary(FLP2018)
```

We can also filter all of the rows in the `Hg` dataset to select only samples from mussel species, not other specimens.

``` r
Mussels <- Hg %>% dplyr::filter(Matrix == "Mussel")
head(Mussels)
```

Summarizing datasets
--------------------

Remember earlier when we summarized the Mussel Watch dataset `DAT` to get a sense what was in those 77K observations? We can do the same again with the mercury subset, and do more complex summaries using dplyr.

``` r
summary(Hg) #by column, not by row
```

##### Summarizing by category

There are 6 core dplyr functions: - select: selects, renames and orders columns - filter: filters rows by a logical criteria - group\_by: creates groups by factor - arrange: orders rows in ascending or descending order by one or more columns - summarize: performs a calculation groupwise across groups - mutate: performs a calculation to overwrite or create a new column

We can combine them using the pipe operator `%>%` to create complex dataset summaries. Let's try some:

``` r
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
```
