//
//  RequestProtocol.swift
//  mall
//
//  Created by eVideo on 24/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class Service {
    static let serviceController = Service()                                          //设计单例模式
    
    private init(){}
    
//    func createData(obj: AnyObject, lastUrl: String, id: String?, key: String){
//        let method = "POST"
//        
//        netRequestController.selectMethod(obj, method: method, lastUrl: lastUrl, id: id, key: key) { (array) in
//        }
//    }
//    
//    func modifyData(obj: AnyObject,lastUrl: String, id: String, key: String) {
//        let method = "PATCH"
//        
//        netRequestController.selectMethod(obj, method: method, lastUrl: lastUrl, id: id, key: key) { (array) in
//        }
//    }
//    
    func getData(completion: (array: [AnyObject]) -> ()) {
        netRequestController.netRequest(){ (array) in
            completion(array: array)
 }
    }

}