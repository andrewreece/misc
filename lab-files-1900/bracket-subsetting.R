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

##################################################
##
##    Extra Material: Methods for Subsetting Data
##
##################################################

# In this course, we learn to access variables within data frames using $ notation.
# But we would be remiss if we didn't give you at least an introduction to other ways of 
# creating subsets in data. What follows is a series of short exercises to show you a bit
# about how subsetting works, without (necessarily) using $ notation.


## I. Bracket notation for data frames

# Let's make a practice data frame to work with:

df <- data.frame( num=c(1:7),
                  letter=c("A","B","C","D","E","F","G"),
                  dwarf=c("sleepy","happy","grumpy","dopey","bashful","sneezy","doc"),
                 stringsAsFactors=FALSE)
# Have a look:
df

# If we want to get just the list of dwarves, we have learned to do this:
df$dwarf

# But imagine if we wanted only the dwarves with associated numbers under 4 - how would we select them?
#
# We learned about cut() and split(), but as we have seen - especially in Section 10 code - they don't 
# work perfectly in every situation.
#
# Fortunately, R has a general method for pulling out subsets of data which are denoted
# by specific conditions, such as "number of dwarf is < 4". 
# We call this bracket notation for data frames.
#
# Think of a data frame as its own sort of function, which takes two arguments: 
#  Argument 1: what should the rows look like? (row rules)
#  Argument 2: what should the columns look like? (column names)

# The syntax is slightly different from a normal function, but the basic idea is the same. 
# With data frames, we can enter our row and column arguments inside square brackets, like this:
# df[ here_are_rules_for_rows , here_are_rules_for_columns ]

# For example, we can mimic standard $ notation by leaving row-rules blank, and typing the name of our
# desired variable (in quotes, as a string) in the column-rules part. 
# To get only the 'letter' variable out of df, type:

  df[ , 'letter' ]

# Compare this with $ notation:

  df$letter

# Conversely, we can get one row of data by entering desired row # in row-rules, and leaving column-rules blank:
# To retrieve only the third row of data, use:

  df[ 3 , ]

# Reminder: 'df' is just what we have named our toy variable in this example. 
# As usual, you may name a variable whatever you like. 

# It follows that if we only want the 'letter' value in row #3, we can do this:

  df[ 3 , 'letter' ]

# You can also refer to the column by its number, in order from left-to-right.
# The 'letter' variable is the second column from the left, and so we can alternately use:

  df[ 3 , 2 ]

# Note: Rows are rarely named like columns are, but if you had names you could call rows 
# with their string names also, eg.: df[ 'row-name', 'col-name' ]. 


## II. Boolean subsets

# With this new approach, we can be very specific about which parts of our data frame we'd like to subset.
# We usually make our subset selection rules in the rows argument.
# So, in our example, our row-filtering rule is "value in the 'num' column must be less than 4".
#
# Let's take a moment to recall what we know about Boolean values.
# A Boolean value is a TRUE/FALSE value that describes the truth-state of an expression. 
# So, for example, run the following lines of code:

  1 < 2   # evaluates to TRUE

  1 > 2   # evaluates to FALSE

# We can also make Boolean comparisons for a collection of values. 

  c(1,2,3) < 2  # evaluates to TRUE FALSE FALSE
  
# I think that is kind of cool. Albeit in a nerdy way.


## III. Combining brackets and booleans

# Now let's consider our example. Our 'num' variable in df contains the interger values 1-7.
# We can ask R to compare each value in that entire variable against a number - say against the number 4:

  # First, let's use our new subsetting technique to get just the 'num' variable values:
  df[ , 'num' ]       # evaluates to 1 2 3 4 5 6 7

  # Now, compare that expression against 4:
  df[ , 'num' ] < 4   # evaluates to TRUE TRUE TRUE FALSE FALSE FALSE

# This is very useful for our goal! 
# (Remember, we want the subset of dwarf names with corresponding numbers less than 4.)

# Now we have all the tools we need to pull out our desired subset:

  df[ df[ , "num" ] < 4 , 'dwarf' ]   # evalutes to "sleepy" "happy" "grumpy"

# It seems a bit self-referential, to call df inside df. But that's how to do it.

# Note: We also could have used the fact that 'dwarf' is the third column:

  df[ df[ , "num" ] < 4 , 3 ]

# Personally I find it's worth a bit of extra typing to have the column name spelled out,
# otherwise it's easy to forget which number relates to which column (especially with lots of columns).

# It's also common to mix $ notation and full bracket subset notation, like this:

  df[ df$num < 4, 'dwarf' ]

# That's the basic idea to bracket subsetting in R! 
# It's a much more powerful and general technique than simple $ notation. 
# Usually, we use $ notation for quick referencing, and brackets for a more complicated subsetting of data. 


##  III. Tips & Tricks to bracket subsetting

# Here are a few final pointers to bracket subsetting:

# 1.  Spacing doesn't matter inside brackets. 
#     I made everything widely separated in the examples, but only for clarity of reading. 
#     All of the following return the same thing:

      df[ df$num < 4, 'dwarf' ]
      df[df$num<4,'dwarf']
      df[       df$num <             4,'dwarf' ]


# 2. You can create as many row-rules as you like in the same subset. 
#     Just use & to combine separate rules, and use | (vertical pipe character, on the backslash key) 
#     to make 'OR' statements (like This rule OR That rule). 
#     Remember to use == instead of = when writing Boolean equalities.
#     For example:

      df[ df$num < 4 & df$letter == 'B', 'dwarf' ] # num rule AND letter rule

      df[ df$num < 0 | df$letter == 'F', 'dwarf'] # num rule OR letter rule 

      # note: there is no case where num < 0 here, so we go with letter == 'F'
      # watch what happens if we change that | to &:

      df[ df$num < 0 & df$letter == 'F', 'dwarf'] # character(0) means there wasn't anything to return!

      # also note the double-equal thing:

      1 == 1 # evaluates to TRUE
      1 = 1  # grumpy R.


# 3. You can call as many columns as you like in the same subset. Use c() function!

      df[ , 'dwarf' ]
      df[ , c('letter','dwarf') ]
      df[ df$num < 4 , c('letter','dwarf') ]
      df[ df$num < 4 & df$letter == 'B' , c('letter','dwarf') ]


# 4. You can also use bracket notation to subset a specific variable:

  # Eg. Get all values in 'num' less than 4:
  df$num[ df$num < 4 ]


# May these techniques help your R mastery grow greater and greater! Good luck on your final project.

## END Methods for Subsetting Data ##