//
//  TradingAreaService.swift
//  mall
//
//  Created by eVideo on 18/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class ConvertJsonToTradingArea {
    //将返回的数据data转化为Goods类
    func convertJsonToTradingArea(json: AnyObject) -> [TradingArea] {
        var tradingAreaArray: [TradingArea] = []
        
        switch json.objectForKey("data") {
        case let ary as NSArray:
            for i in 0..<ary.count{
                let tradingArea = TradingArea(json: ary[i])
                tradingAreaArray.append(tradingArea)
            }
        default:
            let tradingArea = TradingArea(json: json)
            tradingAreaArray.append(tradingArea)
        }
        return tradingAreaArray
    }
}
