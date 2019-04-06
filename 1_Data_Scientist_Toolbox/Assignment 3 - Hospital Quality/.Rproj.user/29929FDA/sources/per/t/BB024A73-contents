# "best" function takes State and outcomes ("heart attack", "heart failure", 
# or "pneumonia"). and returns hospital with 
# the lowest mortality rate for that outcome in that state.

best <- function(state, outcome, num=best){
        
        #--Input testing:
        outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        possible_state <- (unique(outcome_data$State) == state)
        possible_outcome <- (c("heart attack", "heart failure", "pneumonia") == outcome)
        
        if(sum(possible_state) != 1){
                stop(print("invalid state"))
        } else if(sum(possible_outcome) != 1){
                stop(print("invalid outcome"))
        } else {
                
                #-- Creates State subset
                state_filter <- outcome_data[outcome_data$State == state,]
                
                state_filter[state_filter == "Not Available" ] = NA
                #Turns "Not Availible" string into NA
                
                state_subset <- data.frame(as.character(state_filter$Hospital.Name), 
                                           as.character(state_filter$State),
                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),
                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),
                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
                
                colnames(state_subset) <- c("Hospital.Name", "State", "heart_attack", "heart_failure", "pneumonia")
                
                rm(state_filter)
                
                #-- Conditional Min and lookup
                if(outcome == "heart attack") {
                        min_outcome <- min(state_subset$heart_attack, na.rm = TRUE)
                        lookup_row <- which(state_subset$State == state 
                                            & state_subset$heart_attack == min_outcome 
                                            & complete.cases(state_subset$heart_attack) == T)
                        lookup_col <- which(colnames(state_subset)=="Hospital.Name")
                        best_hospitals <- sort(as.vector(state_subset[lookup_row,lookup_col]))
                        
                } else if (outcome == "heart failure") {
                        min_outcome <- min(state_subset$heart_failure, na.rm = TRUE)
                        lookup_row <- which(state_subset$State == state 
                                            & state_subset$heart_failure == min_outcome 
                                            & complete.cases(state_subset$heart_failure) == T)
                        lookup_col <- which(colnames(state_subset)=="Hospital.Name")
                        best_hospitals <- sort(as.vector(state_subset[lookup_row,lookup_col]))
                        
                } else if (outcome == "pneumonia"){
                        min_outcome <- min(state_subset$pneumonia, na.rm = TRUE)
                        lookup_row <- which(state_subset$State == state 
                                            & state_subset$pneumonia == min_outcome 
                                            & complete.cases(state_subset$pneumonia) == T)
                        lookup_col <- which(colnames(state_subset)=="Hospital.Name")
                        best_hospitals <- sort(as.vector(state_subset[lookup_row,lookup_col]))
                        
                } else {
                        stop(print("Not valid input for outcome."))
                }
                
                #Gives 1 of best hospital based on name order
                print(best_hospitals[1])
        }
}


# "rankhospital" function takes State, outcomes ("heart attack", "heart failure", 
# or "pneumonia"), and rank, and returns hospital with 
# the lowest mortality rate for that outcome in that state for that rank.

rankhospital <- function(state, outcome, num = "best") {
        
        #--Input testing on state and outcome:
        possible_state <- (unique(outcome_data$State) == state)
        possible_outcome <- (c("heart attack", "heart failure", "pneumonia") == outcome)
        
        if(sum(possible_state) != 1){
                stop(print("invalid state"))
        } else if(sum(possible_outcome) != 1){
                stop(print("invalid outcome"))
        } else {
                
                #-- Creates State subset
                state_filter <- outcome_data[outcome_data$State == state,]
                
                state_filter[state_filter == "Not Available" ] = NA
                #Turns "Not Availible" string into NA
                
                state_subset <- data.frame(as.character(state_filter$Hospital.Name), 
                                           as.character(state_filter$State),
                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),
                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),
                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
                
                colnames(state_subset) <- c("Hospital.Name", "State", "heart_attack", "heart_failure", "pneumonia")
                
                rm(state_filter)
                
                #-- Conditional outcome columns
                if(outcome == "heart attack"){ 
                        outcome_col = 3
                } else if (outcome == "heart failure"){
                        outcome_col = 4
                } else if (outcome == "pneumonia"){
                        outcome_col = 5
                } else {
                        stop(print("Not valid input for outcome."))
                }
                
                #--Ranking identifier: 
                n <- as.numeric(sum(complete.cases(state_subset[,outcome_col])))
                best_outcome <- min(state_subset[,outcome_col], na.rm = TRUE)
                worst_outcome <- max(state_subset[,outcome_col], na.rm = TRUE)
                
                if(num == "best") { 
                        Nth_score <- best_outcome
                } else if(num == "worst") {
                        Nth_score <- worst_outcome
                } else if(num >= 1 & num <= n) {
                        Nth_score <- (sort(state_subset[,outcome_col], partial=(n-(n-num)))[n-(n-num)])
                } else if(num < 0 | num > n) {
                        return("NA")
                } else {
                        stop(print("Invalid input for num"))
                }
                
                sort(state_subset$Hospital.Name, decreasing = TRUE)
                lookup_row <- which(state_subset$State == state 
                                    & state_subset[,outcome_col] == Nth_score 
                                    & complete.cases(state_subset[,outcome_col]) == T)
                lookup_col <- as.numeric(which(colnames(state_subset)=="Hospital.Name"))
                Nth_best <- as.vector(state_subset[lookup_row,lookup_col])
                
                countof_Nth_best <- as.numeric(length(Nth_best))
                
                if(countof_Nth_best == 1){
                        print(Nth_best)
                } else if (countof_Nth_best > 1){    
                        #-- Breaks ties
                        top_Nth_filter <- state_subset[state_subset[,outcome_col] <= Nth_score & complete.cases(state_subset[,outcome_col]) == T,]
                        top_Nth <- data.frame(as.character(top_Nth_filter$Hospital.Name), 
                                              as.character(top_Nth_filter$State), 
                                              as.numeric(top_Nth_filter$heart_attack),
                                              as.numeric(top_Nth_filter$heart_failure),
                                              as.numeric(top_Nth_filter$pneumonia))
                        colnames(top_Nth) <- c("Hospital.Name", "State", "heart_attack", "heart_failure", "pneumonia")
                        rm(top_Nth_filter)
                        
                        outcome_col_name <- names(top_Nth)[outcome_col]
                        hospital_col_name <- names(top_Nth)[1]
                        with_order <- with(top_Nth, order(top_Nth[outcome_col_name], top_Nth[hospital_col_name]))
                        top_Nth_ordered <- top_Nth[with_order, ]
                        print(as.vector(top_Nth_ordered[num,1]))  
                } else {
                        stop(print("No Hospitals Qualify"))
                }
        }
}

# "rankall" function takes outcomes ("heart attack", "heart failure", 
# or "pneumonia"), and rank, and returns hospital with 
# the lowest mortality rate for that outcome per state.

rankall <- function(outcome, num = "best") {
        
        state <- as.vector(unique(outcome_data$State))
        
        hospital <- vector(mode ="character")
        
        for (i in seq_along(state)){
                rankhospital <- function(state, outcome, num = "best") {
                        
                        #--Input testing on state and outcome:
                        possible_state <- (unique(outcome_data$State) == state)
                        possible_outcome <- (c("heart attack", "heart failure", "pneumonia") == outcome)
                        
                        if(sum(possible_state) != 1){
                                stop(print("invalid state"))
                        } else if(sum(possible_outcome) != 1){
                                stop(print("invalid outcome"))
                        } else {
                                
                                #-- Creates State subset
                                state_filter <- outcome_data[outcome_data$State == state,]
                                
                                state_filter[state_filter == "Not Available" ] = NA
                                #Turns "Not Availible" string into NA
                                
                                state_subset <- data.frame(as.character(state_filter$Hospital.Name), 
                                                           as.character(state_filter$State),
                                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),
                                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),
                                                           as.numeric(state_filter$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
                                
                                colnames(state_subset) <- c("Hospital.Name", "State", "heart_attack", "heart_failure", "pneumonia")
                                
                                rm(state_filter)
                                
                                #-- Conditional outcome columns
                                if(outcome == "heart attack"){ 
                                        outcome_col = 3
                                } else if (outcome == "heart failure"){
                                        outcome_col = 4
                                } else if (outcome == "pneumonia"){
                                        outcome_col = 5
                                } else {
                                        stop(print("Not valid input for outcome."))
                                }
                                
                                #--Ranking identifier:    
                                n <- as.numeric(sum(complete.cases(state_subset[,outcome_col])))
                                best_outcome <- min(state_subset[,outcome_col], na.rm = TRUE)
                                worst_outcome <- max(state_subset[,outcome_col], na.rm = TRUE)
                                
                                if(num == "best") { 
                                        Nth_score <- best_outcome
                                } else if(num == "worst") {
                                        Nth_score <- worst_outcome
                                } else if(num >= 1 & num <= n) {
                                        Nth_score <- (sort(state_subset[,outcome_col], partial=(n-(n-num)))[n-(n-num)])
                                } else if(num < 0 | num > n) {
                                        return("NA")
                                } else {
                                        return("NA")
                                }
                                
                                
                                sort(state_subset$Hospital.Name, decreasing = TRUE)
                                lookup_row <- which(state_subset$State == state 
                                                    & state_subset[,outcome_col] == Nth_score 
                                                    & complete.cases(state_subset[,outcome_col]) == T)
                                lookup_col <- as.numeric(which(colnames(state_subset)=="Hospital.Name"))
                                Nth_best <- as.vector(state_subset[lookup_row,lookup_col])
                                
                                countof_Nth_best <- as.numeric(length(Nth_best))
                                
                                if(countof_Nth_best == 1){
                                        print(Nth_best)
                                } else if (countof_Nth_best > 1){    
                                        #-- Breaks ties
                                        top_Nth_filter <- state_subset[state_subset[,outcome_col] <= Nth_score & complete.cases(state_subset[,outcome_col]) == T,]
                                        top_Nth <- data.frame(as.character(top_Nth_filter$Hospital.Name), 
                                                              as.character(top_Nth_filter$State), 
                                                              as.numeric(top_Nth_filter$heart_attack),
                                                              as.numeric(top_Nth_filter$heart_failure),
                                                              as.numeric(top_Nth_filter$pneumonia))
                                        colnames(top_Nth) <- c("Hospital.Name", "State", "heart_attack", "heart_failure", "pneumonia")
                                        rm(top_Nth_filter)
                                        
                                        outcome_col_name <- names(top_Nth)[outcome_col]
                                        hospital_col_name <- names(top_Nth)[1]
                                        with_order <- with(top_Nth, order(top_Nth[outcome_col_name], top_Nth[hospital_col_name]))
                                        top_Nth_ordered <- top_Nth[with_order, ]
                                        as.vector(top_Nth_ordered[num,1])  
                                } else {
                                        stop(print("No Hospitals Qualify"))
                                }
                        }
                }
                
                hospital[i] <- rankhospital(state[i], outcome, num)
        }
        
        Nth_best <- data.frame(hospital, state)
        print(Nth_best)
}
