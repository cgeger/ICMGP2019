#run the python repl (read-eval-print loop) in the R package 
#run: > reticulate::repl_python()
#when the console shows `>>>` you know you're coding in python

import os
os.getcwd() #this is the current working directory
dir() #these are the items present in the directory

#if you need to change the current working directory, use
os.chdir("D:\\Caitlin\\Documents\\ICMGP2019")
os.getcwd() #this is the current working directory

#let's read the dataset into the python environment as a pandas dataframe
#first you must install pandas module in the command line:
#On the R Studio click Tools >> Shell
#then you should see a window open with a `$` prompt (this is the command line)
#run: $ pip install pandas
#wait for the pandas module and its dependencies to download
import pandas as pd #import the pandas module into the environment
Hon = pd.read_csv("data/All_Honnedaga_water_chemistry.csv")
#if you want to make sure that it is in your environment and see the first few lines,
pd.DataFrame.head(Hon) #this is the top of the dataset, called as a function
#Python methods are based on the class of the object
Hon.head() #this is the top of the dataset, called as a method
Hon.tail(10) #these are the last 10 rows of the dataset
#note that the empty values show up as "NaN" or "not a number" in pandas dfs

Hon.info() #look at the names and types of the columns
Hon.describe() #this produces a summary of the columns
?pd.read_excel
Hon_xl1 = pd.read_excel("data/All_Honnedaga_water_chemistry.xlsx")
Hon_xl2 = pd.read_excel("data/All_Honnedaga_water_chemistry.xlsx", na_values = "NA")

#all these calls are essentially the same
Hon_xl1.info() == Hon_xl2.info()
Hon.info() == Hon_xl1.info()

# examine names and rename columns
list(Hon.columns)
Hon["X"]
Hon["X.1"]

#in pandas, you can rename using a dictionary of new names
Hon = Hon.rename(columns = {"X" : "Time_Sampled", "X.1" : "AM_PM"})
list(Hon.columns)


#Let's try the stack of csvs
csvs = os.listdir("data/Fluoroprobe_Data_2018")
path = 'data/Fluoroprobe_Data_2018/'
csvs = [path + csv for csv in csvs ]

#read in a list of all the csv files
csvlist = [pd.read_csv(csv) for csv in csvs]

#read in the column names of each csv in the list
headdf = pd.DataFrame([csv.columns for csv in csvlist])


head = [csv.columns for csv in csvlist]
h = [h == head[1] for h in head]

head[1] == head.iloc[1,1]


for csv in csvs:
   reader = pd.read_csv(csv)
   stack = list(reader)


stack = pd.read_csv(csv) for csv in csvs


 
