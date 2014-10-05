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
    
    @IBOutlet weak var noGoals: UITextView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var userName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Emulate User Having Gone To Settings
        /*userName = "AMAL NANAVATI"
        self.nameLabel.text = userName
        self.noGoals.text = "No Goals? Press '+' below and get started in improving your efficiency!"*/
        
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        self.noGoals.editable = false
        self.noGoals.userInteractionEnabled = false
        
        self.tblTasks.rowHeight = 60
        self.tblTasks?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.addTask?.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        var label = UILabel(frame: CGRectMake(0, 0, addTask.frame.size.width, addTask.frame.size.height))
        label.text = "+"
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(60)
        label.textColor = UIColor.whiteColor()
        self.addTask?.addSubview(label)
        
        noGoals.backgroundColor = UIColor.clearColor()
        if tblTasks.numberOfRowsInSection(0) == 0 {
            noGoals.font = UIFont.systemFontOfSize(20)
            noGoals.textAlignment = NSTextAlignment.Center
        }
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.00, target: tblTasks, selector: Selector("reloadData"), userInfo: nil, repeats: true)

    }
    @IBAction func addTask(sender: AnyObject) {
        if self.noGoals.text == "Welcome! Click Settings To Get Started." {
            let alert = UIAlertController(title: "Oops!", message: "Before creating goals, please go to Setting to configure the app.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                style: UIAlertActionStyle.Default,
                handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let addTaskViewController = self.storyboard?.instantiateViewControllerWithIdentifier("addTask") as UIViewController
            self.navigationController?.pushViewController(addTaskViewController, animated: true)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.objectForKey("userName") == nil {
            self.nameLabel.text = ""
            self.noGoals.text = "Welcome! Click Settings To Get Started."
        } else {
            userName = userDefault.objectForKey("userName") as String
            self.nameLabel.text = userName
            self.noGoals.text = "No Goals? Press '+' below and get started in improving your efficiency!"
        }
        
        if userDefault.objectForKey("taskMngr") != nil {
            taskMngr = userDefault.objectForKey("taskMngr")?.decodeObject() as TaskManager
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView,
        titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
            return NSString(string: "Done")
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if( editingStyle == UITableViewCellEditingStyle.Delete){
            
            let alert = UIAlertController(title: "Completed Goal!", message: "Congratulations, you finished by your deadline!", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Great!",
                style: UIAlertActionStyle.Default,
                handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            taskMngr.tasks.removeAtIndex(indexPath.row)
            tblTasks.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tblTasks.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        if userName != "" {
            if userDefault.objectForKey("userName") == nil {
                userDefault.setObject(self.userName, forKey: "userName")
            } else {
                userDefault.removeObjectForKey("userName")
                userDefault.setObject(self.userName, forKey: "userName")
            }
        }
        if taskMngr.tasks.count != 0 {
            if userDefault.objectForKey("taskMngr") == nil {
                userDefault.setObject(taskMngr.encode(), forKey: "taskMngr")
            } else {
                userDefault.removeObjectForKey("taskMngr")
                userDefault.setObject(taskMngr.encode(), forKey: "taskMngr")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskMngr.tasks.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if taskMngr.tasks.count > 0 {
            noGoals.text = ""
        }
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle , reuseIdentifier: "test")
        cell.textLabel?.text = taskMngr.tasks[indexPath.row].name
        cell.textLabel?.font = UIFont.systemFontOfSize(30)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cell.bringSubviewToFront(cell.textLabel!)
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        let startDate = formatter.dateFromString(taskMngr.tasks[indexPath.row].strtDate)!
        let deadline = formatter.dateFromString(taskMngr.tasks[indexPath.row].desc)!
        
        var scale = CGFloat()
        if NSDate().compare(deadline) == NSComparisonResult.OrderedAscending{
            scale = CGFloat(startDate.timeIntervalSinceNow / startDate.timeIntervalSinceDate(deadline))
        } else {
            scale = CGFloat(1)
        }
        
        var testView : UIView = UIView(frame: CGRectMake(0,0,cell.frame.size.width*scale,tableView.rowHeight))
        
        
        switch indexPath.row % 3 {
        case 0:
            testView.backgroundColor = UIColor(red: 255/255, green: 140/255, blue: 0, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 255/255, green: 227/255, blue: 191/255, alpha: 1.0)
        case 1:
            testView.backgroundColor = UIColor(red: 0, green: 224/255, blue: 98/255, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 168/255, green: 225/255, blue: 193/255, alpha: 1.0)
        case 2:
            testView.backgroundColor = UIColor(red: 0, green: 202/255, blue: 253/255, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 190/255, green: 240/255, blue: 253/255, alpha: 1.0)
        default:
            testView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        }
        
        cell.insertSubview(testView, atIndex: 0)
        
        var deadlineLabel = UILabel(frame: CGRectMake(cell.frame.size.width-100, tableView.rowHeight/2-6, 100, 12))
        
        var todayComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay, fromDate: NSDate())
        var deadlineComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay, fromDate: deadline)
        
        if todayComponents == deadlineComponents {
            formatter.dateFormat = "hh:mm a"
        } else {
            formatter.dateFormat = "yyyy-MM-dd"
        }
        
        deadlineLabel.text = formatter.stringFromDate(deadline)
        deadlineLabel.font = UIFont.systemFontOfSize(16)
        deadlineLabel.textColor = UIColor.whiteColor()
        cell.addSubview(deadlineLabel)
        
        if scale == 1 {
            self.missedDeadline()
        }
        
        return cell
    }
    
    //    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    //    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    func missedDeadline() {
        println("Missed Deadline")
    }
    
}

