//
//  ModelToDictionary.swift
//  mall
//
//  Created by eVideo on 23/8/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class ConvertModelToDictionary {
    //将实例转化为字典
    func transformDictionary(modelDemo: AnyObject) -> NSDictionary {
        
        let dictionaryDemo: NSMutableDictionary = [:]
        let mirror = Mirror.init(reflecting: modelDemo)                             //通过镜像遍历实例的所有属性
        
        for m in mirror.children{                                                   //将属性一一添加到字典里
            switch m.value {
            case let ary as NSArray:
                var tradingAreaCommunitiesArray: Array<NSDictionary> = []
                for i in 0..<ary.count{
                    var tradingAreaCommunitiesDict: NSDictionary
                    tradingAreaCommunitiesDict = transformDictionary(modelDemo: ary[i] as AnyObject)
                    tradingAreaCommunitiesArray.append(tradingAreaCommunitiesDict)
                }
                dictionaryDemo.setValue(tradingAreaCommunitiesArray, forKey: m.label!)
            case let dict as NSDictionary:
                dictionaryDemo.setValue(transformDictionary(modelDemo: dict), forKey: m.label!)
            case let int as Int:
                if(int != 0){
                    dictionaryDemo.setValue(int, forKey: m.label!)
                }
                else {break}
            case let string as String:
                if(string != ""){
                    dictionaryDemo.setValue(string, forKey: m.label!)
                }
                else {break}
            case let bool as Bool:
                if(bool != false){
                    dictionaryDemo.setValue(bool, forKey: m.label!)
                }
                else {break}
            default:break
            }
        }
        return dictionaryDemo
    }
}
