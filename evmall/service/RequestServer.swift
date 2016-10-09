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
    func netRequest(modelName: String, completion: @escaping (_ array: [AnyObject]) -> ()) {
        let request = NSMutableURLRequest()                             //request请求包
        request.url = NSURL(string: url+modelName) as URL?
        request.setValue("application/json;", forHTTPHeaderField: "Content-Type")
        request.addValue(key, forHTTPHeaderField: "VendorToken")
        request.httpMethod = "GET"
        let session = URLSession.shared                                              //初始化session
        session.dataTask(with: request as URLRequest){(data, response, error) -> Void in
            if(response != nil){
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                if statusCode == 200 {
                    let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    self.objArray = jsonConvertToModel(json: json as AnyObject, lastUrl: modelName)
                    completion(self.objArray)
                }
            }
            }.resume()
        }
}
    



