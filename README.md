---
title: "Introduction to R"
author: "Geoffrey Millard"
date: "August 7, 2019"
output: 
  html_document:
    keep_md: TRUE
---


# A Short Introduction to R
## Congratulations on deciding to use R!

R is a really cool software package that provides a coding language and environment for statistical and mathematical computing. It is open source software (free!) and can run on UNIX, Windows and iOS computers, with generally the same syntax across all platforms. We will be using R within the RStudio integrated development environment (IDE) for the ICMGP workshop. RStudio provides a popular graphical user interface (GUI) for interacting with the R language. If you want an example of the cool things you can do using these tools, look no further than this html file, which was generated using only R and RStudio! 

For the purposes of the ICMGP2019 workshop, please take the time to **download and install BOTH R and RStudio before the workshop** on September 8. You can download R from http://www.r-project.org and R Studio at https://www.rstudio.com.

This introduction is designed to help you get started with the software package.  It will cover some very basic tasks that will come in handy during the workshop.  **Please take the time to go through this introduction before the workshop begins.**

## Let's get started!

Once you open RStudio, you will be presented with a screen similar to this:

![](startup_screen_1.png)
<img src="guide_images/startup_screen_1.png" width="1920px">

<div class="figure">
<img src="startup_screen_1.png" alt="Figure 1: This is what RStudio looks like when you start it up." width="1920" />
<p class="caption">Figure 1: This is what RStudio looks like when you start it up.</p>
</div>

You should see three (or four) panels depending on whether you have used RStudio before. 

On the left is the R console, which is the main computational window. On the upper right you can view items in your working environment, and below it browse through files in your working directory and on your computer. 

The console will initially display some R versioning information and a little blue prompt that looks like this: <span style=" font-weight: bold;    color: blue !important;font-size: 16px;" >&gt;</span>
The console is where your commands tell R what to compute, and the prompt tells you that R is ready to recieve your code instructions.

Usually we want to keep a saved record of our work, so instead of working directly in the console, we open a script and save our codework there. We can do this with the keyboard shortcut ctrl+shift+N, or by clicking `File -> New File -> R Script`.  You should now have a new script window above your console, in a *newly* opened 4th panel, that looks like this:

<div class="figure">
<img src="guide_images/startup_screen.png" alt="Figure 2: This is what you want RStudio to look like." width="1920" height="1080" />
<p class="caption">Figure 2: This is what you want RStudio to look like.</p>
</div>

(If you have used RStudio before, you may have started with some script windows already open.) **Running the code in our script is very easy, simply click the line of code you want to run and press ctrl+enter (or press ctrl+enter when you finish typing a line of code).** This will transfer that line of script to the console and perform the designated function.

You may also want to "soft wrap" your code so that your script doesn't type off the side of the screen.  You can do that by clicking *Tools -> Global Options* and then in the Code table select the *soft wrap R Source files* box.

<div class="figure">
<img src="guide_images/softwrap_dialogue.png" alt="Figure 3: I find soft-wrapping my code incredibly useful." width="1920" height="1080" />
<p class="caption">Figure 3: I find soft-wrapping my code incredibly useful.</p>
</div>

The final thing we want to do before jumping into some code is to set the working directory. A very simple way to do this is to navigate to *Session -> Set Working Directory -> Set Directory*, or by using the keyboard shortcut `Ctrl+Shift+H` and navigating to your desired directory (eg.`C:/Users/gmill/Dropbox/Conference workshops/ICMGP2019/`). You should then see in the console the command <span style="     color: blue !important;" >&gt; setwd('C:/Users/gmill/Dropbox/Conference workshops/ICMGP2019/')</span>, which you can copy and paste into your script.

## Let's Get Started

... with some terminology. The types of data we will work with most often in RStudio are vectors and data frames. A vector is a "one-dimensional" set of values that are all of the same class. A vector can be as short as only one item, or it can be millions of items. Similarly, a data frame is a "two-dimensional" collection of vectors, where each.

Let's start by making a vector with only one value. Use the less-than symbol `<` and a minus sign `-` to form the two-character arrow `<-` that is the R assignment symbol. In a sentence, `x <- 3` means "make x equal to 3."


```r
x <- 3
```

Note that after we run this line of code, `x` appears in our Environment (top right tab) with the value 3.

Now if we run:


```r
x <- 5
x
```

```
## [1] 5
```

we have reassigned the value of `x` and printed `x` in the console.  The `[1]` indicates that 5 is the first value of vector x.

Now we can do some basic math,


```r
x^3
```

```
## [1] 125
```

and we can assign that to a new variable.


```r
y <- x^3
```

Try it out yourself!!


We could also make a vector that contains a sequence of numbers or text. Note that the `#` symbol tells R that the following line is a comment, and not actually a line of code (very useful for documenting your work!!!)


```r
# We can collect a group of numbers or characters
i <- c(1, 3, 5, 7, 9, 11, 13, 15, 17, 19)
k <- c('q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p')

# input a sequence of numbers
j <- seq(2, 20, 2)

# or a repeating set of factors
m <- rep(c('left', 'right'), 5)
```

If you notice, all these vectors all have a length of ten, while `x` has a length of one.  


```r
length(x)
```

```
## [1] 1
```

```r
length(i)
```

```
## [1] 10
```

```r
length(j)
```

```
## [1] 10
```

```r
length(k)
```

```
## [1] 10
```

```r
length(m)
```

```
## [1] 10
```

Since all vectors `i`,`j`,`k`, and `m` are all the same length, we can actually combine them into a dataframe!  The `str()` function gives us some additional information about the data frame, and the `View()` function lets us look at the data frame as if it were a spreadsheet. 


```r
df <- data.frame(i, j, k, m)
df
```

```
##     i  j k     m
## 1   1  2 q  left
## 2   3  4 w right
## 3   5  6 e  left
## 4   7  8 r right
## 5   9 10 t  left
## 6  11 12 y right
## 7  13 14 u  left
## 8  15 16 i right
## 9  17 18 o  left
## 10 19 20 p right
```

```r
str(df)
```

```
## 'data.frame':	10 obs. of  4 variables:
##  $ i: num  1 3 5 7 9 11 13 15 17 19
##  $ j: num  2 4 6 8 10 12 14 16 18 20
##  $ k: Factor w/ 10 levels "e","i","o","p",..: 5 9 1 6 7 10 8 2 3 4
##  $ m: Factor w/ 2 levels "left","right": 1 2 1 2 1 2 1 2 1 2
```

```r
View(df)
```

We can see that both `i` and `j` are numerical data and that `k` is a factor.

We can also create column names for the data, either as we make the dataframe or afterwards as a separate step.


```r
df1 <- data.frame('odd' = i, 'even' = j, 'hand' = m, 'letters' = k)
str(df1)
```

```
## 'data.frame':	10 obs. of  4 variables:
##  $ odd    : num  1 3 5 7 9 11 13 15 17 19
##  $ even   : num  2 4 6 8 10 12 14 16 18 20
##  $ hand   : Factor w/ 2 levels "left","right": 1 2 1 2 1 2 1 2 1 2
##  $ letters: Factor w/ 10 levels "e","i","o","p",..: 5 9 1 6 7 10 8 2 3 4
```

We can use those column names to specify the data we want to use, or use [], or a combination of the two


```r
df1$odd # specifies the entire "odd" column `df$column`
```

```
##  [1]  1  3  5  7  9 11 13 15 17 19
```

```r
df1[2,1] # specifies the second value `df[row, ]` of the first column `df[ ,column]`
```

```
## [1] 3
```

```r
df1$odd[2] # specifies the second value of the "odd" column `df$column[row]`
```

```
## [1] 3
```

Notice that the last two accomplish the same thing.  They each return the second value of the *`df1$odd`*, or first column

This notation comes in handy if your have a list of R objects.  Lists are a group of different objects and are really useful when you are generating some type of output (like a linear regression).  Lets create a list of R objects.


```r
all <- list(a=df1, b=df, c=i, d=j, e=x)
all
```

```
## $a
##    odd even  hand letters
## 1    1    2  left       q
## 2    3    4 right       w
## 3    5    6  left       e
## 4    7    8 right       r
## 5    9   10  left       t
## 6   11   12 right       y
## 7   13   14  left       u
## 8   15   16 right       i
## 9   17   18  left       o
## 10  19   20 right       p
## 
## $b
##     i  j k     m
## 1   1  2 q  left
## 2   3  4 w right
## 3   5  6 e  left
## 4   7  8 r right
## 5   9 10 t  left
## 6  11 12 y right
## 7  13 14 u  left
## 8  15 16 i right
## 9  17 18 o  left
## 10 19 20 p right
## 
## $c
##  [1]  1  3  5  7  9 11 13 15 17 19
## 
## $d
##  [1]  2  4  6  8 10 12 14 16 18 20
## 
## $e
## [1] 5
```

*`all`* is now a list of five different objects.  We can call parts of the list, and even values within the list using the same types of notation we tried earlier. 
Notice, we can use the assigned names for each object on the list, and the numerical notation to grab the data of interest.


```r
all$b
```

```
##     i  j k     m
## 1   1  2 q  left
## 2   3  4 w right
## 3   5  6 e  left
## 4   7  8 r right
## 5   9 10 t  left
## 6  11 12 y right
## 7  13 14 u  left
## 8  15 16 i right
## 9  17 18 o  left
## 10 19 20 p right
```

```r
all[[2]]
```

```
##     i  j k     m
## 1   1  2 q  left
## 2   3  4 w right
## 3   5  6 e  left
## 4   7  8 r right
## 5   9 10 t  left
## 6  11 12 y right
## 7  13 14 u  left
## 8  15 16 i right
## 9  17 18 o  left
## 10 19 20 p right
```

```r
all$b[3,3]
```

```
## [1] e
## Levels: e i o p q r t u w y
```

```r
all[[2]][3,3]
```

```
## [1] e
## Levels: e i o p q r t u w y
```


## Finally

The final thing we need to do in preparation for the workshop, is download the datafolder we have made available for you on GitHub.  You can find it by navigating to github.com and searching for 'ICMGP2019' or by clicking here: https://github.com/cgeger/ICMGP2019

You can now click on the "clone or download" button, and download a .zip file.  Make sure you save this into an accessible directory and not just your downloads folder.  See you soon in Krakow!
