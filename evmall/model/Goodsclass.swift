//
//  Goods.swift
//  mall
//
//  Created by eVideo on 15/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class Goodsclass {
    var gcName: String = ""
    var iconUrl: String = ""
    
    init(){}
    init(json: AnyObject) {
        if let objKey = json.object(forKey: "gcName"){self.gcName = objKey as! String}
        if let objKey = json.object(forKey: "iconUrl"){self.iconUrl = objKey as! String}
    }
}
