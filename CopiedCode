//
//  ViewController.swift
//  FlippyCards
//
//  Created by HELLO on 2/15/20.
//  Copyright © 2020 HELLO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //~~~~~~correct and incorrect symbols~~~~~~
        xmarksymbol1.isHidden = true
        xmarksymbol2.isHidden = true
        checkmarksymbol.isHidden = true
        
        
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
