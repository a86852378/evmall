//
//  StoreState.swift
//  mall
//
//  Created by eVideo on 29/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class Datadict {
    var vid: Int = 0
    var id: Int = 0
    var dictName: String = ""
    var dictClassId: String = ""
    var dictClassName: String = ""
    var entryId: String = ""
    var entryName: String = ""
    
    init(){}
    init(json: AnyObject){
        if let objKey = json.objectForKey("vid"){self.vid = objKey as! Int}
        if let objKey = json.objectForKey("id"){self.id = objKey as! Int}
        if let objKey = json.objectForKey("dictName"){self.dictName = objKey as! String}
        if let objKey = json.objectForKey("dictClassId"){self.dictClassId = objKey as! String}
        if let objKey = json.objectForKey("dictClassName"){self.dictClassName = objKey as! String}
        if let objKey = json.objectForKey("entryId"){self.entryId = objKey as! String}
        if let objKey = json.objectForKey("entryName"){self.entryName = objKey as! String}
    }
}