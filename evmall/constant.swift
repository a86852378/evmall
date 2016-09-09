//
//  constant.swift
//  evmall-swift
//
//  Created by eVideo on 7/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import Foundation

//let url = "http://192.168.161.91:19110/api/tradingarea"
let url = "http://45.63.122.60:19110/api/goodsclass/"        //url的前一部分
//var lastUrl = "tradingarea"
//var id = "767656147040583680"
//var lastUrl = "goodsclass"                                //url的后一部分，作为对返回的数据做何种处理的依据
var key = "123123"                                          //请求头的键值
let netRequestController = RequestServer.netRequestController   //创建单例网络请求控制器
let serviceController = Service.serviceController