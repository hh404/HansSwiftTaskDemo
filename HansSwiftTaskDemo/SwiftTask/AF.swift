//
//  AF.swift
//  HansSwiftTaskDemo
//
//  Created by huangjianwu on 2018/4/22.
//  Copyright © 2018年 huangjianwu. All rights reserved.
//

import UIKit
import Alamofire

typealias Progress1 = (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
//typealias Value = String
//typealias Error = NSError

typealias AlamofireTask = Task<Progress1, Value, Error>

class AF: NSObject {
    func test()  {
        // define task
        let task = AlamofireTask { progress, fulfill, reject, configure in
           // Alamofire.down
//            let request = Alamofire.download(.GET, URLString: "http://httpbin.org/stream/100", destination: Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask))
//
//            request
//                .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
//                    progress((bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) as Progress)
//                }
//                .response { (request, response, data, error) in
//
//                    // print
//                    data
//                    error?.localizedDescription
//
//                    if let error = error {
//                        reject(error)
//                        return
//                    }
//
//                    fulfill("OK")
//
//            }
        }
        
        task
            .progress { oldProgress, newProgress in
                // print
                newProgress.bytesWritten
                newProgress.totalBytesWritten
            }
            .then { value, errorInfo -> String in
                if let errorInfo = errorInfo {
                    return "ERROR: \(errorInfo.error!.domain)"
                }
                
                return "\(value!) World"
        }
    }
}
