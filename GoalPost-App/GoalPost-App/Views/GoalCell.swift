//
//  GoalCell.swift
//  GoalPost-App
//
//  Created by AhemadAbbas Vagh on 01/06/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    
    
    //MARK: Function
    func configureCell(goal: Goal) {
        goalDescriptionLabel.text = goal.goalDescription
        goalTypeLabel.text = goal.goalType
        goalProgressLabel.text = String(describing: goal.goalProgressValue)
    }
    
}
