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
    var gcImage: String = ""
    
    init(){}
    init(json: AnyObject) {
        if let objKey = json.objectForKey("gcName"){self.gcName = objKey as! String}
        if let objKey = json.objectForKey("gcImage"){self.gcImage = objKey as! String}
        
    }
}