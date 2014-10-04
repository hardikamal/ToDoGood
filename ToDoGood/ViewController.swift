//
//  FirstViewController.swift
//  todolist
//
//  Created by tareq jobayere on 6/5/14.
//  Copyright (c) 2014 tarex. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var tblTasks: UITableView!
    
    @IBOutlet weak var addTask: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.addTask?.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        println(NSString(format: "%@", addTask.frame.size.width/2-30))
        var label = UILabel(frame: CGRectMake(0, 0, addTask.frame.size.width, addTask.frame.size.height))
        label.text = "+"
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(60)
        label.textColor = UIColor.whiteColor()
        self.addTask?.addSubview(label)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if( editingStyle == UITableViewCellEditingStyle.Delete){
            taskMngr.tasks.removeAtIndex(indexPath.row)
            tblTasks.reloadData()
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tblTasks.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskMngr.tasks.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle , reuseIdentifier: "test")
        cell.textLabel?.text = taskMngr.tasks[indexPath.row].name
        cell.detailTextLabel?.text = taskMngr.tasks[indexPath.row].desc
        return cell
    }
    
    //    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    //    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    
    
}

