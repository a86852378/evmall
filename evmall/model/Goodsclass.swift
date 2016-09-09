//
//  Goods.swift
//  mall
//
//  Created by eVideo on 15/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class Goodsclass {
    var vid: Int = 0                             //类别ID
    var id: Int = 0                              //ID
    var gcName: String = ""                      //分类名称
    var typeId: Int = 0                          //类型ID
    var typeName: String = ""                    //类型名称
    var gcParentId: Int = 0                      //父ID
    var commisRate: Double = 0.0                 //佣金比例
    var gcSort: Int = 0                          //排序
    var gcDeep: Int = 0
    var gcVirtual: Bool = false                  //是否允许发布虚拟商品，1是，0否
    var gcTitle: String = ""                     //名称
    var gcKeywords: String = ""                  //关键词
    var gcDescription: String = ""               //描述
    var delete: Bool = false
//    //返回输出格式字符串的方法
//    func description() ->String {
//        return "Goods: \n\n\tvid:\(self.vid),\n \n\tid:\(self.id),\n \n\tgcName:\(self.gcName),\n \n\ttypeId:\(self.typeId),\n \n\ttypeName:\(self.typeName),\n \n\tgcParentId:\(self.gcParentId),\n \n\tcommisRate:\(self.commisRate),\n \n\tgcSort:\(self.gcSort),\n \n\tgcVirtual:\(self.gcVirtual),\n \n\tgcTitle:\(self.gcTitle),\n \n\tgcKeywords:\(self.gcKeywords),\n \n\tgcDescription:\(self.gcDescription)"
//    }
    
    init(){}
    //通过json数据将对象初始化
    init(json: AnyObject) {
        if let objKey = json.objectForKey("vid"){self.vid = objKey as! Int}
        if let objKey = json.objectForKey("id"){self.id = objKey as! Int}
        if let objKey = json.objectForKey("gcName"){self.gcName = objKey as! String}
        if let objKey = json.objectForKey("typeId"){self.typeId = objKey as! Int}
        if let objKey = json.objectForKey("typeName"){self.typeName = objKey as! String}
        if let objKey = json.objectForKey("gcParentId"){self.gcParentId = objKey as! Int}
        if let objKey = json.objectForKey("commisRate"){self.commisRate = objKey as! Double}
        if let objKey = json.objectForKey("gcSort"){self.gcSort = objKey as! Int}
        if let objKey = json.objectForKey("gcDeep"){self.gcDeep = objKey as! Int}
        if let objKey = json.objectForKey("gcVirtual"){self.gcVirtual = objKey as! Bool}
        if let objKey = json.objectForKey("gcTitle"){self.gcTitle = objKey as! String}
        if let objKey = json.objectForKey("gcKeywords"){self.gcKeywords = objKey as! String}
        if let objKey = json.objectForKey("gcDescription"){self.gcDescription = objKey as! String}
        if let objKey = json.objectForKey("delete"){self.delete = objKey as! Bool}
    }
}