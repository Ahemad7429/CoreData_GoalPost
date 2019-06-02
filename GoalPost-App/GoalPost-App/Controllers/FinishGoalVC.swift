//
//  FinishGoalVC.swift
//  GoalPost-App
//
//  Created by AhemadAbbas Vagh on 02/06/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var buttonContainer: UIView!
    
    //MARK: Variables
    private var goalType: GoalType!
    private var goalDescription: String!
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
            buttonContainer.bindToKeyboard()
    }
    
    //MARK: Functions
    func initWithData(description: String, type: GoalType) {
        self.goalType = type
        self.goalDescription = description
    }
    
    //MARK: Actions
    @IBAction func createGoalButtonTapped(_ sender: UIButton) {
        
    }
}
