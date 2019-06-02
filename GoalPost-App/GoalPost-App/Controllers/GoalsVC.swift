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
    @IBOutlet weak var undoView: UIView!
    
    //MARK: Variables
    var goals = [Goal]()
    var recentDeletedGoal: Goal?
    var recendDeletedGoalIndexPath: IndexPath?
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromCoreData()
    }
    
    //MARK: Functions
    func fetchDataFromCoreData() {
        self.fetchData { (isSuccess) in
            if isSuccess {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
        tableView.reloadData()
    }
    
    //MARK: Actions
    @IBAction func addGoalButtonWasTapped(_ sender: UIButton) {
        self.undoView.isHidden = true
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") as? CreateGoalVC else { return }
        presentDetail(createGoalVC)
    }
    
    @IBAction func undoButtonWasTapped(_ sender: UIButton) {
        self.undoView.isHidden = true
        undoGoal()
        fetchDataFromCoreData()
    }
}

//MARK: TableView DataSource & Delegate Methods
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell() }
        cell.configureCell(goal: goals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexpath) in
            self.removeGoal(atIndexPath: indexpath)
            self.fetchDataFromCoreData()
           // tableView.deleteRows(at: [indexpath], with: .automatic)
            self.undoView.isHidden = false
            
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexpath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        
        return [deleteAction,addAction]
    }
}

//MARK: CoreData Related Stuff.
extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgressValue < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgressValue += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could Not Set Progress: \(error.localizedDescription)")
        }
        
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goals[indexPath.row])
       
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could Not Deleted: \(error.localizedDescription)")
        }
        
    }
    
    func undoGoal() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.undoManager?.undo()
        
        do {
            try managedContext.save()
            print("SuccessFully Undo")
        } catch {
            debugPrint("Could Not Undo: \(error.localizedDescription)")
        }
    }
    
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
