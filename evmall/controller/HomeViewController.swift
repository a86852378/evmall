//
//  ViewController.swift
//  evmall-swift
//
//  Created by eVideo on 7/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource{

    var pageControl = UIPageControl()
    var scrollView = UIScrollView()
    var goodsclassCollectionView = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: UICollectionViewFlowLayout())
    var goodsCollectionView = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: UICollectionViewFlowLayout())
    var timer: NSTimer?
    var rollingTime: NSTimeInterval = 3.0
    var advertisingArray: [Advertising] = []
    var goodsclassArray: [Goodsclass] = []
    var goodsArray: [Goods] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSThread.detachNewThreadSelector(#selector(self.loadData), toTarget: self, withObject: nil)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData() {
        getData("advertising"){(array) in
            self.advertisingArray = array as! [Advertising]
        }
        getData("goodsclass"){(array) in
            self.goodsclassArray = array as! [Goodsclass]
//            dispatch_async(dispatch_get_main_queue(),{self.goodsclassCollectionView.reloadData()})
        }
        getData("goods"){(array) in
            self.goodsArray = array as! [Goods]
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 0
        if(indexPath.row == 0){
            height = 120
        }
        else if(indexPath.row == 1){
            height = 130
        }
        else if(indexPath.row == 2){
            height = 130
        }
        return height
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //广告自动循环轮播
        if(indexPath.row == 0){
            scrollView.pagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.scrollEnabled = true
            scrollView.frame = CGRectMake(0, 0, 320, 120)
            print(self.advertisingArray.count)
            for i in 0...self.advertisingArray.count+1 {
                let imageUrlString:String
                switch i {
                case 0:
                    imageUrlString = self.advertisingArray[self.advertisingArray.count-1].pictureUrl
                case self.advertisingArray.count+1:
                    imageUrlString = self.advertisingArray[0].pictureUrl
                default:
                    imageUrlString = self.advertisingArray[i-1].pictureUrl
                }
                let url:NSURL! = NSURL(string: imageUrlString)
                let data:NSData! = NSData(contentsOfURL: url)
                let image = UIImage(data: data)
                let imageView =  UIImageView(image: image)
                
                imageView.frame = CGRectMake(self.scrollView.frame.width*CGFloat(i), 0, self.scrollView.frame.width, self.scrollView.frame.height)
                scrollView.addSubview(imageView)
            }
            pageControl.numberOfPages = self.advertisingArray.count
            scrollView.contentSize = CGSizeMake(self.scrollView.frame.width*CGFloat(self.advertisingArray.count+2),self.scrollView.frame.height)

            scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
            self.edgesForExtendedLayout = UIRectEdge.None
            self.automaticallyAdjustsScrollViewInsets = false
            scrollView.delegate = self
            pageControl.currentPageIndicatorTintColor = UIColor.redColor()
            pageControl.pageIndicatorTintColor = UIColor.whiteColor()
            pageControl.frame = CGRectMake(260, 100, 40, 10)
            pageControl.addTarget(self, action: #selector(pageChanged(_:)),forControlEvents: UIControlEvents.ValueChanged)
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(self.rollingTime, target: self, selector: #selector(self.next), userInfo: nil, repeats: true)
                    NSRunLoop.currentRunLoop().run()
                }
            cell.addSubview(scrollView)
            cell.addSubview(pageControl)
        }
        //商品大类窗口
        else if(indexPath.row == 1){
            goodsclassCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "goodsclassCell")
            dispatch_async(dispatch_get_main_queue(),{self.goodsclassCollectionView.reloadData()})
            goodsclassCollectionView.frame = CGRectMake(0, 0, 320, 130)
            goodsclassCollectionView.backgroundColor = UIColor.whiteColor()
            goodsclassCollectionView.delegate = self
            goodsclassCollectionView.dataSource = self
            cell.addSubview(goodsclassCollectionView)
        }
        else if(indexPath.row == 2){
            goodsCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "goodsCell")
            dispatch_async(dispatch_get_main_queue(),{self.goodsCollectionView.reloadData()})
            goodsCollectionView.frame = CGRectMake(0, 0, 320, 130)
            goodsCollectionView.backgroundColor = UIColor.whiteColor()
            goodsCollectionView.delegate = self
            goodsCollectionView.dataSource = self
            cell.addSubview(goodsCollectionView)
        }
        return cell
    }
    
    func next() {
       scrollView.setContentOffset(CGPoint(x: (scrollView.frame.width * CGFloat(self.pageControl.currentPage+2)), y: 0), animated: true)
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offsetX = scrollView.contentOffset.x
            if offsetX == 0 {
                scrollView.contentOffset = CGPointMake(scrollView.frame.width * CGFloat(self.advertisingArray.count), 0)
            }
            if offsetX == scrollView.frame.width*CGFloat(self.advertisingArray.count+1) {
                scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
            }
            let currentPage = scrollView.contentOffset.x/scrollView.frame.width-1
            self.pageControl.currentPage = Int(currentPage)
        }
    }
    
    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offsetX = scrollView.contentOffset.x
            if offsetX == 0 {
                scrollView.contentOffset = CGPointMake(scrollView.frame.width * CGFloat(self.advertisingArray.count), 0)
            }
            if offsetX == scrollView.frame.width*CGFloat(self.advertisingArray.count+1) {
                scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
            }
            let currentPage = scrollView.contentOffset.x/scrollView.frame.width-1
            self.pageControl.currentPage = Int(currentPage)
        }
    }
    
    func pageChanged(sender:UIPageControl) {
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated:true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var cellNumber: Int = 0
        if(collectionView === goodsclassCollectionView){
            cellNumber = self.goodsclassArray.count
        }
        else if(collectionView === goodsclassCollectionView){
            cellNumber = self.goodsArray.count
        }
        return cellNumber
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell: UICollectionViewCell? = nil
        if(collectionView === goodsclassCollectionView){
            cell = self.goodsclassCollectionView.dequeueReusableCellWithReuseIdentifier("goodsclassCell", forIndexPath: indexPath) as UICollectionViewCell
            let imageUrlString:String = self.goodsclassArray[indexPath.row].iconUrl
            let url:NSURL! = NSURL(string: imageUrlString)
            let data:NSData! = NSData(contentsOfURL: url)
            let image = UIImage(data: data)
            let imageView =  UIImageView(image: image)
            imageView.frame = CGRectMake(6, 0, 38, 38)
            let label = UILabel(frame: CGRectMake(0,40,50,10))
            label.text = self.goodsclassArray[indexPath.row].gcName
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont(name: ".SFUIText-Regular", size: 10)
            cell!.backgroundColor = UIColor.whiteColor()
            cell!.addSubview(imageView)
            cell!.addSubview(label)
        }
        else if(collectionView === goodsCollectionView){
            cell = self.goodsCollectionView.dequeueReusableCellWithReuseIdentifier("goodsCell", forIndexPath: indexPath) as UICollectionViewCell
        }
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 15, 10, 15)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        //点击事件
    }
}

