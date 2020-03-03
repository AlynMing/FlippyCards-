//
//  ViewController.swift
//  FlippyCards
//
//  Created by HELLO on 2/15/20.
//  Copyright © 2020 HELLO. All rights reserved.
//

import UIKit


struct Flashcard {
    var question: String
    var answer: String
    var extra1: String
    var extra2: String
}



class ViewController: UIViewController {

    
    
    
    
    //~~~~~~outlets and actions~~~~~~~
    @IBOutlet weak var cards: UIView!
    @IBOutlet weak var backlabel: UILabel!
    @IBOutlet weak var frontlabel: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option1view: UIView!
    @IBOutlet weak var option2view: UIView!
    @IBOutlet weak var option3view: UIView!
    @IBOutlet weak var xmarksymbol1: UIImageView!
    @IBOutlet weak var xmarksymbol2: UIImageView!
    @IBOutlet weak var checkmarksymbol: UIImageView!
    @IBOutlet weak var PrevButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var checkmarkopt3: UIImageView!
    @IBOutlet weak var xmarksymbolmid: UIImageView!
    @IBOutlet weak var checkmarkopt1: UIImageView!
    @IBAction func didTapDelete(_ sender: Any) {
        
        if flashcards.count == 1 {
            let alert = UIAlertController(title: "Error", message: "You cannot delete the last flashcard!", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Delete Flashcard", message: "Warning: This will permanently delete the card!", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.deleteCurrentFlashcard()
            }
            alert.addAction(deleteAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
   
    
    func deleteCurrentFlashcard() {
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        // update our labels and buttons
        updateNextPrevButtons()
        updateLabels()
        
        // save remaining flashcards to disk
        saveAllFlashcardsToDisk()
    }
        
        
        
 
    
    
    

    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extra1": card.extra1, "extra2": card.extra2]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults!")
    }
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extra1: dictionary["extra1"]!, extra2: dictionary["extra2"]!)
        }
    flashcards.append(contentsOf: savedCards)
    }
    }
    
      
  
     
    var correctAnswerButton: UIButton!

     func updateLabels() {
             let currentFlashcard = flashcards[currentIndex]
            frontlabel.text = currentFlashcard.question
            backlabel.text = currentFlashcard.answer
        
     let buttons = [option1, option2, option3].shuffled()
     let answers = [currentFlashcard.answer, currentFlashcard.extra1, currentFlashcard.extra2].shuffled()
        
    for (button, answer) in zip(buttons, answers) {
    button?.setTitle(answer, for: .normal)

        if answer == currentFlashcard.answer{
        correctAnswerButton = button
        }
        }
    }
    
     
    func animateCardOutRight(){
        UIView.animate(withDuration: 0.3, animations: {
            self.cards.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardInRight()
        })
    }
    
    func animateCardInRight(){
        
        cards.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.2) {
            self.cards.transform = CGAffineTransform.identity
        }
    }
   
    func animateCardOutLeft(){
           UIView.animate(withDuration: 0.3, animations: {
               self.cards.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
           }, completion: { finished in
               self.updateLabels()
               self.animateCardInLeft()
           })
       }
       
       func animateCardInLeft(){
           
           cards.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
           
           UIView.animate(withDuration: 0.2) {
               self.cards.transform = CGAffineTransform.identity
           }
       }
    
    //~~~~~~Prev&Next Functionality~~~~~~
     @IBAction func didTapOnNext( sender: Any) {
     
         currentIndex = currentIndex + 1
         
         updateNextPrevButtons()
        
         resetQuestion()
        
         animateCardOutRight()
         
     }

    @IBAction func didTapOnPrev( sender: Any) {
    
        currentIndex = currentIndex - 1
        
        updateNextPrevButtons()
        
        resetQuestion()
        
        animateCardOutLeft()
        
    }
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     
     
   
    
         
         
        
        
        
    
    //~~~~~~updating next and prev buttons~~~~~~
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            NextButton.isEnabled = false
        } else {
            NextButton.isEnabled = true
        }
        if currentIndex == flashcards.count - flashcards.count {
            PrevButton.isEnabled = false
        } else {
            PrevButton.isEnabled = true
        }
    }
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    
        
        
          //~~~~~~updating flashcards~~~~~~
          func updateFlashcard(question: String, answer: String, extra1: String, extra2: String) {
              let flashcard = Flashcard(question: question, answer: answer, extra1: extra1, extra2: extra2)
              option1.setTitle(extra1, for: .normal)
              option2.setTitle(answer, for: .normal)
              option3.setTitle(extra2, for: .normal)
              flashcards.append(flashcard)
              print("🎉New Flashcard Added!🎉")
              print("There are now \(flashcards.count) flashcards!")
              currentIndex = flashcards.count - 1
              print("Your current index is \(currentIndex)!")
              saveAllFlashcardsToDisk()
              updateNextPrevButtons()
              updateLabels()
          //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          }
        
    
override func viewDidLoad() {
        super.viewDidLoad()
        resetQuestion()
    
        //~~~~~~correct and incorrect symbols~~~~~~
        xmarksymbol1.isHidden = true
        xmarksymbol2.isHidden = true
        checkmarksymbol.isHidden = true
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       
        //~~~~~~rounded card corners~~~~~~
        cards.layer.cornerRadius = 15
        frontlabel.layer.cornerRadius = 15
        backlabel.layer.cornerRadius = 15
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        //~~~~~~rounded label corners~~~~~~
        frontlabel.clipsToBounds = true
        backlabel.clipsToBounds = true
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        //~~~~~~shadows for cards~~~~~~
        cards.layer.shadowRadius = 9.0
        cards.layer.shadowOpacity = 0.5
        cards.layer.shadowColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        //~~~~~~borders for options~~~~~~
        option1.layer.borderWidth = 3.0
        option1.layer.borderColor = #colorLiteral(red: 0.9670787454, green: 0.9030047059, blue: 0.4915370941, alpha: 1)
        option2.layer.borderWidth = 3.0
        option2.layer.borderColor = #colorLiteral(red: 0.9670787454, green: 0.9030047059, blue: 0.4915370941, alpha: 1)
        option3.layer.borderWidth = 3.0
        option3.layer.borderColor = #colorLiteral(red: 0.9662605246, green: 0.9012485355, blue: 0.4901985501, alpha: 1)
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        //~~~~~~rounded options corners~~~~~~
        //option 1 corners
        option1.layer.cornerRadius = 15
        option1.clipsToBounds = true
        //option 2 corners
        option2.layer.cornerRadius = 15
        option2.clipsToBounds = true
        //option 3 corners
        option3.layer.cornerRadius = 15
        option3.clipsToBounds = true
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        readSavedFlashcards()
        
    
        if flashcards.count == 0 {
            updateFlashcard(question: "What is a great way to study?", answer: "FlippyCards!", extra1: "Other apps", extra2: "Don't study")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }

    
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cards.alpha = 0.0
        self.cards.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        self.option1.alpha = 0.0
        self.option1.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        self.option2.alpha = 0.0
        self.option2.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        self.option3.alpha = 0.0
        self.option3.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: [], animations: {
            self.cards.alpha = 1.0
            self.cards.transform = CGAffineTransform.identity
            self.option1.alpha = 1.0
            self.option1.transform = CGAffineTransform.identity
            self.option2.alpha = 1.0
            self.option2.transform = CGAffineTransform.identity
            self.option3.alpha = 1.0
            self.option3.transform = CGAffineTransform.identity
        })
    }
    

    
    func resetQuestion() {
        
        self.option1.backgroundColor = #colorLiteral(red: 1, green: 0.990821898, blue: 0.4215033054, alpha: 1)
        self.xmarksymbol1.isHidden = true
        self.checkmarkopt1.isHidden = true
        
        self.frontlabel.isHidden = false
        self.option2.backgroundColor = #colorLiteral(red: 1, green: 0.990821898, blue: 0.4215033054, alpha: 1)
        self.checkmarksymbol.isHidden = true
        self.xmarksymbolmid.isHidden = true

        self.option3.backgroundColor = #colorLiteral(red: 1, green: 0.990821898, blue: 0.4215033054, alpha: 1)
        self.xmarksymbol2.isHidden = true
        self.checkmarkopt3.isHidden = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        resetQuestion()
        
    }
    
    func flipFlashcard(){
        
        UIView.transition(with: cards, duration: 0.2, options: .transitionFlipFromRight, animations: {
            self.frontlabel.isHidden = true
        })
    }
    
    //~~~~~~logic for options~~~~~~
    
        @IBAction func tappedoption1(_ sender: Any) {
            if option1 == correctAnswerButton {
                flipFlashcard()
                checkmarkopt1.isHidden = false
            } else {
                option1.backgroundColor = #colorLiteral(red: 1, green: 0.9768008926, blue: 0.4592402693, alpha: 0.5)
                xmarksymbol1.isHidden = false
            }
    }
    
        @IBAction func tappedoption2(_ sender: Any) {
            if option2 == correctAnswerButton {
                flipFlashcard()
                checkmarksymbol.isHidden = false
            } else {
                option2.backgroundColor = #colorLiteral(red: 1, green: 0.9768008926, blue: 0.4592402693, alpha: 0.5)
                xmarksymbolmid.isHidden = false
            }
    }
    
        @IBAction func tappedoption3(_ sender: Any) {
            if option3 == correctAnswerButton {
                flipFlashcard()
                checkmarkopt3.isHidden = false
            } else {
                option3.backgroundColor = #colorLiteral(red: 1, green: 0.9768008926, blue: 0.4592402693, alpha: 0.5)
                xmarksymbol2.isHidden = false
            }
    }
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



}

