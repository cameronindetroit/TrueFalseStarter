//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Enhanced by Cameron Barnes 9/12/17.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox



class ViewController: UIViewController {
    
    
    //////////////////////////////////////////////
    /////////////////Set App Variables////////////////
    /////////////////////////////////////////////
    
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 0
    var wrongAnswerSound: SystemSoundID = 0
    
    //Array to hold previously asked questions
    var previousQuestionsArray: [Int] = []
    

    //decleration of UIButtons and Label
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    
    
    //////////////////////////////////////////////
    /////////////////Timer Setup////////////////
    /////////////////////////////////////////////
    
    
    //Timer
    
    var lightningTimer = Timer()
    var seconds = 15
    var timerRunning = false
    
    //TimerMethods 
    
    func beginTimer() {
        if timerRunning == false {
            lightningTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.CountdownTimer), userInfo: nil, repeats: true)
            timerRunning = true
        }
    }
    
    //Countdown Timer 
    
    func CountdownTimer(){
        //countdown by 1 second
        seconds -= 1
        timerLabel.text = "Seconds Remaining: \(seconds)"
    
        if seconds == 0 {
            loadWrongAnswerSound()
            playWrongAnswerSound()
            lightningTimer.invalidate()
            questionsAsked += 1
            questionField.text = "Sorry, out of time!"
            
            loadNextRoundWithDelay(seconds: 4)
        }
        
    }
    
    //Reset Timer 
    
    func resetTimer() {
        seconds = 15
        timerLabel.text = "Seconds Remaining: \(seconds)"
        timerRunning = false
    }
    
    
    //////////////////////////////////////////////
    /////////////////Start Quiz ////////////////
    /////////////////////////////////////////////
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        
        // Start game
        playGameStartSound()
        
        //Display first question
         newQuestion()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    //////////////////////////////////////////////
    /////////////////New Question////////////////
    /////////////////////////////////////////////
    
    
    //New Question
    func newQuestion() {
        
        // Generate new question from Question Provider Model
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        
        
        
        //Loop to check for repeated questions
        while previousQuestionsArray.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        }
        
        // Add new question to previous question array
        previousQuestionsArray.append(indexOfSelectedQuestion)
        print(previousQuestionsArray)
        
        
        // Set new answer button titles based on new question
        let quizQuestions = questions[indexOfSelectedQuestion]
        questionField.text = quizQuestions["Question"]
        firstAnswerButton.setTitle(quizQuestions["Answer1"], for: UIControlState.normal)
        secondAnswerButton.setTitle(quizQuestions["Answer2"], for: UIControlState.normal)
        thirdAnswerButton.setTitle(quizQuestions["Answer3"], for: UIControlState.normal)
        fourthAnswerButton.setTitle(quizQuestions["Answer4"], for: UIControlState.normal)
        playAgainButton.isHidden = true
        
        
        resetTimer()
        beginTimer()
    }

    
    
    
    //////////////////////////////////////////////
    /////////////////Check Answer ///////////////
    /////////////////////////////////////////////
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        // Set values for both question and the correct answer
        let selectedQuestion = questions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestion["CorrectAnswer"]
        
        // Question and Answer Comparison checker
        if (sender === firstAnswerButton && selectedQuestion["Answer1"] == correctAnswer) || (sender === secondAnswerButton && selectedQuestion["Answer2"] == correctAnswer) || (sender === thirdAnswerButton && selectedQuestion["Answer3"] == correctAnswer) || (sender === fourthAnswerButton && selectedQuestion["Answer4"] == correctAnswer) {
            
            //Play correct answer audio
            loadCorrectAnswerSound()
            playCorrectAnswerSound()
            
            // increase correct answer counter by 1
            correctQuestions += 1
            
            // set text field to 'Correct'
            questionField.text = "Correct!"
            
            
            //Stop Timer 
            lightningTimer.invalidate()
            
        } else {
            
            //Play wrong Answer sound
            loadWrongAnswerSound()
            playWrongAnswerSound()
            
            // set text field to 'Wrong'
            questionField.text = "\("Sorry, the correct answer is ")\(" ")\(correctAnswer!)"
            
            //Stop Timer
            lightningTimer.invalidate()
        }
        
       
        //Next round function with '4' second delay
        loadNextRoundWithDelay(seconds: 4)
    }
    
    
    //////////////////////////////////////////////
    ///////////Display Score ////////////////////
    /////////////////////////////////////////////
    
    
    func displayScore() {
        // Hide the answer buttons
        firstAnswerButton.isHidden = true
        secondAnswerButton.isHidden = true
        thirdAnswerButton.isHidden = true
        fourthAnswerButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        // Display high good score
        if correctQuestions > 2 {
            questionField.text = "Way to go! You got \(correctQuestions) out of \(questionsPerRound) correct!"
            //Display for average score
        } else if correctQuestions == 2 {
            questionField.text = "\(correctQuestions) is an average score"
            //Display for low score
        } else if correctQuestions < 2 {
            questionField.text = "You got \(correctQuestions) out of \(questionsPerRound) correct. Study More!"
        }
    }
    
    
    //////////////////////////////////////////////
    /////////////////Next Round ////////////////
    /////////////////////////////////////////////
    
    
    // Move on to next round
    func nextRound() {
        if questionsAsked == questionsPerRound {
            
            // Game is over
            displayScore()
            playAgainButton.isHidden = false
            lightningTimer.invalidate()
            resetTimer()
        } else {
            
            // Continue game
            newQuestion()
        }
    }

    
    
    //////////////////////////////////////////////
    /////////////////Play Again Button////////////
    /////////////////////////////////////////////
    
    
    // Play again button
    @IBAction func playAgain() {
        // Hide all answer buttons
        
        firstAnswerButton.isHidden = false
        secondAnswerButton.isHidden = false
        thirdAnswerButton.isHidden = false
        fourthAnswerButton.isHidden = false
    
        // Return question counter to '0'
        questionsAsked = 0
        
        //Return correct question counter to '0'
        correctQuestions = 0
        
        //Remove items from previous questions array 
        previousQuestionsArray.removeAll()
        
        //Load next round
        nextRound()
    }
    
    
    
    
    
    
    
    
    
    
    //////////////////////////////////////////////
    /////////////////Helper Methods////////////////
    /////////////////////////////////////////////
    
    
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    //Game Sounds
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    func loadCorrectAnswerSound() {
        let musicFile = Bundle.main.path(forResource: "correctAnswerSound", ofType: ".mp3")
        let soundURL = URL(fileURLWithPath: musicFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctAnswerSound)
    
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
        
    }
   
    func loadWrongAnswerSound() {
        let musicFile = Bundle.main.path(forResource: "wrongAnswerSound", ofType: ".mp3")
        let soundURL = URL(fileURLWithPath: musicFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongAnswerSound)
        
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongAnswerSound)
        
    }

    
}






