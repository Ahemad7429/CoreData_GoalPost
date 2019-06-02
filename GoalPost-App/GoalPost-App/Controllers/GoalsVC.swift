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
    
    //MARK: Variables
    var goals = [Goal]()
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData { (isSuccess) in
            if isSuccess {
                if goals.count > 0 {
                    tableView.isHidden = false
                    tableView.reloadData()
                } else {
                    tableView.isHidden = true
                }
            }
        }
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
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell() }
        cell.configureCell(goal: goals[indexPath.row])
        return cell
    }
}

//MARK: CoreData Related Stuff.
extension GoalsVC {
    
    func fetchData(completion: (_ isSuccess: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            completion(false)
            return
        }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could Not Fetch: \(error.localizedDescription)")
            completion(false)
        }
        
    }
}
