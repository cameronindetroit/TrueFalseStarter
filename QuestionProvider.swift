//
//  QuestionProvider.swift
//  TrueFalseStarter
//
//  Created by admin on 9/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit
///////////////////////////////////////////////////////////////////////
//////////////////////////Quiz Questions /////////////////////////
//////////////////////////////////////////////////////////////////////



// Structure to hold questions
struct QuestionStructure {
    
    var question: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    var correctAnswer:String
    
    
}

//Quiz questions with answers and correct answer

let question1 = QuestionStructure(question: "Which English king was defeated at the Battle of Hastings?", answer1: "Harold II", answer2: "Henry VIII", answer3: "King John", answer4: "King Joefry", correctAnswer: "Harold II")

let question2 = QuestionStructure(question: "Who is the only British prime minister to have been assassinated?", answer1: "William Pitt the Elder", answer2: "Spencer Perceval", answer3: "George Canning", answer4: " John F. Kenedy", correctAnswer: "Spencer Perceval")

let question3 = QuestionStructure(question: " What was the occupation of William Shakespeare's father?", answer1: "Fuller", answer2: "Glover", answer3: "Bowyer", answer4: "Country Music Singer", correctAnswer: "Glover")

let question4 = QuestionStructure(question: "Charles Dickens's historical novel Barnaby Rudge is set during which historical event?", answer1: "The Gordon riots of 1780", answer2: "The Spitalfield riots of 1769", answer3: "The Sacheverell riots of 1710", answer4: "The Detroit Riots 1967", correctAnswer: "The Gordon riots of 1780")


//Array to hold all quiz questions 

let quizQestions = [ question1, question2, question3, question4]
    
        



