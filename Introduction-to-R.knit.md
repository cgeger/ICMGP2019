---
title: "Introduction to R"
author: "Geoffrey Millard"
date: "August 7, 2019"
output: html_document
---


# An Introduction to R
## Congratulations on deciding to use R!

R is a really cool software package that provides a language and environment for statistical and mathematical computing.  It is an open source software (free!) that can be run on UNIX, Windows and iOS computers with generally the same syntax across all platforms.  If you want an example of the cool things you can do using R/RStudio, look no further than this html file.  It has been entirely generated using R/RStudio.  You can download R from http://www.r-project.org and the popular Graphical User Interface (GUI) RStudio at https://www.rstudio.com.  For the purposes of the ICMGP2019 workshop, please take the time to download **BOTH** R and RStudio.  We will be using RStudio for the workshop which requires you to also download and install R.

This introduction is desgined to help you get started with the software package.  It will cover some very basic tasks that will come in handy during the workshop.  **Please take the time to go through this introduction before the workshop begins**

## Lets get started!

Once you open RStudio, you will be presented with a screen similar to this:

<div class="figure">
<img src="C:/Users/gmill/Dropbox/Conference workshops/ICMGP2019/guide_images/startup_screen_1.png" alt="Figure 1: This is what RStudio looks like when you start it up." width="1920" height="1080" />
<p class="caption">Figure 1: This is what RStudio looks like when you start it up.</p>
</div>

You should see three (or four) panels depending on if you have used RStudio before.  On the left is the Console, which is the main computational window with the <span style="     color: blue !important;" >&gt;</span> underneath some R versioning information.  The console is where your commands tell R what to compute, but we do not want to work in this window.

In order to have a clear record of our work, we want to open a script.  We can do this with the keyboard shortcut ctrl+shift+N, or by clicking *File -> New File -> R Script.*  You should now have a new script window above your console

<div class="figure">
<img src="C:/Users/gmill/Dropbox/Conference workshops/ICMGP2019/guide_images/startup_screen.png" alt="Figure 2: This is what you want RStudio to look like." width="1920" height="1080" />
<p class="caption">Figure 2: This is what you want RStudio to look like.</p>
</div>

If you have used RStudio before, you might actually have started with some script windows already open.  The other two screens that RStudio presents contain helpful information as we code which I will explain as we go.  **Running the code in our script is very easy, simply click the line of code you want to run and press ctrl+enter (or press ctrl+enter when you finish typing a line of code).** This will transfer that line of script to the console and perform the designated function.

You may also want to "soft wrap" your code so that your script doesn't type off the side of the screen.  You can do that by clicking *Tools -> Global Options* and then in the Code table select the *soft wrap R Source files* box.

<div class="figure">
<img src="C:/Users/gmill/Dropbox/Conference workshops/ICMGP2019/guide_images/softwrap_dialogue.png" alt="Figure 3: I find soft-wraping your code incredibly useful." width="1920" height="1080" />
<p class="caption">Figure 3: I find soft-wraping your code incredibly useful.</p>
</div>

The final thing we want to do before jumping into some code is to set the working directory.  The simplest way to do this is in the toolbar clicking *Session -> Set Working Directory -> Set Directory,* or by using the keyboard shortcut ctrl+shift+H and navigating to your desired directory (eg. C:/Users/gmill/Dropbox/Conference workshops/ICMGP2019/). Should then see in the console the command <span style="     color: blue !important;" >C:/Users/gmill/Dropbox/Conference workshops/ICMGP2019</span>, which you can copy and paste into your script.

## Lets Get Started!

... with some terminology.  The types of data we will work with most often in RStudio are constants, vectors and data frames.  A constant is a variable set to a single number.  A vector is a "one dimensional" set of values or a collection of constants.  Similarly a data frame is a collection of vectors.

Lets start by making a constant.  


```r
x <- 3
```

Note that after we run this line of code `x` appears in our Environment (top right) with the value 3.

Now if we run:


```r
x <- 5
x
```

```
## [1] 5
```

we have reassigned the value of `x` and printed `x` in the console.  the `[1]` indicates that 5 is the first value of x.

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

We could also put in a sequence of numbers or text.


```r
# We can collect a group of numbers or characters
i <- c(1, 3, 5, 7, 9, 11, 13, 15, 17, 19)
l <- c('q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p')

# input a sequence of numbers
j <- seq(2, 20, 2)

# or a repeating set of factors
k <- rep(c('left', 'right'), 5)
```

If you notice, these three vectors all have a length of ten, while `x` has a length of one.  Additionally, `#` tells R that the following line is a comment, and not actually a line of code (very useful for documenting your work!!!)


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

This means we can actually turn them into a dataframe!  The `str()` function gives us some additional information about the data frame


```r
df <- data.frame(i, j, k)
df
```

```
##     i  j     k
## 1   1  2  left
## 2   3  4 right
## 3   5  6  left
## 4   7  8 right
## 5   9 10  left
## 6  11 12 right
## 7  13 14  left
## 8  15 16 right
## 9  17 18  left
## 10 19 20 right
```

```r
str(df)
```

```
## 'data.frame':	10 obs. of  3 variables:
##  $ i: num  1 3 5 7 9 11 13 15 17 19
##  $ j: num  2 4 6 8 10 12 14 16 18 20
##  $ k: Factor w/ 2 levels "left","right": 1 2 1 2 1 2 1 2 1 2
```

we can see that both `i` and `j` are numerical data and that `k` is a factor.

We can also create column names for the data, either as we make the dataframe or afterwards as a separate step.


```r
df1 <- data.frame('odd'=i, 'even'=j, 'hand'=k, 'letters'=l)
```

We can use those column names to specify the data we want to use, or use [], or a combination of the two


```r
df1$odd # specifies the entire "odd" column
```

```
##  [1]  1  3  5  7  9 11 13 15 17 19
```

```r
df1[2,1] # specifies the second value of the first column
```

```
## [1] 3
```

```r
df1$odd[2] # specifies the second value of the "odd" column
```

```
## [1] 3
```

Notice that the last two accomplish the same thing.  They each return the second value of the *df1$odd*, or first column

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
##     i  j     k
## 1   1  2  left
## 2   3  4 right
## 3   5  6  left
## 4   7  8 right
## 5   9 10  left
## 6  11 12 right
## 7  13 14  left
## 8  15 16 right
## 9  17 18  left
## 10 19 20 right
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

*all* is now a list of five different objects.  We can call parts of the list, and even values within the list using the same types of notation we tried earlier.


```r
all$b
```

```
##     i  j     k
## 1   1  2  left
## 2   3  4 right
## 3   5  6  left
## 4   7  8 right
## 5   9 10  left
## 6  11 12 right
## 7  13 14  left
## 8  15 16 right
## 9  17 18  left
## 10 19 20 right
```

```r
all[[2]]
```

```
##     i  j     k
## 1   1  2  left
## 2   3  4 right
## 3   5  6  left
## 4   7  8 right
## 5   9 10  left
## 6  11 12 right
## 7  13 14  left
## 8  15 16 right
## 9  17 18  left
## 10 19 20 right
```

```r
all$b[3,3]
```

```
## [1] left
## Levels: left right
```

```r
all[[2]][3,3]
```

```
## [1] left
## Levels: left right
```

Notice, we can use the assigned names for each object on the list, and the numerical notation to grab the data of interest.

## Finally

The final thing we need to do in preparation for the workshop, is download the datafolder we have made available for you on GitHub.  You can find it by navigating to github.com and searching for 'ICMGP2019.'

This should present you with a single hit for the repository 'cgeger/ICMGP2019.'  You can now click on the "clone or download" button, and download a .zip file.  Make sure you save this into an accessible directory and not just your downloads folder!  See you on a couple weeks!
