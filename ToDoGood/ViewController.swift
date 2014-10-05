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
    
    var userName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.objectForKey("userName") == nil {
            var alert = UIAlertView()
            alert.title = "What is your name?"
            alert.addButtonWithTitle("Done")
            alert.delegate = self
            alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
            alert.show()
        }
        
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
                handler: {
                    (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
                    self.tblTasks?.deselectRowAtIndexPath(indexPath, animated: true)
            }))
            
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

