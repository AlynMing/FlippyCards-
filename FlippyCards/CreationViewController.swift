//
//  CreationViewController.swift
//  FlippyCards
//
//  Created by HELLO on 2/16/20.
//  Copyright © 2020 HELLO. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    
    @IBOutlet weak var QuestionTextField: UITextField!
    @IBOutlet weak var AnswerTextField: UITextField!
    @IBOutlet weak var ExtraTextField2: UITextField!
    @IBOutlet weak var ExtraTextField3: UITextField!
    
    
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
   
    
    @IBAction func didTapOnCancel(_ sender: Any){
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = QuestionTextField.text
        let answerText = AnswerTextField.text
        let extraa1 = ExtraTextField2.text
        let extraa2 = ExtraTextField3.text
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extra1: extraa1!, extra2: extraa2!)
        dismiss(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

