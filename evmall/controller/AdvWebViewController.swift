//
//  AdvWebViewController.swift
//  evmall
//
//  Created by eVideo on 29/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class AdvWebViewController: UIViewController{
    var webView: UIWebView = UIWebView()
    var advertising: Advertising = Advertising()
    override func viewDidLoad() {
        webView.frame = self.view.bounds
        let webUrl = NSURL(string: advertising.linkUrl)
        let webRequest = NSURLRequest(url: webUrl! as URL)
        webView.loadRequest(webRequest as URLRequest)
        self.view.addSubview(webView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
