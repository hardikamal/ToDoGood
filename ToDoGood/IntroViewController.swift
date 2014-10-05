//
//  IntroViewController.swift
//  ToDoGood
//
//  Created by Amal Nanavati on 10/5/14.
//  Copyright (c) 2014 Keshav Rao. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var getStarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBarHidden = true
        
        
        
        self.getStarted.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height*2/3, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height*1/3)
        
        self.getStarted?.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        
        var label = UILabel(frame: CGRectMake(0, 0, getStarted.frame.size.width, getStarted.frame.size.height))
        
        label.text = "Get Started"
        
        label.textAlignment = NSTextAlignment.Center
        
        label.font = UIFont.systemFontOfSize(40)
        
        label.textColor = UIColor.whiteColor()
        
        self.getStarted?.addSubview(label)
        
        
        
        var titleView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height*1/3))
        
        titleView.backgroundColor = UIColor(red: 255/255, green: 227/255, blue: 191/255, alpha: 1.0)
        
        var titleLabel = UILabel(frame: CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height))
        
        titleLabel.text = "Better Finish"
        
        titleLabel.textAlignment = NSTextAlignment.Center
        
        titleLabel.font = UIFont.systemFontOfSize(50)
        
        titleLabel.textColor = UIColor(red: 255/255, green: 140/255, blue: 0, alpha: 1.0)
        
        titleView.addSubview(titleLabel)
        
        self.view.addSubview(titleView)
        
        
        
        var goalView = UIView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height*1/3, UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height*1/3))
        
        goalView.backgroundColor = UIColor(red: 168/255, green: 225/255, blue: 193/255, alpha: 1.0)
        
        var goalLabel = UILabel(frame: CGRectMake(0, 0, goalView.frame.size.width, goalView.frame.size.height))
        
        goalLabel.text = "Our Goal Is"
        
        goalLabel.textAlignment = NSTextAlignment.Center
        
        goalLabel.font = UIFont.systemFontOfSize(27)
        
        goalLabel.textColor = UIColor(red: 0, green: 224/255, blue: 98/255, alpha: 1.0)
        
        goalView.addSubview(goalLabel)
        
        self.view.addSubview(goalView)
        
        
        
        var todoView = UIView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height*1/3, UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height*1/3))
        
        todoView.backgroundColor = UIColor(red: 190/255, green: 240/255, blue: 253/255, alpha: 1.0)
        
        var todoLabel = UILabel(frame: CGRectMake(0, 0, todoView.frame.size.width, todoView.frame.size.height))
        
        todoLabel.text = "To Do Good"
        
        todoLabel.textAlignment = NSTextAlignment.Center
        
        todoLabel.font = UIFont.systemFontOfSize(27)
        
        todoLabel.textColor = UIColor(red: 0, green: 202/255, blue: 253/255, alpha: 1.0)
        
        todoView.addSubview(todoLabel)
        
        self.view.addSubview(todoView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
