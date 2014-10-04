//
//  ViewController.swift
//  ToDoGood
//
//  Created by Keshav Rao on 10/4/14.
//  Copyright (c) 2014 Keshav Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!){
        
        if( editingStyle == UITableViewCellEditingStyle.Delete){
            taskMngr.tasks.removeAtIndex(indexPath.row)
            tblTasks.reloadData()
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tblTasks.reloadData()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return taskMngr.tasks.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle , reuseIdentifier: "test")
        cell.text = taskMngr.tasks[indexPath.row].name
        cell.detailTextLabel.text = taskMngr.tasks[indexPath.row].desc
        return cell
    }
    



}

