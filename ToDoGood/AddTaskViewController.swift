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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func btnClickAction( sender: UIButton){
        
        if (txtTask.text != "") {
                NSLog("%@", txtTask.text)
        taskMngr.addTask(txtTask.text, desc: txtDesc.text)
        self.view.endEditing(true)
        txtTask.text = ""
        txtDesc.text = ""
        
        self.tabBarController?.selectedIndex = 0
        
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
}




