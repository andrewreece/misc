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
##    Lab 01: Introduction to R
##
############################################

## 1. Installing R and RStudio

#   R is a statistical software package.  It's free.  Download!
#
#       R download link: http://cran.r-project.org/

#   RStudio is a program that gives us a useful interface for working in R.  We'll be using it this semester.  It's free too!
#
#       RStudio download link: http://www.rstudio.com/products/rstudio/download/

#   Note: For each of these download links, there are a list of possible options for download, based on your computer's operating system.


## 2. Basics

# - Anytime you want to write a note to yourself in your code, like what I'm doing right now, you need to start the line with a #.
#     (Anything with a # in front is invisible to R. Otherwise, R will think you are giving it a command.)
#
# - When you want to enter a command to R, hit Control-Enter on PC, or Command-Enter on Mac.  That makes your code run.
#     Note: From now on, we'll use C-Enter to refer to this command.  It saves me typing.
#
# - R is a programming language.  That means you can store information in variables, with names of your choosing.
#
#     The syntax for creating a variable is:
#
#         your_variable_name <- some_value   
#
# - The <- thing is like an equals sign in R.  It's weird, but you'll get used to it.  
#
#   Here are some examples:

    a <- 3        # remember to hit C-Enter!
    b <- a + 2    # remember to hit C-Enter!

#   Nice, you just made two variables, a and b.  Here's what happened:
#
#     The first line makes a equal to the number 3.
#
#     The second line is a little tricker.  It makes b equal to whatever a is, plus 2.  
#     But R knows you just told it that a = 3.  So b = 3 + 2 = 5.
#
#   You'll see as we go on that you can use variables as building blocks like this.  R remembers all the variables you've created in a session.

# - If you want to see the output of a variable in your Console, just type its name and hit C-Enter.

    a   # C-Enter
    b   # C-Enter

#   Ok, I'm not going to write 'Hit C-Enter' anymore, just remember to do it.

# - R is case-sensitive.  Try entering these next two lines of code:

    a
    A

#   "Error: object 'A' not found", right?  
#   If it's easier for you, you can just always use lowercase variables.  A lot of programmers do.

#   If you set a as something else later on, then it's not equal to 3 anymore.  Try this:

    a + 2   
    a <- 4
    a + 2   

#   It's fine to do that, but it can be confusing to keep giving new values to the same variable.  Usually you don't need to do that.
#   You can make as many variables as you want, with any names that you want!  So make a new one whenever you have a new value to store.

    this_is_probably.theLongestAND.weirdest___Variable..nameIhAvE____evermade. <- TRUE
    
    this_is_probably.theLongestAND.weirdest___Variable..nameIhAvE____evermade.

#   Important note 1: Please don't make variables like that.  It was only a demonstration.  
#   Important note 2: You can use upper- and lower-case letters, _, ., and numbers in variable names.  Numbers can't begin a variable name.

#   See how I made that variable = TRUE?  Variables don't have to only store numbers.  
#   For now, we'll just focus on three types of information you can store in a variable:

    # 1. Numbers
      n.1 <- 12
      n.2 <- 12.01

    # 2. Strings ('String' in computer-speak just means words, letters, etc.)
      
      s.1 <- 'hello'          # you have to put strings in quotes.  
      s.2 <- "Spring Fling"   # single quotes or double quotes, doesn't matter.
      s.3 <- "12"             # if you put a number in quotes, it counts as a string.  you can't add it to other numbers.

    # 3. Booleans ('Boolean' is a ridiculous word which just means 'a value of TRUE or FALSE'. It sounds like 'BOO-lee-in'.)

      b.1 <- TRUE             # In R, Boolean values are written all in captial letters
      b.2 <- FALSE            # There are only two Boolean values: TRUE and FALSE


#   There are a few other data types, but we'll get to them later.

#   Remember, all this is just code that I've written.  It's in your code editor now, so you can play around with it. 
#   Try changing variable names, or outputting variables into the Console like we did earlier, or make up your own variables.


## 3. Calculation

#   R is like a calculator on steroids.  But you can use it for simple calculation, too.

#   You don't need to assign everything to a variable, you can just do math and it outputs in the Console.  
#   Enter each line of code below:

    4 + 3
    4 - 3
   -4 + 3
    4 * 3
    4 / 3
    4 ^ 3         # you can also use: 4 ** 3
    (4 + 3) * 4   # wrap inner operations with parentheses, just like in regular math

#   Now we'll mix in variables with calculation.  
#   Enter each line of code, but first try to predict ahead of time what will come out.

    x <- 5
    y <- 4
    x + y

    perfect <- 10
    x + perfect

    fail <- 0
    perfect * fail

    x <- fail
    perfect * x

    x <- y
    y <- perfect
    x + y

    z <- x + y
    z + x + y


## 4. Functions

#   Functions are little mini programs.  R has a ton of built-in functions.  You can roll your own, too, but we're not there yet.

#   Functions usually start with their name, and then a set of parentheses. 
#   Whatever values you put into the parentheses is information for the function to make use of.  These values are called function "arguments".

#   For example, print() is a function.  It just prints out whatever you put inside the (), onto the Console.  Try it!

    print("Psych 1900 is the bee's knees.")
    
    # now enter your own string into print.

    print()   # If you try to C-Enter without putting something inside, you'll get an error.

#   Another really useful function is c().  It just holds collections of things.  Like this:

    c(2, 4, 12)
    c(2, 4, "twelve")
    
#   Let's say we want the average (mean) of a collection of numbers.  We can use the mean() function, along with c().

    mean( c(2, 4, 12) )

#   Now we could have just done that by hand:

    (2 + 4 + 12) / 3

#   But especially when we are dealing with much more complicated data, functions are huge time savers.  We'll be using them a lot.


## 5. Packages

#   R is like playing with Legos: there's a basic set of functions that come pre-installed, but you can keep building with add-ons from there.
#   A 'package' is a collection of functions that builds on the pre-installed stuff.  There are a gazillion packages for R.

#   For example: Someone at Northwestern University made an R package called 'psych'.  (http://cran.r-project.org/web/packages/psych/psych.pdf)
#   This package has a bunch of functions that carry out statistical tests which come up frequently in psychological research.

#   R makes it super easy to install a new package.  All you need is the name of the package.  
#   Then you can use the install.packages() function:

    install.packages('psych')

#   BOOM. installed.

#   Now to be able to use it, you need the following line of code:

    require('psych')  

#   Now you can use any function from the psych package, just like you would a normal R function.  
#   We're not going to use the psych package right now - but you should at least get the idea of packages, and how they can add features to R.

#   If you're curious, there are a ton of packages here: http://cran.r-project.org/web/packages/
  
  
## 6. Where to get help

#   The most important function is help()! 
#   If there's a function you don't understand, type: help(name_of_the_function), or ?(name_of_the_function)
#   Help puts info into a tab called 'Help' on one of the RStudio panels (usually bottom right)

    help(mean)
    ?(mean)

#   Sometimes R help can seem a bit too technical.  If it's confusing, just google around, someone else was probably confused too.
#   For that matter, there are oodles of good R tutorials online.  Books, videos, blogs, you name it.  
#   It's easy to find help on just about anything in R.


#   END LAB 1

