//
//  ConvertJsonToStore.swift
//  mall
//
//  Created by eVideo on 29/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class ConvertJsonToStore {
    func convertJsonToStore(json: AnyObject) ->[Store] {
        var storeArray: [Store] = []
        
        switch json.objectForKey("data") {
        case let ary as NSArray:
            for i in 0..<ary.count{
                let store = Store(json: ary[i])
                storeArray.append(store)
            }
        default:
            let store = Store(json: json)
            storeArray.append(store)
        }
        return storeArray
    }

}
