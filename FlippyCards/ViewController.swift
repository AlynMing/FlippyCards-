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
    
    @IBAction func didTapDelete(_ sender: Any) {
        
        if currentIndex == 0 {
            let alert = UIAlertController(title: "Error", message: "You cannot delete the last flashcard!", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Delete Card", message: "Are you sure about that?", preferredStyle: .actionSheet)
            
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
        updateNextletesPrevButtons()
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
    
      

     
     
     func updateLabels() {
             let currentFlashcard = flashcards[currentIndex]
            frontlabel.text = currentFlashcard.question
            backlabel.text = currentFlashcard.answer
        option1.setTitle(currentFlashcard.extra1, for: .normal)
        option2.setTitle(currentFlashcard.answer, for: .normal)
        option3.setTitle(currentFlashcard.extra2, for: .normal)
    }
    
    
     
     
    
    
    //~~~~~~Prev&Next Functionality~~~~~~
     @IBAction func didTapOnNext( sender: Any) {
     
         currentIndex = currentIndex + 1
        
         updateLabels()
         
         updateNextPrevButtons()
        
         resetQuestion()
         
     }

    @IBAction func didTapOnPrev( sender: Any) {
    
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
        resetQuestion()
        
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
        
        //~~~~~~correct and incorrect symbols~~~~~~
        xmarksymbol1.isHidden = true
        xmarksymbol2.isHidden = true
        checkmarksymbol.isHidden = true
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       
        //~~~~~~rounded card corners~~~~~~
        cards.layer.cornerRadius = 15
        cards.clipsToBounds = true
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        //~~~~~~rounded label corners~~~~~~
        frontlabel.clipsToBounds = true
        backlabel.clipsToBounds = true
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        //~~~~~~shadows for cards~~~~~~
        cards.layer.shadowRadius = 20.0
        cards.layer.shadowOpacity = 0.1
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        //~~~~~~borders for options~~~~~~
        option1.layer.borderWidth = 3.0
        option1.layer.borderColor = #colorLiteral(red: 1, green: 0.9804150462, blue: 0, alpha: 1)
        option2.layer.borderWidth = 3.0
        option2.layer.borderColor = #colorLiteral(red: 1, green: 0.9804150462, blue: 0, alpha: 1)
        option3.layer.borderWidth = 3.0
        option3.layer.borderColor = #colorLiteral(red: 1, green: 0.9804150462, blue: 0, alpha: 1)
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        //~~~~~~rounded options corners~~~~~~
        //option 1 corners
        option1view.layer.cornerRadius = 15
        option1view.clipsToBounds = true
        option1.clipsToBounds = true
        option1.clipsToBounds = true
        //option 2 corners
        option2view.layer.cornerRadius = 15
        option2view.clipsToBounds = true
        option2.clipsToBounds = true
        option2.clipsToBounds = true
        //option 3 corners
        option3view.layer.cornerRadius = 15
        option3view.clipsToBounds = true
        option3.clipsToBounds = true
        option3.clipsToBounds = true
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        readSavedFlashcards()
        
    
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the current seasonal slushie at Taco Bell?", answer: "Electric Blue Raspberry", extra1: "Pineapple Sunset", extra2: "Watermelon with Seeds")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }

    
}
    
    func resetQuestion() {
        
        self.option1.backgroundColor = #colorLiteral(red: 1, green: 0.990821898, blue: 0.4215033054, alpha: 1)
        self.xmarksymbol1.isHidden = true
        
        self.frontlabel.isHidden = false
        self.checkmarksymbol.isHidden = true

        self.option3.backgroundColor = #colorLiteral(red: 1, green: 0.990821898, blue: 0.4215033054, alpha: 1)
        self.xmarksymbol2.isHidden = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        resetQuestion()
        
    }
    
    
    
    //~~~~~~logic for options~~~~~~
    
        @IBAction func tappedoption1(_ sender: Any) {
    option1.backgroundColor = #colorLiteral(red: 1, green: 0.9768008926, blue: 0.4592402693, alpha: 0.5)
    xmarksymbol1.isHidden = false
    }
    
        @IBAction func tappedoption2(_ sender: Any) {
    frontlabel.isHidden = true
    checkmarksymbol.isHidden = false
    }
    
        @IBAction func tappedoption3(_ sender: Any) {
    option3.backgroundColor = #colorLiteral(red: 1, green: 0.9768008926, blue: 0.4592402693, alpha: 0.5)
    xmarksymbol2.isHidden = false
    }
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    

}

