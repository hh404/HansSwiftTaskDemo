//
//  AsyncTest.swift
//  HansSwiftTaskDemo
//
//  Created by huangjianwu on 2018/4/22.
//  Copyright © 2018年 huangjianwu. All rights reserved.
//

import UIKit
import Foundation



class AsyncTest: NSObject {
    func test() {
        // for async test
        //XCPSetExecutionShouldContinueIndefinitely()
        
        // fulfills after 100ms
        func asyncTask(value: String) -> MyTask
        {
            return MyTask { progress, fulfill, reject, configure in
//                DispatchQueue.main.after(when: .now() + 0.001) {
//                    fulfill(value)
//                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    fulfill(value)
                })
            }
        }
        
        //--------------------------------------------------
        // Example 1: Async
        //--------------------------------------------------
        
        let task1a = asyncTask(value: "Hello")
        let task1b = task1a
            .success { value -> String in
                return "\(value) World"
        }
        
        // NOTE: these values should be all nil because task is async
        task1a.value
        task1a.errorInfo
        task1b.value
        task1b.errorInfo
        
        //--------------------------------------------------
        // Example 2: Async chaining
        //--------------------------------------------------
        
        let task2a = asyncTask(value: "Hello")
        let task2b = task2a
            .success { value -> MyTask in
                return asyncTask(value: "\(value) Cruel")  // next async
            }
            .success { value -> String in
                return "\(value) World"
        }

    }
}
