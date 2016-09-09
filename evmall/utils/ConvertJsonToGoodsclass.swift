//
//  ProcessDataAsGoods.swift
//  mall
//
//  Created by eVideo on 15/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class ConvertJsonToGoodsclass {
    //将返回的数据data转化为Goods类
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
}