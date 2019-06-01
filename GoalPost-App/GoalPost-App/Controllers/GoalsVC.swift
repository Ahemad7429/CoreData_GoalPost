//
//  GoalsVC.swift
//  GoalPost-App
//
//  Created by AhemadAbbas Vagh on 01/06/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addGoalButtonWasTapped(_ sender: UIButton) {
        print("Button Tapped")
    }
    
}

