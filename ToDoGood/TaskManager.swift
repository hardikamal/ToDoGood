//
//  TaskManager.swift
//  ToDoGood
//
//  Created by Keshav Rao on 10/4/14.
//  Copyright (c) 2014 Keshav Rao. All rights reserved.
//
//


import UIKit

var taskMngr: TaskManager = TaskManager()

struct task{
    var name = "task"
    var desc = "deadline"
    var strtDate = "currentDate"
    var amnt = "motivationLevel"
}

class TaskManager: NSObject {
    var tasks = [task]()
    
    //Add a task with this function
    func addTask(name: String , desc:String, strtDate: String, amnt:String){
        tasks.append(task(name: name, desc: desc, strtDate: strtDate, amnt: amnt))
    }
}
