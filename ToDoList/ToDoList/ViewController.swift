//
//  ViewController.swift
//  ToDoList
//
//  Created by JeremyXue on 2018/7/2.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myTask:[String] = []
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func addTask(_ sender: Any) {
        
        // Check taskTextField text
        if taskTextField.text == "" {
            showAlert()
            return
        }
        
        myTask.append(taskTextField.text!)
        saveData()
        taskTextField.text = ""
        listTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        listTableView.dataSource = self
        listTableView.delegate = self
        
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        listTableView.setEditing(editing, animated: true)
    }
    
    // MARK: - Show alert function
    
    func showAlert() {
        let alertController = UIAlertController(title: "錯誤", message: "尚未輸入內容", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Save data & load data
    func saveData() {
        UserDefaults.standard.set(myTask, forKey: "myTask")
    }
    
    func loadData() {
        myTask = UserDefaults.standard.stringArray(forKey: "myTask") ?? []
    }
    
    // MARK: - Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTask.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = myTask[indexPath.row]

        return cell
    }
    
    // MARK: Tableview delegate
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case UITableViewCellEditingStyle.delete:
            myTask.remove(at: indexPath.row)
            listTableView.reloadData()
        default:
            break
        }
    }
}

