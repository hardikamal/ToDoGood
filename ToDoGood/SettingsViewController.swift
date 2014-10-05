//
//  SettingsViewController.swift
//  ToDoGood
//
//  Created by Amal Nanavati on 10/5/14.
//  Copyright (c) 2014 Keshav Rao. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController , UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, PayPalPaymentDelegate {

    
    var config = PayPalConfiguration()
    
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var name: UITextField!
    //@IBOutlet weak var charityPicker: UIPickerView!
    
    @IBOutlet weak var charityList: UITableView!
    var charityArray = ["American Cancer Society", "Salvation Army", "Red Cross"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charityList.userInteractionEnabled = true
        // Do any additional setup after loading the view.
        
        self.doneButton?.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        var label = UILabel(frame: CGRectMake(0, 0, doneButton.frame.size.width, doneButton.frame.size.height))
        label.text = "Done"
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(60)
        label.textColor = UIColor.whiteColor()
        self.doneButton?.addSubview(label)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        PayPalMobile.preconnectWithEnvironment(PayPalEnvironmentNoNetwork)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SetUp(sender: AnyObject) {
        
        
        let amount = NSDecimalNumber.decimalNumberWithString("1.00")
        
        
        println("amount \(amount)")
        
        var payment = PayPalPayment()
        payment.amount = amount
        payment.currencyCode = "USD"
        payment.shortDescription = "Task"
       
            var paymentViewController = PayPalPaymentViewController(payment: payment, configuration: config, delegate: self)
            self.presentViewController(paymentViewController, animated: false, completion: nil)
        
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
  
    
  
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charityArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
        println("YES")
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle , reuseIdentifier: "test")
        cell.textLabel?.text = charityArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    

}
