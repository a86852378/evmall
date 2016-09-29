//
//  GoodsclassViewController.swift
//  evmall
//
//  Created by eVideo on 29/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class GoodsclassViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var goodsclassID: Int = 0
    override func viewDidLoad() {
        print(goodsclassID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("goodsclassCell")
        cell?.backgroundColor = UIColor.blackColor()
        return cell!
    }
}
