################################################################################
##
##    Psychology 1900
##    Introduction to Statistics for the Behavioral Sciences
##
##    Semester: Fall 2014
##    Course Instructor: Patrick Mair          <  mair@fas.harvard.edu   >
##    Teaching Fellows:  Marie-Christine Nizzi <  mnizzi@fas.harvard.edu >
##                       Andrew Reece          <  reece@g.harvard.edu    >
##
################################################################################

############################################
##
##    Lab 02: - More on functions
##            - Importing datasets 
##            - Location & dispersion methods
##            - Basic plots
##
############################################


## Welcome to Week 2 of Psych 1900 Section!


### 1. Functions & Arguments

# Today we'll look more at functions, and specifically, function *arguments*.
# Arguments are the pieces of information you send to a function for processing.

# Remember our math example: f(x) = x + 2.  
# This is a function called 'f', and it takes the value of 'x' as a piece of information to process.
# The process it puts x through is simply adding 2 to it.  So the output of the function f() is just: <input> + 2 (ie. x + 2)

# Functions in R work the same way.  They all have a name, like 'f' - remember 'c' from last week? 
# The 'mean' function from last week is another example.  

# After the name of the function, there's always a pair of parentheses - eg. c()
# Function arguments go inside the parentheses, and arguments are separated from one another by commas.
# 
#   eg. c( 1, 2, 3 ) has three arguments (the numbers 1, 2, and 3)

# The number of arguments that a function takes as input can change quite a bit from function to function.  

# For example, c() can take as many arguments as you want to put in it.  Do you remember what c() does?
# On the other hand, mean() only takes one main argument - the collection of numbers you want it to average.

# In order to know which arguments you need to give to a function, you can use the ? or help() command.  help() is a function too!

# Try this:

?mean     # you can also use: help(mean)

# Now look at the help window - you'll see a description of the function, and also a description of all the arguments it can take.  

# In the 'Usage' section, it will tell you which arguments you absolutely have to specify.  
# In this case, it's just one - the collection of numbers you want to take the mean of.

# But in the 'Arguments' section you can also see that there's more than just the 'x' argument.  There's 'trim', 'na.rm', and '...'.  
# These are optional arguments - you don't have to use them.  If you want to know more about what all the arguments do, 
# read the Arguments and Value sections on any function help page. 

# :: Note ::  Optional arguments are optional because they have default values already set, which means that if you don't define them 
#             in your function call, they will automatically use the defaults - these default values are set so that they won't 
#             interfere with what you're doing.  
#             If you do need to change these values, you can specify optional argument values when you call the function.
#
#             We'll see a case of when you might want to change optional arguments in a bit.

# Let's do some hands-on work with function arguments.  First, enter the code below.
# You don't need to understand it - it's just getting things set up for our examples below.

# Highlight everything until you see '## STOP HERE ##', then C-Enter 
# Note: Your console may do some funny things when you run this code - don't worry about it.

## START HIGHLIGHT HERE ##

install.packages('RCurl')
library(RCurl)

guessMyName <- function( first, last, year = 0, ignore.case = TRUE) {
  
  data <- getURL( "http://www.people.fas.harvard.edu/~reece/1900/roster.csv" )
  df <- read.csv( text = data, stringsAsFactors = FALSE )

  for ( row in 1:nrow(df) ) {
    
      first.guess <- grep( paste0( "^", first ), df$first.name[row], ignore.case=ignore.case, value=TRUE )
      last.guess <-  grep( paste0( "^", last  ), df$last.name[row],  ignore.case=ignore.case, value=TRUE )
      first.name.found <- length(first.guess) > 0
      last.name.found <- length(last.guess) > 0
      year.found <- ifelse(year > 0, year == df$year[row], TRUE)
      
      if ( first.name.found & last.name.found & year.found ) {   
        guess <- paste0("I think your name is ",first.guess," ",last.guess,".")
        break     
      } else {
        guess <- "I don't have any idea what your name is. Sorry!"  
      }
  }
  return( guess )
}

## STOP HERE ## (now hit C-Enter)

# Ok, now we have a function called guessMyName(). I wrote it just for our class, so you can't look it up in help(), sadly.
# We'll just have to figure out what it does!

# Here is how the function call looks:

#       guessMyName( first, last, year = 0, ignore.case = TRUE) 


### begin groupwork ###
#
# 1. How many arguments are there in this function?  
#
# 2. What kind of information do you think each argument is providing to the function?  
#
# 3. For each argument, what kind of datatype do you think it should have (eg. string, integer, boolean)?
#   (For a refresher on datatypes, see section 3.) in the code file from the first lab.)
#
# 4. Execute each of the following lines of code.  Some may give errors.  Each variation tells you a different thing about how
#    function arguments work. What is the takeaway you've learned from each variation?

#   :: Note ::  Feel free to use any of your actual names instead of the example name. If you're a grad student, use year = 5.
#               (In the example, "John Harvard" is registered as a graduate student.)

guess.0 <- guessMyName( first = "John", last = "Harvard", year = 0, ignore.case = TRUE)
guess.0

guess.1 <- guessMyName( first = "John", last = "Harvard", year = 5, ignore.case = TRUE)
guess.1

guess.2 <- guessMyName( first = "John", last = "Harvard", year = 4, ignore.case = TRUE)
guess.2

guess.3 <- guessMyName( first = "Joh", last = "Harv", year = 5, ignore.case = TRUE)
guess.3

guess.4 <- guessMyName( first = "J", last = "H", year = 5, ignore.case = TRUE)
guess.4

guess.5 <- guessMyName( "J", "H", 5, TRUE)
guess.5

guess.6 <- guessMyName( "H", "J", TRUE, 5)
guess.6

guess.7 <- guessMyName( last = "H", first = "J", ignore.case = TRUE, year = 5)
guess.7

guess.8 <- guessMyName( first = "J", last = "H" )
guess.8

guess.9 <- guessMyName( "j", "h", ignore.case = FALSE)
guess.9

guess.10 <- guessMyName( "John" )
guess.10

### end groupwork ###



### 2. Importing Data

# We will use a dataset from the Field book. You can find all Field datasets here:
# "http://www.sagepub.com/dsur/study/articles.htm"

# To import data, we need to know what format our data is in (text, Excel, SPSS...)
# For now we will use only data you can import with the command: read.table()
# Let's try to import the folowwing data:

album <- read.table("http://www.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%207/Album%20Sales%202.dat")
# We notice that the data has been added in our index (top right corner)
# Now let's explore our data by calling it

album                       ## We can visualize the data in the console. 
head(album)                 ## Command to check 5 first line for big data sets

# Check the first line! What is wrong?

# we need to tell R that the first line (header) contains the variable names 
# We do that by specifying the corresponding argument: we set the 'header' parameter equal to TRUE

album <- read.table("http://www.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%207/Album%20Sales%202.dat",
                    header = TRUE)  
head(album)

# That looks better! You have imported your first data set! 
# Now let's say you want to focus on the data from 'sales'
# How do we get access to this single column in the data?

sales             ## We can try calling it by the variable's name: what is the problem?
album$sales       ## R uses the '$' sign as a way to get at variables nested inside other variables, like we have here.

attach(album)     ## Here is a way to make variable names are directly accessible
sales             ## Let's test it. 
# Now if you work with several data sets, remember to 'detach' when you are done with one set.

# With our data imported and the variable of interest selected, we can do:
mean(sales)
median(sales)
sd(sales)

summary(sales)   ## Interesting command: gives a good quick overview

## Now an exercize: compute quantiles with the quantile() function
# Find the arguments needed by the specific function
# exercise 1: compute the 23% quantile
# exercise 2: compute the 5% and the 95% quantile in 1 step



### 3. Plots

## We will learn cool visualizations next week but here is a quick preview
# Let's say you want to see the distribution of your sales.
# You can use the hist() function

?hist             ## look at the arguments yourself     

hist(sales, main = "Album Sales")
hist(sales, main = "Album Sales", breaks = 15)

## Form groups of 2 or 3 and create your own sales histogram by changing one argument!

detach(album)     ## remember to detach when you are done working with a data set
sales             ## unknown again



### 4. Assigned Reading

## Read Chapter 3 of the Fields book (skip section 3.6) for next week

## chapter is available on course website, reading section
## note that you need to log in to view the chapter

## here is the link to the database used in the chapter:
# http://www.sagepub.com/dsur/study/articles.htm


## See you next week!