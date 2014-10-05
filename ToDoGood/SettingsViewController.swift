//
//  SettingsViewController.swift
//  ToDoGood
//
//  Created by Amal Nanavati on 10/5/14.
//  Copyright (c) 2014 Keshav Rao. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController , UITextFieldDelegate/*, UIPickerViewDataSource, UIPickerViewDelegate*/ {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var name: UITextField!
    //@IBOutlet weak var charityPicker: UIPickerView!
    
    //var charityArray = ["American Cancer Society", "Salvation Army", "Red Cross"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.doneButton?.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        var label = UILabel(frame: CGRectMake(0, 0, doneButton.frame.size.width, doneButton.frame.size.height))
        label.text = "Done"
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(60)
        label.textColor = UIColor.whiteColor()
        self.doneButton?.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setUpPayment(sender: AnyObject) {
        
    }
    @IBAction func Done(sender: AnyObject) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        if self.name.text != "" {
            if userDefault.objectForKey("userName") == nil {
                userDefault.setObject(self.name.text, forKey: "userName")
            } else {
                userDefault.removeObjectForKey("userName")
                userDefault.setObject(self.name.text, forKey: "userName")
            }
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        textField.resignFirstResponder()
        return true
    }

}
