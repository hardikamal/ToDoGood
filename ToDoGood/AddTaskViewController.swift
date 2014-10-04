//
//  AddTaskViewController.swift
//  ToDoGood
//
//  Created by Keshav Rao on 10/4/14.
//  Copyright (c) 2014 Keshav Rao. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var txtTask: UITextField!
    
    @IBOutlet weak var txtDesc: UITextField!
    
    @IBOutlet weak var motivationLevel: UISlider!
    
    var picker = UIDatePicker(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 140))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        picker.datePickerMode = UIDatePickerMode.DateAndTime
        picker.addTarget(self, action: "datePickerChanged", forControlEvents: UIControlEvents.AllEvents)
        txtDesc.inputView = picker
        
        var motivationLevelLabel = UILabel(frame: CGRectMake(CGFloat(self.xPositionFromSliderValue(motivationLevel)), motivationLevel.frame.origin.y + motivationLevel.frame.size.height, 60, 40))
        motivationLevelLabel.text = NSString(format: "$%.02f", motivationLevel.value)
        motivationLevelLabel.tag = 1996
        self.view.addSubview(motivationLevelLabel)
    }
    @IBAction func btnClickAction( sender: UIButton){
        
        if (txtTask.text != "") {
                NSLog("%@", txtTask.text)
            taskMngr.addTask(txtTask.text, desc: txtDesc.text, amnt: NSString(format: "$%.02f", motivationLevel.value))
        self.view.endEditing(true)
        txtTask.text = ""
        txtDesc.text = ""
        
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
        self.view.addSubview(motivationLevelLabel)
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




