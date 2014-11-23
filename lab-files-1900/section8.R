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
##    Lab 08: T-test and ANOVA
##
############################################


## Welcome to Week 8 of Psych 1900 Section!
## This week we'll work with two essential statistical methods for social scientists: t-test and ANOVA.

# First, let's install and load a few packages. 

if (!require(pastecs)) {install.packages("pastecs"); require(pastecs)}  ## utility functions descriptives           
if (!require(pgirmess)) {install.packages("pgirmess"); require(pgirmess)}   ## post hoc tools for Kruskal-Wallis 
if (!require(car)) {install.packages("car"); require(car)}   ## post hoc tools for Kruskal-Wallis 

library(foreign)

# You may get warnings about how these packages are not available. Ignore them.

# Note: Sometimes when loading a package, you will see the library() function used, other times you'll see require().
#       They're practically the same thing, you can use either one. 

##  I. Loading 'foreign' data

# So far, we've used .csv files or other raw data files (like .dat) to load our data. 
# Sometimes, you may be given a data file that was created using a different statistical software package. 
# R can read these files, too! It does so using the 'foreign' package, which we just loaded above.

# Remember that only the package name is 'foreign'. The package itself simply provides a number of functions 
# for our use. Once the package is loaded, all of its functions are available to us. 

# SPSS is a common statistical software package used in the social sciences. SPSS data files have extension '.sav'.  
# We can load SPSS data using read.spss(), a function from the foreign package.
# There are a couple of extra arguments we need for read.spss(). Use this code to load the data:

carblock <- read.spss("http://www.people.fas.harvard.edu/~mair/datasets/aggression.sav", 
                   to.data.frame = TRUE, use.value.labels = FALSE)

##  II. t-test & U-test

# This is a dataset you already saw in the lecture on t-tests. Here's a refresher:
#

# Background:
# Experimenters designed a study to measure how perceived status subtly influences people's tolerance for problems.
# The study design involved a car blocking an intersection. In some cases, experimenters used a BMW to block the
# intersection. The rest of the time, they used a Ford. Then they measured how often other drivers honked their
# horns at the car - this was the DV for the study.
# 
# Research question: 
#  Is there a difference in terms of honking frequency, based on whether it's a slick Bimmer or a frumpy Ford?

# This data was originally in German, so we'll Anglicize it:
colnames(carblock) <- c("car", "sex", "age", "frequency", "duration", "honk")
carblock[,1] <- factor(carblock[,1], labels = c("BMW", "Ford"))
carblock[,2] <- factor(carblock[,2], labels = c("male", "female"))

# split() is a bit like cut(), which we used last week. It splits up data based on some grouping which we define.
#
# Here, let's say we only want to look at the frequency of horn honks, which is the data column: carblock$frequency.
# But we'd also like to split up that data, based on what kind of car people were honking at (BMW vs. Ford), 
# which is denoted in the data column: carblock$car. 
#
# The split function takes two required arguments: the data you want to split, and the categories to split by.


#     1. Split honking frequency into a variable: honks. Split by car type.
#         - Use the 'frequency' variable, not the 'honk' variable, for honking frequency.
#         - Look at the honks data (don't use View(), just look at it in the console.)
#         - What is the mean value for Ford honks? For BMW honks?
#         - Look at the range of honk frequencies across all car types. 
#         - Do you predict these mean values are significantly different from each other? Explain your reasoning.
#         - Generate a null and alternative hypothesis for this analysis.


# Note: For some of the exercises below, it will be easier to use the splitted data, and for others the full
# dataframe will make more sense. Try to identify which data variable is most appropriate in each exercise.


#     2.  Generate descriptive visualizations of the data.
#         - make a box plot of honk frequency per car (both car types on one plot)
#         - make a histogram of honk frequency for each car (separate histogram for each car type)


#     3.  Use KS and SW tests to check for normality of honk frequency. 
#         (Run separate tests for each car type.)


# Now it's time to analyze our data. 
# We have two categories for our IV (car type), and a metric DV (honk frequency). This calls for a t-test!
# Use the t.test() function to compute a t-test. 
# t.test() takes two required arguments:
#   testing formula (eg. DV ~ IV )
#   data source (eg. data = my.data.frame)


#     4. Compute a t-test with IV: car type, DV: honk frequency.
#         - Save the output to a variable: honk.t
#         - Look at the contents of honk.t. Can you reject your null hypothesis?
#         - What is the 95% CI an interval of? Meaning, what do the numbers in the interval refer to?


# When data isn't perfectly normal, or if we are worried about other testing assumptions, we can use a
# non-parametric version of the t-test instead, called the U-test. (Formally, 'Mann-Whitney U-test'.)
# Think of the U-test like the Spearman's rho of t-tests. You use it when data aren't quite normal.
# Use wilcox.test() to compute a U-test. It takes the same inputs as t.test().


#     5. Compute a U-test with IV: car type, DV: honk frequency.
#         - Save the output to a variable: honk.u
#         - Look at the contents of honk.t. Does this analysis come to the same conclusion as the t-test?


# Note: t-tests are pretty robust to violations of normalcy. This means they often still give accurate 
# answers, even when data aren't well-behaved. If you want to be absolutely safe, go with U-test, but it
# often isn't necessary to take the non-parametric route for this kind of test.

##  III. ANOVA

# ANOVA (ANalysis Of VAriance) is used when we have a categorical IV with 3+ categories, and a metric DV.

# We'll use the same dataset you saw during the lecture on ANOVA, from Wright & London (2009).
# This study looked at the phenomenon of cognitive dissonance, which is the idea that people will convince
# themselves that they actually feel good about doing something unpleasant, under the right conditions.
#
# For example, if someone accepts a very small amount of money to do something boring, 
# then that person (on average), will convince themselves that they actually found the job quite interesting 
# (because why else would they have done something so boring for so little money?)
#
# In this study, subjects were randomly assigned to one of three experimental conditions:
#   - A control group, which received no money to do a boring task
#   - A 'low pay' group, which received $1 to do a boring task
#   - A 'high pay' group, which received $20 to do a boring task 
# After the task, subjects rated their enjoyment of the task on a scale from -5 (least enjoyable) to 5 (most enjoyable)

# We'll reassemble the data from this study by hand.
# Execute the next few lines of code, up until it says: STOP HERE

# START HERE

control1 <- c(0, -3, 3, 2, -2, -1, 2, 3, -3, -5, 2, -3, 3, 0, -2, -2, -2, -2, -1, 2)
dollar1 <- c(3, 1, 1, 3, 2, 3, 3, 2, 2, 2, 2, 2, -4, 4, 0, -3, 4, 1, 1, -2)
dollar20 <- c(1, 2, 3, 0, 1, 3, 0, -2, 2, 1, 0, 0, -1, -2, -1, -4, -3, -1, 0, 0)
enjoy <- c(control1, dollar1, dollar20)                         
group <- as.factor(rep(c("control", "one.dollar", "twenty.dollar"), each = 20))   
cog.dis <- data.frame(enjoy, group)

# STOP HERE


#     6. Look at the 'cog.dis' variable. 
#         - Make a table of the values in the group column. Are the groups balanced in size of observations?


#     7. Split up the enjoyment ratings by experimental group. Put the split data into a variable: groups.
#         - What is the mean enjoyment score for each group?

#     8. Make a box plot showing enjoyment scores for each group.


#     9. What is a reasonable research question you might ask of this data?
#         - Generate a testable null and alternative hypothesis.

# Before we run our ANOVA, we need to check whether our data fits the assumptions made by the test.

#     10. Check ANOVA assumptions.
#         1. Metric DV
#           - Is our DV really metric? Justify your answer. 
#         2. Independence of observations within and across factors.
#           - What in the study description above tells you whether or observations are independent?
#         3. Normality of variables.
#           - Use descriptive visualizations and tests to assess normality of variables.
#           - What did you find? Which tests did you use?
#         4. Appropriate sample size.
#           - Do we have enough observations in each group? Justify your answer.
#         5. Homogeneity of variance (homoskedasticity)
#           - Test using: leveneTest(cog.dis$enjoy ~ cog.dis$group)
#           - Do variances differ across groups?
#
#     Bonus: Homoskedasticity is a crazy word. It's easy to skip over it because it looks like it
#            is just a bunch of letters randomly put together. But it's important for ANOVA, so let's
#            think about what it's testing.  Why is homogeneity of variance important for ANOVA?
#            (Hint: Think between vs within.)
#
#     Bonus: Draw a picture of three normally distributed variables that have the same means, 
#            but different variances. 


# The data are close enough to matching assumptions so that we can proceed with ANOVA.

# Use the aov() function to compute ANOVA. 
# aov() takes one required argument: DV ~ IV.


#     11. Compute an ANOVA to test your hypothesis.
#         - Save the output in a variable: cog.dis.aov.
#         - Run a summary of cog.dis.aov. Can we reject the null hypothesis?
#
#         Bonus: Robert Ableson, a famous psychologist, once said: 
#                "ANOVA is like playing the guitar wearing fuzzy mittens". 
#                What did he mean by that?


# If Levene's test is significant, we can run a Welch's test (Analysis of Means) instead:
cog.dis.aov2 <- oneway.test(cog.dis$enjoy ~ cog.dis$group)
cog.dis.aov2

# Post-hoc tests give us pairwise comparisons between each of the variables in an ANOVA.
# This lets us see which of the pairs, if any, is driving the overall significant effect.
# Use pairwise.t.test() to run post-hoc tests. pairwise.t.test() takes two arguments: DV, IV.


#     12. Run a post-hoc test for the variables in our ANOVA.
#         Which pairwise comparison is largely responsible for the significant difference between groups?


# If our data have outliers, or if there are serious violations of assumptions, we can run a 
# non-parametric version of ANOVA (just like U-test instead of t-test).
# This is called the 'Kruskal-Wallis ANOVA'.
#
# Use kruskal.test() to run Kruskal-Wallis ANOVA. 
# kruskal.test() takes one argument: DV ~ IV

cog.dis.krus <- kruskal.test(cog.dis$enjoy ~ cog.dis$group)  

# We see again that there is a significant difference between then groups
cog.dis.krus                  

# Use kruskalmc() to run post-hoc tests for Kruskal-Wallis ANOVA:
kruskalmc(enjoy ~ group)       


# I really must say, you are becoming quite advanced in your psychology stat-fu! 
# Congratualtions on a job well done.  
#
# What are you thinking of doing for your final project?


#     13. Further Practice
#         - use the class survey data for the following exercises.
#         - pick a categorical variable (2 categories, you may re-categorize a Likert response) 
#           and a metric DV (e.g. a sum score from the scales at the end) and perform a t-test or U-test, 
#           depending on whether the assumptions are fulfilled or not.
#
#         - pick a categorical variable (3 or more categories) and a corresponding metric DV 
#           and do a ANOVA (F-test) or Kruskal-Wallis ANOVA, depending on adherence of data to assumptions. 
#         - perform post hoc tests to evaluate pairwise influence.


## END SECTION 8
