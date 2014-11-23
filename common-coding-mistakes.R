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

################################################
##
##    Extra Material: Common Coding Errors
##
################################################

## This is guide to some of the most common coding errors you may encounter, and which came up most
## frequently during section exercises over the course of the semester. 
## Note that these are R coding errors, not statistical errors! Those you'll have to work out on your own.
##
## The most time-consuming part of coding is often debugging - finding that one missing semicolon,
## or noticing a lowercase letter when there should be an uppercase one. If you're getting errors
## in your code and you're not sure what's going wrong, start by checking for these simple mistakes.


#   1.  Capitalize consistently.
#
#       Capitalization matters in R. my.var is not the same variable as My.var!
#       Most functions in R use only lowercase letters. (View() is one exception.)


#   2.  Spell-check.
#
#       This may seem obvious, but it's important to spell functions, arguments, and variables correctly.
#       At least 1 in 3 errors I saw in section this semester were caused by spelling mistakes.


#   3.  Assign function output to a variable.
#
#       If you want to load a dataset with read.csv(), remember to store it in a variable so you can refer to it later.
#       Eg.   my.data <- read.csv('dataset.csv')
#       If you just execute read.csv() without storing the output, the output will display on your console, but then
#       you won't be able to refer to it again, unless you re-run read.csv().


#   4.  Variable names are not strings.
#
#       CORRECT:     my.var  <- "this is a string."
#       INCORRECT:  "my.var" <- "this is a string."


#   5a.  Function argument names are not strings.
#       
#       Think of function arguments as little mini-variables inside a function. Just as you wouldn't put quotes
#       around a variable, so you don't put quotes around argument names either. 
#       CORRECT:    read.csv("dataset.csv",  header=TRUE)
#       INCORRECT:  read.csv("dataset.csv", "header"=TRUE)
#
#       As we often leave out argument names for common functions, it may seem as if the argument values are 
#       argument names instead, which can be a point of confusion.
#       For instance, in the above example, "dataset.csv" is actually the argument value for the argument: file. 
#       We could more formally write: read.csv(file="dataset.csv", header=TRUE)
#       We leave out the argument name: file , but that doesn't mean that "dataset.csv" is now the argument name.
#       It is still an argument value, and therefore can be put in quotes.

#   5b. Not all argument values are strings.
#       
#       Argument values can be numbers, booleans, or even other functions! Just because it's an argument value, 
#       it doesn't mean that value should always be in quotes. Quote are only for strings. If you think carefully
#       about what kind of data you need to give as an argument value, these kind of errors are easy to avoid.


#   6.  Check to see if your data has headers.
#
#       If so, use the argument: header = TRUE when loading data via read.csv() or read.table().
#       You can check to see if headers loaded correctly with head() or View() - just look at the first row
#       in your data. Is it data or is it headers? If it's headers, go back and re-load the data with header = TRUE.


#   7.  Load packages before calling special functions.
#
#       Some functions - leveneTest(), for example - are not basic R functions. They are loaded via packages.
#       If you are conducting an analysis which requires a function from a package, make sure to load that package
#       before calling the function, using library() (eg. library(my.special.package)). If you're not sure which
#       package to load, try Googling '<function_name> which R package'. If you're still not sure, just find the
#       section code file which uses that function, and load all the packages used in that file.


#   8.  Separate function arguments with commas.
#
#       CORRECT:    read.csv("dataset.csv", header = TRUE)
#       INCORRECT:  read.csv("dataset.csv"  header = TRUE)


#   9.  Pay attention to warnings vs errors.
#
#       If you run a line of code and R returns a console message "Error", then your code is broken and will not run.
#       If R returns a console message "Warning", it usually means that something about your *data*, not your code,
#       looks a little funny to R, and it is alerting you to this fact. Read the warning messages - sometimes you
#       can ignore them, but other times they are giving useful information about some error you have in the way
#       you have set up your data. If you're not sure whether you can ignore a warning, just ask! 
#       (As a rule, you can ignore most warnings.)


#   10. Close functions with an end parenthesis: ). (And don't close them too early.)
#
#       This can be especially hard to catch when arguments inside your function have parentheses themselves, and
#       it can look like you have closed your function when in fact you've just closed an argument value.
#       You can check to see if your function was closed properly by looking in the console. 
#       If you were expecting some kind of output, check to see if it's there. 
#       If you weren't expecting output (say, you were just storing some function output in a variable), 
#       check to see whether the bottom console line starts with a > prompt or a + prompt. 
#       If >, you're fine. 
#       If +, it means you didn't close your function (and R is waiting for you to close it). 
#       If you try and enter another command when your console prompt is +, it won't work. 
#       To fix this, click on the console text and hit Esc. This should return the prompt to a >.


## If you can successfully follow these guidelines, you will have save a lot of time chasing code bugs.
## I guarantee it! Good luck and happy coding!

