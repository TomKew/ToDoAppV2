//
//  DoneTableViewController.swift
//  ToDoApp
//
//  Created by Field Employee on 4/11/20.
//  Copyright © 2020 Tom Kew-Goodale. All rights reserved.
//

import UIKit

class DoneTableViewController: UITableViewController {
    
    var doneTasks = [String]()
    var doneSubTasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.title = "Done-To-Do"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
       
           super.viewWillAppear(true)
          updateTasks()
       }
    
    func updateTasks(){
           
           doneTasks.removeAll()
           doneSubTasks.removeAll()
          // Image.removeAll()
           
          guard let count = UserDefaults().value(forKey: "doneCount") as? Int else{
               return
           }
           
           for x in 0..<count{
               if let task = UserDefaults().value(forKey: "doneTask_\(x+1)") as? String {
                   doneTasks.append(task)
               }
           }
               for y in 0..<count{
               if let task = UserDefaults().value(forKey: "doneSubTask_\(y+1)") as? String {
                   doneSubTasks.append(task)
               }
           }
           /*    for z in 0..<count{
               if let task = UserDefaults().value(forKey: "Image_\(z+1)") as? UIImage {
                   Image.append(task)
                   }
                   
           }
    */
           UserDefaults.standard.synchronize()
           tableView.reloadData()
           
       }
       
    
    // MARK: - Table view data source
    
       
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return doneTasks.count
       }
       
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "finishcell", for: indexPath)
           
           cell.textLabel?.text = doneTasks[indexPath.row]
           cell.detailTextLabel?.text = doneSubTasks[indexPath.row]
        //   cell.imageView?.image = Image[indexPath.row]
           
           return cell
       }
       
      override  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               deleteTask(forRowAt: indexPath)
               tableView.deleteRows(at: [indexPath], with: .fade)
               tableView.reloadData()
               
               
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
           }
       }
       
        @objc func deleteTask(forRowAt indexPath: IndexPath) {
           
           
           guard let count = UserDefaults().value(forKey: "doneCount") as? Int else{
                      return
                  }
                  
          
           
                

               UserDefaults.standard.removeObject(forKey: "doneTask_\(count-1)")
               UserDefaults.standard.set(doneTasks, forKey: "doneTask_\(count-1)")
               UserDefaults.standard.removeObject(forKey: "doneSubTask_\(count-1)")
               UserDefaults.standard.set(doneSubTasks, forKey: "doneSubTask_\(count-1)")
               UserDefaults.standard.set(count, forKey: "doneTask_\(count-1)")
               UserDefaults.standard.synchronize()
            
                doneTasks.remove(at: indexPath.row)
                doneSubTasks.remove(at: indexPath.row)
    }
                  
           
}


    


