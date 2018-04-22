//
//  ViewController.swift
//  HansSwiftTaskDemo
//
//  Created by huangjianwu on 2018/4/22.
//  Copyright © 2018年 huangjianwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let task = MyTask(value: "Hello")
            .success { value -> String in
                return "\(value) World"
            }
            .success { value -> String in
                return "\(value)!!!"
        }
        
        //MyTask(value: 1)
        task.value
        
        //--------------------------------------------------
        // Example 2: Sync rejected -> success -> failure
        //--------------------------------------------------
        
        let task2a = MyTask(error: myError)
            .success { value -> String in
                return "Never reaches here..."
        }
        let task2b = task2a
            .failure { error, isCancelled -> String in
                return "ERROR: \(error!.domain)"    // recovery from failure
        }
        
         print(task2a.value)
        print(task2a.errorInfo)
        print(task2b.value)
        print(task2b.errorInfo)
        
        //--------------------------------------------------
        // Example 3: Sync fulfilled or rejected -> then
        //--------------------------------------------------
        
        // fulfills or rejects immediately
        let task3a = MyTask { progress, fulfill, reject, configure in
            if arc4random_uniform(2) == 0 {
                fulfill("Hello")
            }
            else {
                reject(myError)
            }
        }
        let task3b = task3a
            .then { value, errorInfo -> String in
                if let errorInfo = errorInfo {
                    return "ERROR: \(errorInfo.error!.domain)"
                }
                
                return "\(value!) World"
        }
        
        print(task3a.value)
        print(task3a.errorInfo)
        print(task3b.value)
        print(task3b.errorInfo)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



typealias Progress = Float
typealias Value = String
typealias Error = NSError

typealias MyTask = Task<Progress, Value, Error>

let myError = NSError(domain: "MyErrorDomain", code: 0, userInfo: nil)

//--------------------------------------------------
// Example 1: Sync fulfilled -> success
//--------------------------------------------------

