//
//  jsonConverToModel.swift
//  mall
//
//  Created by eVideo on 25/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import Foundation

class ConvertJsonToModel {
    func jsonConvertToTradingArea(json: AnyObject, lastUrl: String) -> [AnyObject] {
        var objArray: [AnyObject] = []
        switch lastUrl {
        case "goodsclass":
            objArray = ConvertJsonToGoodsclass().convertJsonToGoodsclass(json)
        case "store":
            objArray = ConvertJsonToStore().convertJsonToStore(json)
        case "datadict":
            objArray = ConvertJsonToDatadict().convertJsonToDatadict(json)
        case "agent":
            objArray = ConvertJsonToAgent().convertJsonToAgent(json)
        case "tradingarea":
            objArray = ConvertJsonToTradingArea().convertJsonToTradingArea(json)
        default:
            break
        }
        return objArray
    }
}