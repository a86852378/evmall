//
//  Goods.swift
//  evmall
//
//  Created by eVideo on 22/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class Goods {
    
    var goodsName: String = ""
    var goodsJingle: String = ""
    var goodsPrice: Double = 0
    var goodsSaleNum: Int = 0
    var goodsStorage: Int = 0
    var goodsImage: String = ""
    
    init(){}
    init(json: AnyObject) {
        if let objKey = json.objectForKey("goodsName"){self.goodsName = objKey as! String}
        if let objKey = json.objectForKey("goodsJingle"){self.goodsJingle = objKey as! String}
        if let objKey = json.objectForKey("goodsPrice"){self.goodsPrice = objKey as! Double}
        if let objKey = json.objectForKey("goodsSaleNum"){self.goodsSaleNum = objKey as! Int}
        if let objKey = json.objectForKey("goodsStorage"){self.goodsStorage = objKey as! Int}
        if let objKey = json.objectForKey("goodsImage"){self.goodsImage = objKey as! String}
    }
}