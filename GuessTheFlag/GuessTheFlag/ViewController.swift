//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Geoffrey Caven on 2019-05-27.
//  Copyright © 2019 Geoffrey Caven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  var countries = [String]()
  var score = 0
  var questionsAsked = 0
  var correctAnswer = Int.random(in: 0...2)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    
    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    countries += [
      "estonia",
      "france",
      "germany",
      "ireland",
      "italy",
      "monaco",
      "nigeria",
      "poland",
      "russia",
      "spain",
      "uk",
      "us"
    ]
    askQuestion()
  }
  
  func askQuestion(action: UIAlertAction! = nil) {
    if (questionsAsked == 10) {
      gameOver()
    } else {
      correctAnswer = Int.random(in: 0...2)
      countries.shuffle()
      button1.setImage(UIImage(named: countries[0]), for: .normal)
      button2.setImage(UIImage(named: countries[1]), for: .normal)
      button3.setImage(UIImage(named: countries[2]), for: .normal)
      title = "Score: \(score), Question: \(countries[correctAnswer].uppercased())"
      questionsAsked += 1
    }
  }
  
  func gameOver() {
    let ac = UIAlertController(
      title: "Your final score was \(score)/10.",
      message: "Play again?",
      preferredStyle: .alert
    )
    ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame))
    present(ac, animated: true)
  }
  
  func restartGame(action: UIAlertAction! = nil) {
    score = 0
    questionsAsked = 0
    askQuestion()
  }

  @IBAction func buttonTapped(_ sender: UIButton) {
    var title : String
    if sender.tag == correctAnswer {
      title = "Correct!"
      score += 1
    } else {
      title = "Wrong, that is the flag of \(countries[sender.tag].uppercased())!"
      score -= 1
    }
    
    let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
    present(ac, animated: true)
  }
  
}

