//
//  AgentTradingAreas.swift
//  mall
//
//  Created by eVideo on 25/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class AgentTradingAreas {
    var vid: Int = 0
    var id: Int = 0
    var tradingArea: TradingArea = TradingArea()
//    func description() ->String {
//        return "Data:\n \n\tvid:\(self.vid),\n \n\tid:\(self.id),\n \n\ttradingArea:"
//    }

    init(){}
    init(json: AnyObject){
        if let objKey = json.objectForKey("vid"){self.vid = objKey as! Int}
        if let objKey = json.objectForKey("id"){self.id = objKey as! Int}
        if let objKey = json.objectForKey("tradingArea"){self.tradingArea = TradingArea(json: objKey)}
    }
}