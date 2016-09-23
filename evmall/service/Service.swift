//
//  RequestProtocol.swift
//  mall
//
//  Created by eVideo on 24/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit


public func getData(modelName:String, completion: (array: [AnyObject]) -> ()) {
    netRequestController.netRequest(modelName){ (array) in
        completion(array: array)
    }
}

public func jsonConvertToModel(json: AnyObject, lastUrl: String) -> [AnyObject] {
    let objArray: [AnyObject] = []
    var goodsclassArray: [Goodsclass] = []
    var goodsArray: [Goods] = []
    var advertisingArray: [Advertising] = []
    switch lastUrl {
    case "goodsclass":
        for i in 0..<json.count{
            let goodsclass = Goodsclass(json: json[i])
            goodsclassArray.append(goodsclass)
        }
        return goodsclassArray
    case "goods":
        for i in 0..<json.objectForKey("data")!.count{
            let goods = Goods(json: json.objectForKey("data")![i])
            goodsArray.append(goods)
        }
        return goodsArray
    case "advertising":
        for i in 0..<json.count{
            let advertising = Advertising(json: json[i])
            advertisingArray.append(advertising)
        }
        return advertisingArray
    default:
        return objArray
    }
}
