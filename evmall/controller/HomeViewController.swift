//
//  ViewController.swift
//  evmall-swift
//
//  Created by eVideo on 7/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate{

    var homeTopSearchBar: UISearchBar!
    var pageControl = UIPageControl()
    var scrollView = UIScrollView()
    var layout = UICollectionViewFlowLayout()
    var goodsclassCollectionView = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: UICollectionViewFlowLayout())
    var goodsCollectionView = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: UICollectionViewFlowLayout())
    var timer: NSTimer?
    var rollingTime: NSTimeInterval = 3.0
    var selectPic: Int = 0
    var currentIndexPath: [NSIndexPath] = []
    var goodclassColor: [UIColor] = [UIColor.redColor(),UIColor.orangeColor(),UIColor.magentaColor(),UIColor.blueColor(),UIColor.purpleColor(),UIColor.orangeColor(),UIColor.magentaColor(),UIColor.purpleColor()]
    var advertisingArray: [Advertising] = []
    var goodsclassArray: [Goodsclass] = []
    var goodsArray: [Goods] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSThread.detachNewThreadSelector(#selector(HomeViewController.loadData), toTarget: self, withObject: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 124/255, blue: 48/255, alpha: 1)      //改变navigationbar背景颜色
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent    //将bar改为背景颜色为黑，字为白模式
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()          //将添加在bar上的字设置为白色
//        self.tabBarController?.tabBar.translucent = true
        self.tabBarController?.tabBar.barTintColor = UIColor.whiteColor()                  //tabbar的背景颜色
        self.tabBarController?.tabBar.tintColor = UIColor(red: 248/255, green: 124/255, blue: 48/255, alpha: 1)  //tabtar的图标颜色
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None     //去掉tableview的分隔符
        tableView.rowHeight = UITableViewAutomaticDimension               //tableview自适应长度
        tableView.showsVerticalScrollIndicator = false                    //去掉tableview滚动条
        tableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)     //tableview背景颜色
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(self.rollingTime, target: self, selector: #selector(self.next), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().run()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        getData("advertising"){(array) in
            self.advertisingArray = array as! [Advertising]
            dispatch_async(dispatch_get_main_queue(),{self.tableView.reloadRowsAtIndexPaths(self.currentIndexPath, withRowAnimation: UITableViewRowAnimation.Fade)})
        }
        getData("goodsclass"){(array) in
            self.goodsclassArray = array as! [Goodsclass]
            dispatch_async(dispatch_get_main_queue(),{self.goodsclassCollectionView.reloadData()})
        }
        getData("goods"){(array) in
            self.goodsArray = array as! [Goods]
            dispatch_async(dispatch_get_main_queue(),{self.goodsCollectionView.reloadData()})
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    func clickPic(picTag: UITapGestureRecognizer) {
        let num = picTag.view!.tag
        let ms = UIStoryboard(name: "Main", bundle: nil)
        let nextController = ms.instantiateViewControllerWithIdentifier("AdvWebID") as! AdvWebViewController
        nextController.advertising = self.advertisingArray[num]
        nextController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextController, animated: true)
        }
    
    func next() {
        scrollView.setContentOffset(CGPoint(x: (scrollView.frame.width * CGFloat(self.pageControl.currentPage+2)), y: 0), animated: true)
    }
    
    func pageChanged(sender:UIPageControl) {
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated:true)
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
            let newHeight = (self.goodsArray.count/2 + self.goodsArray.count%2)*200 + ((self.goodsArray.count/2 + self.goodsArray.count%2)-1)*10 + 20
            height = CGFloat(newHeight)
        }
        return height
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //广告自动循环轮播
        if(indexPath.row == 0){
            currentIndexPath.append(indexPath)
            scrollView.pagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.scrollEnabled = true
            scrollView.frame = CGRectMake(0, 0, 320, 120)
            pageControl.numberOfPages = self.advertisingArray.count
            scrollView.contentSize = CGSizeMake(self.scrollView.frame.width*CGFloat(self.advertisingArray.count+2),self.scrollView.frame.height)
            scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
            if(self.advertisingArray.count != 0){
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
                    if(i != 0 && i != self.advertisingArray.count+1){
                        imageView.userInteractionEnabled = true
                        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickPic(_:))))
                        imageView.tag = i-1
                    }
                    imageView.frame = CGRectMake(self.scrollView.frame.width*CGFloat(i), 0, self.scrollView.frame.width, self.scrollView.frame.height)
                    self.scrollView.addSubview(imageView)
                }
            }
            self.edgesForExtendedLayout = UIRectEdge.None
            self.automaticallyAdjustsScrollViewInsets = false
            scrollView.delegate = self
            pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
            pageControl.pageIndicatorTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
            pageControl.frame = CGRectMake(260, 100, 40, 10)
            pageControl.addTarget(self, action: #selector(pageChanged(_:)),forControlEvents: UIControlEvents.ValueChanged)
            cell.addSubview(scrollView)
            cell.addSubview(pageControl)
        }
        //商品大类窗口
        else if(indexPath.row == 1){
            goodsclassCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "goodsclassCell")
            goodsclassCollectionView.frame = CGRectMake(0, 0, 320, 130)
            goodsclassCollectionView.backgroundColor = UIColor.whiteColor()
            goodsclassCollectionView.delegate = self
            goodsclassCollectionView.dataSource = self
            cell.addSubview(goodsclassCollectionView)
        }
        //商品展示
        else if(indexPath.row == 2){
            goodsCollectionView.collectionViewLayout = layout
            layout.minimumLineSpacing = 3
            layout.minimumInteritemSpacing = 3
            goodsCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "goodsCell")
            goodsCollectionView.frame = CGRectMake(0, 0, 320, 220)
            goodsCollectionView.backgroundColor = UIColor.clearColor()
            goodsCollectionView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.9)
            goodsCollectionView.delegate = self
            goodsCollectionView.dataSource = self
            cell.addSubview(goodsCollectionView)
        }
        return cell
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var cellNumber: Int = 0
        if(collectionView === goodsclassCollectionView){
            cellNumber = self.goodsclassArray.count
        }
        else{
            cellNumber = self.goodsArray.count
        }
        return cellNumber
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell: UICollectionViewCell? = nil
        if(collectionView === goodsclassCollectionView){
            cell = self.goodsclassCollectionView.dequeueReusableCellWithReuseIdentifier("goodsclassCell", forIndexPath: indexPath) as UICollectionViewCell
            let imageUrlString: String = self.goodsclassArray[indexPath.row].iconUrl
            let url: NSURL = NSURL(string: imageUrlString)!
            let data: NSData = NSData(contentsOfURL: url)!
            let image = UIImage(data: data)
            let imageView = UIImageView(frame: CGRectMake(9, 9, 20, 20))
            imageView.image = image
            imageView.backgroundColor = goodclassColor[indexPath.row]
            let view = UIView(frame: CGRectMake(6, 0, 38, 38))
            view.addSubview(imageView)
            view.backgroundColor = goodclassColor[indexPath.row]
            view.layer.cornerRadius = 19
            view.clipsToBounds = true
            let label = UILabel(frame: CGRectMake(0, 42, 50, 8))
            label.text = self.goodsclassArray[indexPath.row].gcName
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(10)
            cell!.addSubview(view)
            cell!.addSubview(label)
        }
        else{
            cell = self.goodsCollectionView.dequeueReusableCellWithReuseIdentifier("goodsCell", forIndexPath: indexPath) as UICollectionViewCell
            let imageUrlString: String = self.goodsArray[indexPath.row].goodsImage
            let url: NSURL = NSURL(string: imageUrlString)!
            let data: NSData = NSData(contentsOfURL: url)!
            let image = UIImage(data: data)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRectMake(0, 0, (self.view.frame.width-6)/2, 150)
            let nameLabel = UILabel(frame: CGRectMake(10, 155, (self.view.frame.width-6)/2, 20))
            nameLabel.text = self.goodsArray[indexPath.row].goodsName
            nameLabel.font = UIFont.systemFontOfSize(13)
            let priceLabel = UILabel(frame: CGRectMake(10, 180, (self.view.frame.width-6)/2, 20))
            priceLabel.text = "¥\(self.goodsArray[indexPath.row].goodsPrice)"
            priceLabel.textColor = UIColor.redColor()
            priceLabel.font = UIFont.systemFontOfSize(14)
            cell!.addSubview(imageView)
            cell!.addSubview(nameLabel)
            cell!.addSubview(priceLabel)
        }
        cell!.backgroundColor = UIColor.whiteColor()
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        if(collectionView === goodsclassCollectionView){
            return CGSize(width: 50, height: 50)
        }
        else{
            return CGSize(width: (self.view.frame.width-6)/2, height: 200)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        if(collectionView === goodsclassCollectionView){
            return UIEdgeInsetsMake(10, 15, 10, 15)
        }
        else{
            return UIEdgeInsetsMake(10, 0, 10, 0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if(collectionView === goodsclassCollectionView){
            let ms = UIStoryboard(name: "Main", bundle: nil)
            let nextController = ms.instantiateViewControllerWithIdentifier("GoodsclassID") as! GoodsclassViewController
            nextController.goodsclassID = indexPath.row
            nextController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextController, animated: true)
        }
        else{
            let ms = UIStoryboard(name: "Main", bundle: nil)
            let nextController = ms.instantiateViewControllerWithIdentifier("GoodsID") as! GoodsViewController
            nextController.goods = self.goodsArray[indexPath.row]
            nextController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextController, animated: true)
        }
    }
}

