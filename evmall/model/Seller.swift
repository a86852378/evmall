//
//  Seller.swift
//  mall
//
//  Created by eVideo on 29/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class Seller {
    var vid: Int = 0
    var id: Int = 0
    var sellerName: String = ""
    var openId: String = ""
    
    init(){}
    init(json: AnyObject){
        if let objKey = json.objectForKey("vid"){self.vid = objKey as! Int}
        if let objKey = json.objectForKey("id"){self.id = objKey as! Int}
        if let objKey = json.objectForKey("sellerName"){self.sellerName = objKey as! String}
        if let objKey = json.objectForKey("openId"){self.openId = objKey as! String}
    }
}
