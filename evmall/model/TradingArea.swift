//
//  TradingArea.swift
//  mall
//
//  Created by eVideo on 18/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class TradingArea {
    var vid: Int = 0                                                   //商圈类别ID
    var id: Int = 0                                                    //商圈ID
    var tradingAreaname: String = ""                                   //商圈名称
    var cityId: Int = 0                                                //所属城市
    var tradingAreaCommunities: [TradingAreaCommunity] = []            //商圈社区
    //返回输出格式字符串的方法
//    func description() ->String {
//        return "Data:\n \n\tvid:\(self.vid),\n \n\tid:\(self.id),\n \n\ttradingAreaname:\(self.tradingAreaname),\n \n\ttradingAreaCommunities:"
//    }

    init(){}
    //通过json数据将对象初始化
    init(json: AnyObject){
        if let objKey = json.objectForKey("vid"){self.vid = objKey as! Int}
        if let objKey = json.objectForKey("id"){self.id = objKey as! Int}
        if let objKey = json.objectForKey("tradingAreaname"){self.tradingAreaname = objKey as! String}
        if let objKey = json.objectForKey("cityId"){self.cityId = objKey as! Int}
        if(json.objectForKey("tradingAreaCommunities")?.count != 0){
            for i in 0..<json.objectForKey("tradingAreaCommunities")!.count{
                let trading = TradingAreaCommunity(json: json.objectForKey("tradingAreaCommunities")![i])
                self.tradingAreaCommunities.append(trading)
            }
        }
    }
}
