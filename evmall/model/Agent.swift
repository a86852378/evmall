//
//  Agent.swift
//  mall
//
//  Created by eVideo on 25/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class Agent {
    var vid: Int = 0
    var id: Int = 0
    var agentName: String = ""
    var agentIsSuper: Bool = false
    var openId: String = ""
    var agentTradingAreas: [AgentTradingAreas] = []
//    func description() ->String {
//        return "Goods: \n\n\tvid:\(self.vid),\n \n\tid:\(self.id),\n \n\tagentName:\(self.agentName),\n \n\tagentIsSuper:\(self.agentIsSuper),\n \n\topenId:\(self.openId),\n \n\tagentTradingAreas:"
//    }
    
    init(){}
    init(json: AnyObject){
        if let objKey = json.objectForKey("vid"){self.vid = objKey as! Int}
        if let objKey = json.objectForKey("id"){self.id = objKey as! Int}
        if let objKey = json.objectForKey("agentName"){self.agentName = objKey as! String}
        if let objKey = json.objectForKey("agentIsSuper"){self.agentIsSuper = objKey as! Bool}
        if let objKey = json.objectForKey("openId"){self.openId = objKey as! String}
        if(json.objectForKey("agentTradingAreas")?.count != 0){
            for i in 0..<json.objectForKey("agentTradingAreas")!.count{
                let agentTras = AgentTradingAreas(json: json.objectForKey("agentTradingAreas")![i])
                self.agentTradingAreas.append(agentTras)
            }
        }
    }
}
