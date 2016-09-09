//
//  TradingAreaCommunities.swift
//  mall
//
//  Created by eVideo on 18/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class TradingAreaCommunity {
    var vid: Int = 0                                       //社区类别ID
    var id: Int = 0                                        //社区ID
    var tradingAreaId: Int = 0                             //商圈ID
    var communityCode: String = ""                         //商圈社区码
    //返回输出格式字符串的方法
//    func description() ->String {
//        return "\n\n\t\tvid:\(self.vid),\n \n\t\tid:\(self.id),\n \n\t\ttradingAreaId:\(self.tradingAreaId),\n \n\t\tcommunityCode:\(self.communityCode)"
//    }
    
    init(){}
    //通过json数据将对象初始化
    init(json: AnyObject){
        if let objKey = json.objectForKey("vid"){self.vid = objKey as! Int}
        if let objKey = json.objectForKey("id"){self.id = objKey as! Int}
        if let objKey = json.objectForKey("tradingAreaId"){self.tradingAreaId = objKey as! Int}
        if let objKey = json.objectForKey("communityCode"){self.communityCode = objKey as! String}
    }
}
