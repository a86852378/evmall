//
//  ViewController.swift
//  evmall-swift
//
//  Created by eVideo on 7/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController{


    var pageControl = UIPageControl()
    var scrollView = UIScrollView()
//    let pageControl = UIPageControl()
    var timer: NSTimer?
    var rollingTime: NSTimeInterval = 3.0
    
    var array: [Goodsclass] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
//        serviceController.getData(){(array) in
//            self.array = array as! [Goodsclass]
//            dispatch_async(dispatch_get_main_queue(),{self.collectionView.reloadData()})
//        }
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = UIColor.whiteColor()
//        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollEnabled = true
        scrollView.frame = CGRectMake(0, 0, 320, 150)
        for i in 0...4{
            var picName = "广告"
            switch i {
            case 0:
                picName = picName + "3"
            case 4:
                picName = picName + "1"
            default:
                picName = picName + i.description
            }
            let imageView =  UIImageView(image: UIImage(named: picName))
            
            imageView.frame = CGRectMake(scrollView.frame.width*CGFloat(i), 0, scrollView.frame.width, scrollView.frame.height)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSizeMake(scrollView.frame.width*5,scrollView.frame.height)
        scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.delegate = self
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.frame = CGRectMake(260, 130, 40, 10)
        pageControl.addTarget(self, action: #selector(pageChanged(_:)),forControlEvents: UIControlEvents.ValueChanged)
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(self.rollingTime, target: self, selector: #selector(self.next), userInfo: nil, repeats: true)
                    NSRunLoop.currentRunLoop().run()
                }
        cell.addSubview(scrollView)
        cell.addSubview(pageControl)
        return cell
    }

    
    func next() {
       scrollView.setContentOffset(CGPoint(x: (scrollView.frame.width * CGFloat(self.pageControl.currentPage + 2)), y: 0), animated: true)
    }
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offsetX = scrollView.contentOffset.x
            if offsetX == 0 {
                scrollView.contentOffset = CGPointMake(scrollView.frame.width * CGFloat(3), 0)
            }
            if offsetX == scrollView.frame.width * CGFloat(4) {
                scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
            }
            let currentPage = scrollView.contentOffset.x / scrollView.frame.width - 1
            self.pageControl.currentPage = Int(currentPage)
        }
    }
    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offsetX = scrollView.contentOffset.x
            if offsetX == 0 {
                scrollView.contentOffset = CGPointMake(scrollView.frame.width * CGFloat(3), 0)
            }
            if offsetX == scrollView.frame.width * CGFloat(4) {
                scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
            }
            let currentPage = scrollView.contentOffset.x / scrollView.frame.width - 1
            self.pageControl.currentPage = Int(currentPage)
        }
    }
    
    func pageChanged(sender:UIPageControl) {
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated:true)
    }

    
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

