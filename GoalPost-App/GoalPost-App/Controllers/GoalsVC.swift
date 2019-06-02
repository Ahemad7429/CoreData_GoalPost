//
//  GoalsVC.swift
//  GoalPost-App
//
//  Created by AhemadAbbas Vagh on 01/06/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }

    //MARK: Actions
    @IBAction func addGoalButtonWasTapped(_ sender: UIButton) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") as? CreateGoalVC else { return }
        presentDetail(createGoalVC)
    }
    
}

//MARK: TableView DataSource & Delegate Methods
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell() }
        cell.configureCell(description: "Complete Lesson Goal Post.", type: .shortTerm, goalProgressAmount: 3)
        return cell
    }
    
    
}
