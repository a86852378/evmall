//
//  RequestController.swift
//  mall
//
//  Created by eVideo on 15/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class RequestServer {
    
    var objArray: [AnyObject] = []
    static let netRequestController = RequestServer()                                          //设计单例模式
    
    private init(){}
    

    //request请求包的封装和GET网络请求方法的调用
    func netRequest(modelName: String, completion: (array: [AnyObject]) -> ()) {
        let request = NSMutableURLRequest()                             //request请求包
        request.URL = NSURL(string: url)
        request.setValue("application/json;", forHTTPHeaderField: "Content-Type")
        request.addValue(key, forHTTPHeaderField: "VendorToken")
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()                                              //初始化session
        session.dataTaskWithRequest(request){(data, response, error) -> Void in
            print(response)
            if let data = data{
                let json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                print(json)
                self.objArray = jsonConvertToModel(self.objArray, lastUrl: modelName)
                completion(array: self.objArray)
            }
            }.resume()
        }
}
    



