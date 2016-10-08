//
//  AdvImage.swift
//  evmall
//
//  Created by eVideo on 22/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

import UIKit

class Advertising {
    var pictureUrl: String = ""
    var linkUrl: String = ""
    
    init(){}
    init(json: AnyObject) {
        if let objKey = json.object(forKey: "pictureUrl"){self.pictureUrl = objKey as! String}
        if let objKey = json.object(forKey: "linkUrl"){self.linkUrl = objKey as! String}
    }
}

