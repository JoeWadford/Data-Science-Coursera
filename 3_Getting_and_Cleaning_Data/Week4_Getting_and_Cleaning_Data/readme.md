# Coursera Data Science Specialization
# Editing Text Variables

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

	# [1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location.1" 

#### lower the case of the variable names
### fixing character vectors - tolower(), toupper()

tolower(names(cameraData))

	# [1] "address"      "direction"    "street"       "crossstreet"  "intersection" "location.1" 

### fixing character vectors - strsplit()
#### good for automatically splitting variable names
#### important parameters: x, split

splitNames = strsplit(names(cameraData), "\\.")
splitNames[5]

	# [1] "intersection"

splitNames[[6]]

	# [1] "Location" "1"  

mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)

	# $letters
	# [1] "A" "b" "c"

	# $numbers
	# [1] 1 2 3

	# [[3]]
	#      [,1] [,2] [,3] [,4] [,5]
	# [1,]    1    6   11   16   21
	# [2,]    2    7   12   17   22
	# [3,]    3    8   13   18   23
	# [4,]    4    9   14   19   24
	# [5,]    5   10   15   20   25

#### subset

mylist[1]

	# $letters
	# [1] "A" "b" "c"

#### sub-subset

mylist$letters
	# [1] "A" "b" "c"

mylist[[1]]
	# [1] "A" "b" "c"

### Fixing character vectors - sapply()
#### Applies a function to each element in a vector or list
#### Important parameters: X,FUN

splitNames[[6]][1]

	# [1] "Location"

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

	# [1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location" 

#### loading the Peer Review Experiment Data

fileURL1 = "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/reviews.csv"
fileURL2 = "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/solutions.csv"
download.file(fileURL1,destfile="./data/reviews.csv",method="curl")
download.file(fileURL2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)

	#   id solution_id reviewer_id      start       stop time_left accept
	# 1  1           3          27 1304095698 1304095758      1754      1
	# 2  2           4          22 1304095188 1304095206      2306      1

head(solutions, 2)

	#   id problem_id subject_id      start       stop time_left answer
	# 1  1        156         29 1304095119 1304095169      2343      B
	# 2  2        269         25 1304095119 1304095183      2329      C

#### Fixing character vectors - sub()
#### Important parameters: pattern, replacement, x
#### Important parameters: pattern, replacement, x
#### sub only replaces the first occurrence of the pattern specified, whereas gsub does it for all occurrences

names(reviews)

	# [1] "id"          "solution_id" "reviewer_id" "start"       "stop"        "time_left"   "accept"   

sub("_","",names(reviews),)

	# [1] "id"         "solutionid" "reviewerid" "start"      "stop"       "timeleft"   "accept" 

testName <- "this_is_a_test"
sub("_","",testName)

	# [1] "thisis_a_test"

#### Fixing character vectors - gsub()
#### sub only replaces the first occurrence of the pattern specified, whereas gsub does it for all occurrences

gsub("_","",testName)

	# [1] "thisisatest"

#### Finding values - grep(),grepl()
#### search for matches to argument pattern within each element of a character vector: 
#### they differ in the format of and amount of detail in the results.

grep("Alameda",cameraData$intersection)

	# [1]  4  5 36

table(grepl("Alameda",cameraData$intersection))

	# FALSE  TRUE 
	#    77     3 

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]
grep("Alameda",cameraData$intersection,value=TRUE)

	# [1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"    "Harford \n & The Alameda"

grep("JeffStreet",cameraData$intersection)

	# integer(0)

length(grep("JeffStreet",cameraData$intersection))

	# [1] 0

#### More useful string functions

library(stringr)
nchar("Jeffrey Leek")

	# [1] 12

substr("Jeffrey Leek",1,7)

	# [1] "Jeffrey"

paste("Jeffrey","Leek")

	# [1] "Jeffrey Leek"

paste0("Jeffrey","Leek")

	# [1] "JeffreyLeek"

str_trim("Jeff      ")

	# [1] "Jeff"

### Important points about text in data sets

#### Names of variables should be

	# All lower case when possible
	# Descriptive (Diagnosis versus Dx)
	# Not duplicated
	# Not have underscores or dots or white spaces

#### Variables with character values
	
	# Should usually be made into factor variables (depends on application)
	# Should be descriptive (use TRUE/FALSE instead of 0/1 and Male/Female versus 0/1 or M/F)

## Regular Expressions 1

### Regular expressions can be thought of as a combination of literals and metacharacters
#### To draw an analogy with natural language, think of literal text forming the words of this language, and the metacharacters defining its grammar
#### Regular expressions have a rich set of metacharacters

### Literals
#### Simplest pattern consists only of literals. The literal “nuclear” would match to the following lines:

	# Ooh. I just learned that to keep myself alive after a
	# nuclear blast! All I have to do is milk some rats
	# then drink the milk. Aweosme. :}

	# Laozi says nuclear weapons are mas macho

	# Chaos in a country that has nuclear weapons -- not good.

	# my nephew is trying to teach me nuclear physics, or
	# possibly just trying to show me how smart he is
	# so I’ll be proud of him [which I am].

	# lol if you ever say "nuclear" people immediately think
	# DEATH by radiation LOL

#### The literal “Obama” would match to the following lines

	# Politics r dum. Not 2 long ago Clinton was sayin Obama
	# was crap n now she sez vote 4 him n unite? WTF?
	# Screw em both + Mcain. Go Ron Paul!

	# Clinton conceeds to Obama but will her followers listen??

	# Are we sure Chelsea didn’t vote for Obama?

	# thinking ... Michelle Obama is terrific!

	# jetlag..no sleep...early mornig to starbux..Ms. Obama
	# was moving

### Regular Expressions

#### Simplest pattern consists only of literals; a match occurs if the sequence of literals occurs anywhere in the text being tested
#### What if we only want the word “Obama”? or sentences that end in the word “Clinton”, or “clinton” or “clinto”?

#### We need a way to express

	# whitespace word boundaries
	# sets of literals
	# the beginning and end of a line
	# alternatives (“war” or “peace”) Metacharacters to the rescue!

### Metacharacters
#### Some metacharacters represent the start of a line

	# ^i think

#### will match the lines

	# i think we all rule for participating
	# i think i have been outed
	# i think this will be quite fun actually
	# i think i need to go to work
	# i think i first saw zombo in 1999.

#### $ represents the end of a line

	# morning$

#### will match the lines

	# well they had something this morning
	# then had to catch a tram home in the morning
	# dog obedience school in the morning
	# and yes happy birthday i forgot to say it earlier this morning
	# I walked in the rain this morning
	# good morning

### Character Classes with []
#### We can list a set of characters we will accept at a given point in the match

	# [Bb][Uu][Ss][Hh]

#### will match the lines

	# The democrats are playing, "Name the worst thing about Bush!"
	# I smelled the desert creosote bush, brownies, BBQ chicken
	# BBQ and bushwalking at Molonglo Gorge
	# Bush TOLD you that North Korea is part of the Axis of Evil
	# I’m listening to Bush - Hurricane (Album Version)

	# ^[Ii] am

#### will match

	# i am so angry at my boyfriend i can’t even bear to
	# look at him

	# i am boycotting the apple store

	# I am twittering from iPhone

	# I am a very vengeful person when you ruin my sweetheart.

	# I am so over this. I need food. Mmmm bacon...

#### Similarly, you can specify a range of letters [a-z] or [a-zA-Z]; notice that the order doesn’t matter

	# ^[0-9][a-zA-Z]

#### will match the lines

	# 7th inning stretch
	# 2nd half soon to begin. OSU did just win something
	# 3am - cant sleep - too hot still.. :(
	# 5ft 7 sent from heaven
	# 1st sign of starvagtion

#### When used at the beginning of a character class, the “” is also a metacharacter and 
#### indicates matching characters NOT in the indicated class

	# [^?.]$

#### will match the lines

	# i like basketballs
	# 6 and 9
	# dont worry... we all die anyway!
	# Not in Baghdad
	# helicopter under water? hmmm

## Regular Expression 2

### More metacharacters

#### “.” is used to refer to any character. So

	# 9.11

#### will match the lines

	# its stupid the post 9-11 rules
	# if any 1 of us did 9/11 we would have been caught in days.
	# NetBios: scanning ip 203.169.114.66
	# Front Door 9:11:46 AM
	# Sings: 0118999881999119725...3 !

#### | This does not mean “pipe” in the context of regular expressions; instead it translates to “or”; 
#### we can use it to combine two expressions, the subexpressions being called alternatives

	# flood|fire

#### will match the lines

	# is firewire like usb on none macs?
	# the global flood makes sense within the context of the bible
	# yeah ive had the fire on tonight
	# ... and the floods, hurricanes, killer heatwaves, rednecks, gun nuts, etc.

#### We can include any number of alternatives...

	# flood|earthquake|hurricane|coldfire

#### will match the lines

	# Not a whole lot of hurricanes in the Arctic.
	# We do have earthquakes nearly every day somewhere in our State
	# hurricanes swirl in the other direction
	# coldfire is STRAIGHT!
	# ’cause we keep getting earthquakes

#### The alternatives can be real expressions and not just literals

	# ^[Gg]ood|[Bb]ad

#### will match the lines

	# good to hear some good knews from someone here
	# Good afternoon fellow american infidels!
	# good on you-what do you drive?
	# Katie... guess they had bad experiences...
	# my middle name is trouble, Miss Bad News

#### Subexpressions are often contained in parentheses to constrain the alternatives

	# ^([Gg]ood|[Bb]ad)

#### will match the lines

	# bad habbit
	# bad coordination today
	# good, becuase there is nothing worse than a man in kinky underwear
	# Badcop, its because people want to use drugs
	# Good Monday Holiday
	# Good riddance to Limey

#### The question mark indicates that the indicated expression is optional

	# [Gg]eorge( [Ww]\.)? [Bb]ush

#### we wanted to match a “.” as a literal period; to do that, we had to “escape” the metacharacter, 
#### preceding it with a backslash In general, we have to do this for any metacharacter we want to include in our match
#### will match the lines

	# i bet i can spell better than you and george bush combined
	# BBC reported that President George W. Bush claimed God told him to invade I
	# a bird in the hand is worth two george bushes

#### The * and + signs are metacharacters used to indicate repetition; * means “any number, including none, of the item” and + means “at least one of the item”

	# (.*)

#### will match the lines

	# anyone wanna chat? (24, m, germany)
	# hello, 20.m here... ( east area + drives + webcam )
	# (he means older men)
	# ()

	# [0-9]+ (.*)[0-9]+

#### will match the lines

	# working as MP here 720 MP battallion, 42nd birgade
	# so say 2 or 3 years at colleage and 4 at uni makes us 23 when and if we fin
	# it went down on several occasions for like, 3 or 4 *days*
	# Mmmm its time 4 me 2 go 2 bed

#### { and } are referred to as interval quantifiers; the let us specify the minimum and maximum number of matches of an expression

	# [Bb]ush( +[^ ]+ +){1,5} debate

#### will match the lines

	# Bush has historically won all major debates he’s done.
	# in my view, Bush doesn’t need these debates..
	# bush doesn’t need the debates? maybe you are right
	# That’s what Bush supporters are doing about the debate.
	# Felix, I don’t disagree that Bush was poorly prepared for the debate.
	# indeed, but still, Bush should have taken the debate more seriously.
	# Keep repeating that Bush smirked and scowled during the debate

