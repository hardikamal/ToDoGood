//
//  AddTaskViewController.swift
//  ToDoGood
//
//  Created by Keshav Rao on 10/4/14.
//  Copyright (c) 2014 Keshav Rao. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var txtTask: UITextField!
    @IBOutlet weak var deadlineView: UIView!
    @IBOutlet weak var sliderView: UIView!
    
    @IBOutlet weak var txtDesc: UITextField!
    
    @IBOutlet weak var motivationLevel: UISlider!
    
    @IBOutlet weak var saveButton: UIButton!
    var picker = UIDatePicker(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 140))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        picker.datePickerMode = UIDatePickerMode.DateAndTime
        picker.addTarget(self, action: "datePickerChanged", forControlEvents: UIControlEvents.AllEvents)
        txtDesc.inputView = picker
        
        self.saveButton?.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        var label = UILabel(frame: CGRectMake(0, 0, saveButton.frame.size.width, saveButton.frame.size.height))
        label.text = "+"
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(60)
        label.textColor = UIColor.whiteColor()
        self.saveButton?.addSubview(label)
        
        self.taskView.backgroundColor = UIColor(red: 255/255, green: 227/255, blue: 191/255, alpha: 1.0)
        self.deadlineView.backgroundColor = UIColor(red: 168/255, green: 225/255, blue: 193/255, alpha: 1.0)
        self.sliderView.backgroundColor = UIColor(red: 190/255, green: 240/255, blue: 253/255, alpha: 1.0)
        
        var motivationLevelLabel = UILabel(frame: CGRectMake(CGFloat(self.xPositionFromSliderValue(motivationLevel)), motivationLevel.frame.origin.y + motivationLevel.frame.size.height, 60, 40))
        motivationLevelLabel.text = NSString(format: "$%.02f", motivationLevel.value)
        motivationLevelLabel.tag = 1996
        self.sliderView.addSubview(motivationLevelLabel)
    }
    
    @IBAction func btnClickAction( sender: UIButton){
    
            
            
            
            let formatter = NSDateFormatter()
            
            formatter.dateFormat = "yyyy-MM-dd hh:mm a"
            
            
            
            if (txtTask.text != "") {
                
                NSLog("%@", txtTask.text)
                
                taskMngr.addTask(txtTask.text, desc: txtDesc.text, strtDate: formatter.stringFromDate(NSDate()),amnt: NSString(format: "$%.02f", motivationLevel.value))
                
                NSLog("%@", taskMngr);
                
                
                
                
                
                
                
                self.view.endEditing(true)
                
                txtTask.text = ""
                
                txtDesc.text = ""
                
                
                
                var taskobjs: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("tasks")
                
                
                
                if (taskobjs == nil) {
                    
                    
                    
                    var worker = taskMngr.tasks[0];
                    
                    
                    
                    var name = worker.name
                    
                    var desc = worker.desc
                    
                    var strtDate = worker.strtDate
                    
                    var amnt = worker.amnt
                    
                    
                    
                    var alltask:NSMutableArray = [name, desc, strtDate, amnt]
                    
                    var taskstore: NSMutableArray = []
                    
                    taskstore.addObject(alltask);
                    
                    NSLog("%@", taskstore);
                    
                    
                    
                    NSUserDefaults.standardUserDefaults().setObject(taskstore, forKey:"tasks")
                    
                    
                    
                }
                    
                else {
                    
                    
                    
                    var taskstore: NSMutableArray = []
                    
                    taskstore.addObject((NSUserDefaults.standardUserDefaults().objectForKey("tasks"))!)
                    
                    NSLog("%@", taskstore);
                    
                    
                    
                    var worker = taskMngr.tasks[0];
                    
                    
                    
                    var name = worker.name
                    
                    var desc = worker.desc
                    
                    var strtDate = worker.strtDate
                    
                    var amnt = worker.amnt
                    
                    
                    
                    var alltask:NSMutableArray = [name, desc, strtDate, amnt]
                    
                    
                    
                    taskstore.addObject(alltask);
                    
                    NSLog("%@", taskstore);
                    
                    
                    
                    NSUserDefaults.standardUserDefaults().setObject(taskstore, forKey:"tasks")
                    
                }
                
                
                
                
                
                
                
                self.tabBarController?.selectedIndex = 0
                
                
                
            }
            
            
            
        }
    @IBAction func sliderChanged(sender: AnyObject) {
        if motivationLevel.value < 0.5 && motivationLevel.value > 0 {
            motivationLevel.value = 0.5
        }
        println(NSString(format: "%f", motivationLevel.value))
        var motivationLevelLabel = UILabel(frame: CGRectMake(CGFloat(self.xPositionFromSliderValue(motivationLevel)), motivationLevel.frame.origin.y + motivationLevel.frame.size.height, 60, 40))
        if self.view.viewWithTag(1996) != nil {
            self.view.viewWithTag(1996)?.removeFromSuperview()
        }
        motivationLevelLabel.text = NSString(format: "$%0.2f", motivationLevel.value)
        motivationLevelLabel.tag = 1996
        self.sliderView.addSubview(motivationLevelLabel)
    }
    
    func datePickerChanged() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        txtDesc.text = formatter.stringFromDate(picker.date)
    }
    
    func xPositionFromSliderValue(aSlider : UISlider) -> CGFloat
    {
        var sliderValueToPixels = CGFloat(aSlider.minimumValue) + aSlider.frame.size.width * CGFloat(aSlider.value / aSlider.maximumValue) - CGFloat(20)*CGFloat(aSlider.value - aSlider.maximumValue/2)
    
        return sliderValueToPixels
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}




