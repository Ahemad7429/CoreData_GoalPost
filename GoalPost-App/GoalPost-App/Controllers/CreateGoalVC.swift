//
//  CreateGoalVC.swift
//  GoalPost-App
//
//  Created by AhemadAbbas Vagh on 02/06/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    //MARK: Outlets
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: Variables
    var goalType: GoalType = .shortTerm
    
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.delegate = self
        nextButton.bindToKeyboard()
        configureGoalTypeSelection()
    }
    
    //MARK: Actions
    @IBAction func buttonWasTapped(_ sender: UIButton) {
        switch sender {
        case nextButton: nextButtonTapped()
        case shortTermButton: configureGoalTypeSelection()
        case longTermButton: configureGoalTypeSelection(isShortTerm: false)
        default: dismissDetail()
        }
    }
    
    //MARK: TextView Delegate Methods
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    //MARK: Functions
    func nextButtonTapped() {
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return }
            finishGoalVC.initWithData(description: goalTextView.text!, type: goalType)
            presentDetail(finishGoalVC)
        }
    }
    
    func configureGoalTypeSelection(isShortTerm: Bool = true) {
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
