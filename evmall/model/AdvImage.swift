//
//  AdvImage.swift
//  evmall
//
//  Created by eVideo on 22/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

import UIKit

class AdvImage {
    var image: String = ""
    
    init(){}
    init(json: AnyObject) {
        if let objKey = json.objectForKey("image"){self.image = objKey as! String}
    }
}

