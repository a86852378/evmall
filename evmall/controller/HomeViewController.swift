//
//  ViewController.swift
//  evmall-swift
//
//  Created by eVideo on 7/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    var array: [Goodsclass] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        serviceController.getData(){(array) in
            self.array = array as! [Goodsclass]
            dispatch_async(dispatch_get_main_queue(),{self.collectionView.reloadData()})
        }
//        tableView.dataSource = self
//        tableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        
//        return cell
//    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.array.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        (cell.contentView.viewWithTag(101) as! UIImageView).image = UIImage(named: String(self.array[indexPath.row].id))
        (cell.viewWithTag(201) as! UILabel).text = self.array[indexPath.row].gcName
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 15, 10, 15)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
    }
}

