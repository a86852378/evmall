//
//  AgentService.swift
//  mall
//
//  Created by eVideo on 25/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class ConvertJsonToAgent  {
    //将返回的数据data转化为Goods类
    func convertJsonToAgent(json: AnyObject) ->[Agent] {
        var agentArray: [Agent] = []
        
        switch json.objectForKey("data") {
        case let ary as NSArray:
            for i in 0..<ary.count{
                let agent = Agent(json: ary[i])
                agentArray.append(agent)
            }
        default:
            let agent = Agent(json: json)
            agentArray.append(agent)
        }
        return agentArray
    }
}
