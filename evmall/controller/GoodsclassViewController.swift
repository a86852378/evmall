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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goodsclassCell")
        cell?.backgroundColor = UIColor.black
        return cell!
    }
}
