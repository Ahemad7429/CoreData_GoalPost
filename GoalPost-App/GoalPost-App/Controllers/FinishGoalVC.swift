//
//  FinishGoalVC.swift
//  GoalPost-App
//
//  Created by AhemadAbbas Vagh on 02/06/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

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
            createGoalButton.bindToKeyboard()
    }
    
    //MARK: Functions
    func initWithData(description: String, type: GoalType) {
        self.goalType = type
        self.goalDescription = description
    }
    
    func save(compeltion: (_ isFinish: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext
            else {
            compeltion(false)
            return }
        let goal = Goal(context: managedContext)
        goal.goalDescription = self.goalDescription
        goal.goalType = self.goalType.rawValue
        goal.goalCompletionValue = Int32(self.pointsTextField.text!)!
        goal.goalProgressValue = Int32(0)
        
        do {
            try managedContext.save()
            compeltion(true)
        } catch {
            debugPrint("Error In Save: \(error.localizedDescription)")
            compeltion(false)
        }
    }
    
    //MARK: Actions
    @IBAction func createGoalButtonTapped(_ sender: UIButton) {
        if pointsTextField.text != "" {
            self.save { (isCompleted) in
                if isCompleted {
                    self.dismissDetail()
                }
            }
        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismissDetail()
    }
}
