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
##    Lab 10: Factorial (2-way) ANOVA
##
################################################


## Welcome to Week 10 of Psych 1900 Section!
## This week we'll focus on two-way ANOVA.
## Two-way (aka 'factorial') ANOVA looks at the effect of two different predictors on a metric DV. 

# but first, let's load packages!
if (!require(pastecs)) {install.packages("pastecs"); require(pastecs)}
if (!require(car)) {install.packages("car"); require(car)}

# We'll be using the Beer Goggles dataset from your textbook (p.501).
# 'Beer Goggles' is a technical term that describes the general phenomenon of 'adjusted' standards 
# for mate selection that can occur when under the influence of alcohol. 
#
# Data was collected from the following study: 
# 3 groups of 16 participants were taken to a night club. Each group had 8 men and 8 women.
# Total sample size: n = 48 (24 male, 24 female)
# Each group was asked to consume a different amount of alcohol (0 drinks, 2 drinks, or 3 drinks). 
# Each subject was required to choose exactly 1 person to talk at the club. 
# At the end of the evening, a picture of each person who study participants chose to talk to 
# was taken and his/her attractiveness was rated by external judges on a scale from 0-100. 


## I. Factorial (2-way) ANOVA

#     1. Load the data into a variable called 'goggles'.
#         URL: http://www.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%2012/goggles.csv
#         Does this data have headers? Adjust your function arguments accordingly.
#         View your data. What are its dimensions?
#         Run the following two lines of code - just a bit of data cleanup and Americanization.
goggles <- read.csv('http://www.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%2012/goggles.csv',header=T)
            goggles$alcohol <- factor(goggles$alcohol, levels=c("None","2 Pints","4 Pints"))
            levels(goggles$alcohol) <- c("none","2 drinks","4 drinks")

dim(goggles) # 48 x 3


#     2. There are three main research questions we can ask of these data. What are they?
#         Hint: Main effects vs interactions.
#        Define null and alternative hypotheses for each question.

## Research questions:
## Does subject gender have an influence on the attractiveness of chosen date?
## Does amount of alcohol consumed have an influence on the attractiveness of chosen date?
## Do subject gender and amount of alcohol consumed have an interaction effect on attractiveness of chosen date?

# When conducting factorial ANOVA, it's much better to have a balanced design, ie. same # observations in each group.


#     3. Generate a table of observation frequencies across gender x alcohol. 
#         Hint: Check Section 7 for a table-making refresher.
#         Is the data balanced across cells? 

table(goggles$gender, goggles$alcohol)
## yes, balanced

# When we want descriptive statistics from cells in a table, we can't use split() as easily as we did before.
# split() really only helped us split one variable, which we split up based on another categorical variable.
# But here, we would like to know things like mean/median attractiveness of date choice, based on
# both gender AND alcohol variables. 
# In order to do this, we'll use the by() function.
#
# by() takes three main arguments, in this order:
#   1. what you want to split
#   2. what you want to split by
#   3. what you want to do with the data once you've split it
#
# The nice thing about by() is that we can specify more than one variable we want to split by!
# So, for example, we can look at mean date-attractiveness in each cell, split by gender and alcohol:

  by(goggles$attractiveness, list(goggles$gender, goggles$alcohol), mean)


#     4. Generate descriptive statistics and plots. Refer to Section 3 code for help with arguments.
#         - Find the median date-attractiveness by each cell (gender x alcohol). 
#         - Find the standard deviation of date-attractiveness by each cell.
#
#       Bonus (harder): There is another, more general way to select subsets of data.
#         For example, here is the mean rating for all ratings over 60 from females who had 2 drinks:
            x <- goggles[goggles$attractiveness > 60 & goggles$gender == 'Female' & goggles$alcohol == '2 drinks', 'attractiveness']
            mean(x)
#         Repeat your mean and standard deviation calculations using this method for subsetting data, 
#         but only for Male participants who consumed 2 drinks. Check that both methods' answers match.
#         Note: You don't need to make a separate variable (like 'x') for each subset, 
#               instead just wrap mean() directly around the subset code.

by(goggles$attractiveness, list(goggles$gender, goggles$alcohol), median)
by(goggles$attractiveness, list(goggles$gender, goggles$alcohol), sd)

mean(goggles[goggles$gender == 'Male' & goggles$alcohol == '2 drinks', 'attractiveness'])
sd(goggles[goggles$gender == 'Male' & goggles$alcohol == '2 drinks', 'attractiveness'])


#     5. Generate a boxplot with all cells displayed on the same plot.
#         (Refer to Section 3 code for help with arguments)
#         - Label the y-axis: 'Date Attractiveness' and x-axis: 'Gender x #Drinks'
#         - Label each cell group (ie. make a label for each box on the plot)
#           * Use the following input for the 'names' argument:
#               c('Female-0','Male-0','Female-2','Male-2','Female-4','Male-4')
#           * Orient the x-axis labels so that they read vertically (ie. 90 degrees to the axis)
#           * Use cex.axis to shrink the label text appropriately.

boxplot(goggles$attractiveness ~ goggles$gender + goggles$alcohol, 
        names=c('Female-0','Male-0','Female-2','Male-2','Female-4','Male-4'),
        las=2,
        xlab="Gender x #Drinks",
        ylab="Date Attractiveness",
        cex.axis = 0.6)


# The most useful part of factorial ANOVA is its ability to detect interactions.
# Interactions are hard to think about, but much easier to understand visually.
# (Interactions are visible when plot lines, quite literally, interact (ie. intersect).)
#
# We can use interaction.plot() for a much nicer display of interactions across gender and alcohol.
# There are a lot of arguments to this function, so we'll just give you the code here. 
# (Feel free to tweak it for your own use if you're doing 2-way ANOVA for your project.)

op <- par(mfrow = c(1,2))

# x-axis: gender, line color: alcohol
interaction.plot(goggles$gender, goggles$alcohol, goggles$attractiveness, 
                 ylab = "Attractiveness", xlab="Gender",
                 type = "b", pch = 19, lty = 1, 
                 col = c('slategray4','orange2','tomato1'),  legend = FALSE, cex.axis=0.8)  
legend("right", legend = c("None", "2 Drinks","4 Drinks"), col = c('slategray4','orange2','tomato1'), lty = 1, cex = 0.6)

# x-axis: alcohol, line-color: gender
interaction.plot(goggles$alcohol, goggles$gender, goggles$attractiveness, 
                 ylab = "Attractiveness", xlab="# Drinks Consumed",
                 type = "b", pch = 19, lty = 1, las=2,
                 col = c('turquoise3','violetred3'), legend = FALSE, cex.axis=0.6) 
legend("left", legend = c("female", "male"), col = c('turquoise3','violetred3'), lty = 1, cex = 0.6)
par(op)


#     6.  Does it look like alcohol and gender interact? 
#         How would you explain what you see in the interaction plots to a friend who doesn't know much about statistics?

## Yes, looks like it. In particular, men and women select similarly attractive dates at 0 and 2 drinks, but at 4 drinks,
## men select much less attractive dates. So, alcohol appears to have a different effect across gender at the 4-drinks level.


# Now we'll run a factorial (2-way) ANOVA to test whether what we see is significant.
# First let's check for variance homogeneity. We can still use the leveneTest() function, as we did with one-way ANOVA,
# but now we need to adjust it slightly:
  leveneTest(goggles$attractiveness, interaction(goggles$alcohol, goggles$gender))


#     7. Are the variances across cells significantly different from one another? How can you tell?


# To fit a factorial ANOVA model, we can use aov(), just like with one-way ANOVA.
# To indicate we want two IVs, along with their interaction term, use: IV1 * IV2 in your formula.
# You do not need to specify each IV separate from this term: just using the * notation will let R know that you want both
# IVs and their interaction to be considered as features in your ANOVA.


#     8.  Fit a factorial ANOVA, with DV: attractiveness, IVs: alcohol, gender (and their interaction). Save as 'gog.aov'.
#         Look at a summary of your results. 
#         Are the main effects significant? Is there a significant interaction effect? 
#
#         Bonus: One effect is not significant. Why not? How would you explain this to someone?

gog.aov <- aov(goggles$attractiveness ~ goggles$alcohol*goggles$gender)
summary(gog.aov)
names(gog.aov)

#     9.  Check for normality of residuals with QQ plot and SW test.
#           Hint: names(my.variable) prints out all of the variable names in the my.variable data frame
#         Are the residuals reasonably normal?

shapiro.test(gog.aov$residuals)  
qqnorm(gog.aov$residuals)
## yep, they look pretty normal.

#     10. What conclusions can you draw from this data? Do you reject or fail to reject your null hypotheses?
#         In factorial designs, do you think researchers are more interested in main effects or interactions? Why?


##  II. Further practice

#   Using the class survey data, pick 2 categorical variables (IVs) and 1 metric variable (DV) and perform a 2-way ANOVA.
#   Note: If you use Likert items as IVs it's better to re-categorize them into 2 or 3 categories,
#         in order to have enough observations in each cell. 


## There's an old saying: A journey of 1000 miles begins with a single step. 
## In my opinion, you have taken several big leaps in your coding and statistics knowledge this semester! 
## Your stat-fu is strong. 

## END SECTION 10