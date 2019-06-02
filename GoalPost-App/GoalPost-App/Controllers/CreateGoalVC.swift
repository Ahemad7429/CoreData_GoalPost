//
//  CreateGoalVC.swift
//  GoalPost-App
//
//  Created by AhemadAbbas Vagh on 02/06/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.bindToKeyboard()
        cofigureGoalTypeSelection()
    }
    
    @IBAction func buttonWasTapped(_ sender: UIButton) {
        
        switch sender {
        case nextButton: print("next")
        case shortTermButton: cofigureGoalTypeSelection()
        case longTermButton: cofigureGoalTypeSelection(isShortTerm: false)
        default: dismissDetail()
        }
    }
    
    func cofigureGoalTypeSelection(isShortTerm: Bool = true) {
        
        if isShortTerm {
            goalType = .shortTerm
            shortTermButton.setSelectedColor()
            longTermButton.setDeselectedColor()
        } else {
            goalType = .longTerm
            longTermButton.setSelectedColor()
            shortTermButton.setDeselectedColor()
        }
    }
    
}
