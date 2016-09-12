//
//  ViewController.swift
//  evmall-swift
//
//  Created by eVideo on 7/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UIScrollViewDelegate {



    @IBOutlet weak var scrollView: UIScrollView!
    let pageControl = UIPageControl()
    
    var array: [Goodsclass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(scrollView.frame.width*3,scrollView.frame.height)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollEnabled = true
        for i in 1...3{
            let imageView =  UIImageView(image: UIImage(named: "广告\(i)"))
            imageView.frame = CGRectMake(scrollView.frame.width*CGFloat(i-1), 0, scrollView.frame.width, scrollView.frame.height)
            scrollView.addSubview(imageView)
        }
        self.view.addSubview(scrollView)
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets = false
        pageControl.frame = CGRectMake(260, 115, 30, 30)
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.addTarget(self, action: #selector(pageChanged(_:)),forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(pageControl)
        
//        serviceController.getData(){(array) in
//            self.array = array as! [Goodsclass]
//            dispatch_async(dispatch_get_main_queue(),{self.collectionView.reloadData()})
//        }
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = UIColor.whiteColor()
//        

//        tableView.dataSource = self
//        tableView.delegate = self
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = (scrollView.contentOffset.x + self.view.frame.width / 2) / self.view.frame.width
        
        pageControl.currentPage = Int(index)
    }
    func pageChanged(sender:UIPageControl) {
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated:true)
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
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    {
//        return self.array.count
//    }
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
//    {
//        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
//        (cell.contentView.viewWithTag(101) as! UIImageView).image = UIImage(named: String(self.array[indexPath.row].id))
//        (cell.viewWithTag(201) as! UILabel).text = self.array[indexPath.row].gcName
//        cell.backgroundColor = UIColor.whiteColor()
//        return cell
//    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
//        return UIEdgeInsetsMake(10, 15, 10, 15)
//    }
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
//    {
//        //点击事件
//    }
}

