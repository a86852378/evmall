//
//  Store.swift
//  mall
//
//  Created by eVideo on 29/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class Store {
    var vid: Int = 0
    var id: Int = 0
    var storeName: String = ""
    var storeState: Datadict = Datadict()
    var storeTime: String = ""
    var bindAllGc: Bool = false
    var seller: Seller = Seller()
    var agent: Agent = Agent()
    var tradingArea: TradingArea = TradingArea()
    
    init(){}
    init(json: AnyObject){
        if let objKey = json.objectForKey("vid"){self.vid = objKey as! Int}
        if let objKey = json.objectForKey("id"){self.id = objKey as! Int}
        if let objKey = json.objectForKey("storeName"){self.storeName = objKey as! String}
        if let objKey = json.objectForKey("storeState"){self.storeState = Datadict(json: objKey)}
        if let objKey = json.objectForKey("storeTime"){self.storeTime = objKey as! String}
        if let objKey = json.objectForKey("bindAllGc"){self.bindAllGc = objKey as! Bool}
        if let objKey = json.objectForKey("seller"){self.seller = Seller(json: objKey)}
        if let objKey = json.objectForKey("agent"){self.agent = Agent(json: objKey)}
        if let objKey = json.objectForKey("tradingArea"){self.tradingArea = TradingArea(json: objKey)}
    }
}
