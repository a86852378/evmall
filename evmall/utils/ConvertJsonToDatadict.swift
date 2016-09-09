//
//  ConvertJsonToDatadict.swift
//  mall
//
//  Created by eVideo on 29/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class ConvertJsonToDatadict {
    func convertJsonToDatadict(json: AnyObject) -> [Datadict] {
        var datadictArray: [Datadict] = []
        switch json {
        case let ary as NSArray:
            for i in 0..<ary.count{
                let datadict = Datadict(json: ary[i])
                datadictArray.append(datadict)
            }
        case let dict as NSDictionary:
            let datadict = Datadict(json: dict)
            datadictArray.append(datadict)
        default:break
        }
        return datadictArray
    }
}
