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
    var objArray: [AnyObject] = []
    switch lastUrl {
    case "goodsclass":
        objArray = convertJsonToGoodsclass(json)
    default:
        break
    }
    return objArray
}

func convertJsonToGoodsclass(json: AnyObject) -> [Goodsclass] {
    var goodsclassArray: [Goodsclass] = []
    switch json {
    case let ary as NSArray:
        for i in 0..<ary.count{
            let goodsclass = Goodsclass(json: ary[i])
            goodsclassArray.append(goodsclass)
        }
    case let dict as NSDictionary:
        let goodsclass = Goodsclass(json: dict)
        goodsclassArray.append(goodsclass)
    default:break
    }
    return goodsclassArray
}