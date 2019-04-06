# Coursera Data Science Specialization
# Tidying data with tidyr

## tidyr - data is formatted in a standard way that facilitates exploration and 
## analysis and works seamlessly with other tidy data tools.

## specifically, tidy data satisfies three conditions:
# 1) each variable forms a column
# 2) each observation forms a row
# 3) each type of observational unit forms a table

## the following are characteristics of messy data:
# 1: Column headers are values, not variable names
# 2: Variables are stored in both rows and columns
# 3: A single observational unit is stored in multiple tables
# 4: Multiple types of observational units are stored in the same table
# 5: Multiple variables are stored in one column

### first example of messy data

students

#   grade male female
# 1     A    1      5
# 2     B    5      0
# 3     C    5      2
# 4     D    5      5
# 5     E    7      4

## gather - takes multiple columns and collapses into key-value pairs, duplicating all 
## other columns as needed. You use gather() when you notice that you have columns that are not variables.

#### gather(students, sex, count, -grade)

#    grade    sex count
# 1      A   male     1
# 2      B   male     5
# 3      C   male     5
# 4      D   male     5
# 5      E   male     7
# 6      A female     5
# 7      B female     0
# 8      C female     2
# 9      D female     5
# 10     E female     4

### second messy data case

students2

#   grade male_1 female_1 male_2 female_2
# 1     A      3        4      3        4
# 2     B      6        4      3        5
# 3     C      7        4      3        8
# 4     D      4        0      8        1
# 5     E      1        1      2        7

#### res <- gather(students2, sex_class, count, - grade)
#### res

#    grade sex_class count
# 1      A    male_1     3
# 2      B    male_1     6
# 3      C    male_1     7
# 4      D    male_1     4
# 5      E    male_1     1
# 6      A  female_1     4
# 7      B  female_1     4
# 8      C  female_1     4
# 9      D  female_1     0
# 10     E  female_1     1
# 11     A    male_2     3
# 12     B    male_2     3
# 13     C    male_2     3
# 14     D    male_2     8	
# 15     E    male_2     2
# 16     A  female_2     4
# 17     B  female_2     5
# 18     C  female_2     8
# 19     D  female_2     1
# 20     E  female_2     7

## separate = Given either regular expression or a vector of character positions, 
## separate() turns a single character column into multiple columns.

#### separate(res, sex_class, c("sex", "class"))

#    grade    sex class count
# 1      A   male     1     3
# 2      B   male     1     6
# 3      C   male     1     7
# 4      D   male     1     4
# 5      E   male     1     1
# 6      A female     1     4
# 7      B female     1     4
# 8      C female     1     4
# 9      D female     1     0
# 10     E female     1     1
# 11     A   male     2     3
# 12     B   male     2     3
# 13     C   male     2     3
# 14     D   male     2     8
# 15     E   male     2     2
# 16     A female     2     4	
# 17     B female     2     5
# 18     C female     2     8
# 19     D female     2     1
# 20     E female     2     7

## putting it all together

students2 %>%
  
  gather(sex_class ,count ,-grade ) %>%
  
  separate(sex_class, c("sex", "class")) %>%
  
  print

#    grade    sex class count
# 1      A   male     1     3
# 2      B   male     1     6
# 3      C   male     1     7
# 4      D   male     1     4
# 5      E   male     1     1
# 6      A female     1     4
# 7      B female     1     4
# 8      C female     1     4
# 9      D female     1     0
# 10     E female     1     1
# 11     A   male     2     3
# 12     B   male     2     3
# 13     C   male     2     3
# 14     D   male     2     8
# 15     E   male     2     2
# 16     A female     2     4
# 17     B female     2     5
# 18     C female     2     8
# 19     D female     2     1
# 20     E female     2     7

### third messy data case

students3

#     name    test class1 class2 class3 class4 class5
# 1  Sally midterm      A   <NA>      B   <NA>   <NA>
# 2  Sally   final      C   <NA>      C   <NA>   <NA>
# 3   Jeff midterm   <NA>      D   <NA>      A   <NA>
# 4   Jeff   final   <NA>      E   <NA>      C   <NA>
# 5  Roger midterm   <NA>      C   <NA>   <NA>      B
# 6  Roger   final   <NA>      A   <NA>   <NA>      A
# 7  Karen midterm   <NA>   <NA>      C      A   <NA>
# 8  Karen   final   <NA>   <NA>      C      A   <NA>
# 9  Brian midterm      B   <NA>   <NA>   <NA>      A
# 10 Brian   final      B   <NA>   <NA>   <NA>      C

## putting it all together; in the example below the key is class and the value is grade

students3 %>%
  
  gather(class ,grade ,class1:class5 ,na.rm = TRUE) %>%
  
  print

#     name    test  class grade
# 1  Sally midterm class1     A
# 2  Sally   final class1     C
# 9  Brian midterm class1     B
# 10 Brian   final class1     B
# 13  Jeff midterm class2     D
# 14  Jeff   final class2     E
# 15 Roger midterm class2     C
# 16 Roger   final class2     A
# 21 Sally midterm class3     B
# 22 Sally   final class3     C
# 27 Karen midterm class3     C
# 28 Karen   final class3     C
# 33  Jeff midterm class4     A
# 34  Jeff   final class4     C
# 37 Karen midterm class4     A
# 38 Karen   final class4     A
# 45 Roger midterm class5     B
# 46 Roger   final class5     A
# 49 Brian midterm class5     A
# 50 Brian   final class5     C

## spread = a key-value pair across multiple columns.

## putting it all together

students3 %>%
  
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  
  spread(test, grade) %>%
  
  print

#     name  class final midterm
# 1  Brian class1     B       B
# 2  Brian class5     C       A
# 3   Jeff class2     E       D
# 4   Jeff class4     C       A
# 5  Karen class3     C       C
# 6  Karen class4     A       A
# 7  Roger class2     A       C
# 8  Roger class5     A       B
# 9  Sally class1     C       A
# 10 Sally class3     C       B

library(readr)

parse_number("class5")

#### [1] 5

## putting it all together!

students3 %>%
  
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  
  spread(test, grade) %>%
  
  mutate(class = parse_number(class)) %>%
  
  print

#     name class final midterm
# 1  Brian     1     B       B
# 2  Brian     5     C       A
# 3   Jeff     2     E       D
# 4   Jeff     4     C       A
# 5  Karen     3     C       C
# 6  Karen     4     A       A
# 7  Roger     2     A       C
# 8  Roger     5     A       B
# 9  Sally     1     C       A
# 10 Sally     3     C       B

### fourth example of messy data

students4

#     id  name sex class midterm final
# 1  168 Brian   F     1       B     B
# 2  168 Brian   F     5       A     C
# 3  588 Sally   M     1       A     C
# 4  588 Sally   M     3       B     C
# 5  710  Jeff   M     2       D     E
# 6  710  Jeff   M     4       A     C
# 7  731 Roger   F     2       C     A
# 8  731 Roger   F     5       B     A
# 9  908 Karen   M     3       C     C
# 10 908 Karen   M     4       A     A

## putting it all together

student_info <- students4 %>%
  
  select(id, name, sex) %>%
  
  print

#     id  name sex
# 1  168 Brian   F
# 2  168 Brian   F
# 3  588 Sally   M
# 4  588 Sally   M
# 5  710  Jeff   M
# 6  710  Jeff   M
# 7  731 Roger   F
# 8  731 Roger   F
# 9  908 Karen   M
# 10 908 Karen   M

student_info <- students4 %>%
  
  select(id, name, sex) %>%
  
  unique %>%
  
  print

#    id  name sex
# 1 168 Brian   F
# 3 588 Sally   M
# 5 710  Jeff   M
# 7 731 Roger   F
# 9 908 Karen   M

gradebook <- students4 %>%
  
  select(id, class, midterm, final) %>%
  
  print

#     id class midterm final
# 1  168     1       B     B
# 2  168     5       A     C
# 3  588     1       A     C
# 4  588     3       B     C
# 5  710     2       D     E
# 6  710     4       A     C
# 7  731     2       C     A
# 8  731     5       B     A
# 9  908     3       C     C
# 10 908     4       A     A

## the fifth example of messy data

passed

#    name class final
# 1 Brian     1     B
# 2 Roger     2     A
# 3 Roger     5     A
# 4 Karen     4     A

failed

#    name class final
# 1 Brian     5     C
# 2 Sally     1     C
# 3 Sally     3     C
# 4  Jeff     2     E
# 5  Jeff     4     C
# 6 Karen     3     C

passed <- passed %>% 
  
  mutate(status = "passed")

failed <- failed %>% 
  
  mutate(status = "failed")

## bind_rows() = This is an efficient implementation of the common pattern of do.call(rbind, dfs) 
## or do.call(cbind, dfs) for binding many data frames into one.

bind_rows(passed, failed)

#     name class final status
# 1  Brian     1     B passed
# 2  Roger     2     A passed
# 3  Roger     5     A passed
# 4  Karen     4     A passed
# 5  Brian     5     C failed
# 6  Sally     1     C failed
# 7  Sally     3     C failed
# 8   Jeff     2     E failed
# 9   Jeff     4     C failed
# 10 Karen     3     C failed

### reiterating tidy data
### Of course, we could arrange the rows however we wish at this point, but the important thing is that each row is an
### observation, each column is a variable, and the table contains a single observational unit. Thus, the data are tidy.

## putting it all together

sat

#   score_range read_male read_fem read_total math_male math_fem math_total write_male write_fem write_total
#   <chr>           <int>    <int>      <int>     <int>    <int>      <int>      <int>     <int>       <int>
# 1 700-800         40151    38898      79049     74461    46040     120501      31574     39101       70675
# 2 600-690        121950   126084     248034    162564   133954     296518     100963    125368      226331
# 3 500-590        227141   259553     486694    233141   257678     490819     202326    247239      449565
# 4 400-490        242554   296793     539347    204670   288696     493366     262623    302933      565556
# 5 300-390        113568   133473     247041     82468   131025     213493     146106    144381      290487
# 6 200-290         30728    29154      59882     18788    26562      45350      32500     24933       57433

sat %>%
  
  select(-contains("total")) %>%
  
  gather(part_sex, count, -score_range) %>%
  
  separate(part_sex, c("part", "sex")) %>%
  
  print

#### A tibble: 36 x 4

#    score_range part  sex    count
#    <chr>       <chr> <chr>  <int>
#  1 700-800     read  male   40151
#  2 600-690     read  male  121950
#  3 500-590     read  male  227141
#  4 400-490     read  male  242554
#  5 300-390     read  male  113568
#  6 200-290     read  male   30728
#  7 700-800     read  fem    38898
#  8 600-690     read  fem   126084
#  9 500-590     read  fem   259553
# 10 400-490     read  fem   296793
# ... with 26 more rows

## putting some more together

sat %>%
  
  select(-contains("total")) %>%
  
  gather(part_sex, count, -score_range) %>%
  
  separate(part_sex, c("part", "sex")) %>%
  
  group_by(part, sex) %>%
  
  mutate(total = sum(count), prop = count / total) %>% 
  
  print

#### A tibble: 36 x 6
#### Groups:   part, sex [6]

#    score_range part  sex    count  total   prop
#    <chr>       <chr> <chr>  <int>  <int>  <dbl>
# 1 700-800     read  male   40151 776092 0.0517
# 2 600-690     read  male  121950 776092 0.157 
# 3 500-590     read  male  227141 776092 0.293 
# 4 400-490     read  male  242554 776092 0.313 
# 5 300-390     read  male  113568 776092 0.146 
# 6 200-290     read  male   30728 776092 0.0396
# 7 700-800     read  fem    38898 883955 0.0440
# 8 600-690     read  fem   126084 883955 0.143 
# 9 500-590     read  fem   259553 883955 0.294 
#10 400-490     read  fem   296793 883955 0.336 
# ... with 26 more rows

# FINITOJOE