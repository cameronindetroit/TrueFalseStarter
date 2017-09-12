//
//  QuestionProvider.swift
//  TrueFalseStarter
//
//  Created by admin on 9/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit


// Dictionary for quiz questions
var question1: [String: String] = [

    "Question": "Which English king was defeated at the Battle of Hastings?",
    "Answer1": "Harold II",
    "Answer2": " Henry VIII",
    "Answer3": " King John",
    "Answer4": "King Joefry",
    "CorrectAnswer": "Harold II"

//Answer is "Harold II"
    
]

var question2: [String: String] = [
    
    "Question": "Who is the only British prime minister to have been assassinated?",
    "Answer1": "William Pitt the Elder",
    "Answer2":  "Spencer Perceval",
    "Answer3":  "George Canning",
    "Answer4":  " John F. Kenedy",
    "CorrectAnswer": "Spencer Perceval"


    
//Answer is "Spencer Perceval" 
    
]

var question3: [String: String] = [
    
    "Question": " What was the occupation of William Shakespeare's father?",
    "Answer1": "Fuller",
    "Answer2": "Glover",
    "Answer3": "Bowyer",
    "Answer4": "Country Music Singer",
    "CorrectAnswer": "Glover"
    
//Answer is "Glover"
    
]

var question4: [String: String] = [
    
    "Question": "Charles Dickens's historical novel Barnaby Rudge is set during which historical event?",
    "Answer1": "The Gordon riots of 1780",
    "Answer2": "The Spitalfield riots of 1769",
    "Answer3": "The Sacheverell riots of 1710",
    "Answer4": "The Detroit Riots 1967",
    "CorrectAnswer": "The Gordon riots of 1780",


//Answer is "The Gordon riots of 1780"
    
]

// Array of quiz questions (Dictionary)
var questions: [[String: String]] = [question1,question2,question3,question4]




// Structure to hold questions
struct QuestionProvider {
    var trivia = [
    question1,
    question2,
    question3,
    question4
    ]
    
    
        
}



