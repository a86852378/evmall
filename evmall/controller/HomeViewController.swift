//
//  ViewController.swift
//  evmall-swift
//
//  Created by eVideo on 7/9/16.
//  Copyright © 2016年 eVideo. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    var homeTopSearchBar: UISearchBar!
    var pageControl = UIPageControl()
    var scrollView = UIScrollView()
    var layout = UICollectionViewFlowLayout()
    var goodsclassCollectionView = UICollectionView(frame: CGRect(x:0, y:0, width:0, height:0), collectionViewLayout: UICollectionViewFlowLayout())
    var goodsCollectionView = UICollectionView(frame: CGRect(x:0, y:0, width:0, height:0), collectionViewLayout: UICollectionViewFlowLayout())
    var timer: Timer?
    var rollingTime: TimeInterval = 3.0
    var selectPic: Int = 0
    var currentIndexPath: [NSIndexPath] = []
    var goodclassColor: [UIColor] = [UIColor.red,UIColor.orange,UIColor.magenta,UIColor.blue,UIColor.purple,UIColor.orange,UIColor.magenta,UIColor.purple]
    var advertisingArray: [Advertising] = []
    var goodsclassArray: [Goodsclass] = []
    var goodsArray: [Goods] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.detachNewThreadSelector(#selector(HomeViewController.loadData), toTarget: self, with: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 124/255, blue: 48/255, alpha: 1)      //改变navigationbar背景颜色
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent    //将bar改为背景颜色为黑，字为白模式
        self.navigationController?.navigationBar.tintColor = UIColor.white         //将添加在bar上的字设置为白色
//        self.tabBarController?.tabBar.translucent = true
        self.tabBarController?.tabBar.barTintColor = UIColor.white                  //tabbar的背景颜色
        self.tabBarController?.tabBar.tintColor = UIColor(red: 248/255, green: 124/255, blue: 48/255, alpha: 1)  //tabtar的图标颜色
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none     //去掉tableview的分隔符
        tableView.rowHeight = UITableViewAutomaticDimension               //tableview自适应长度
        tableView.showsVerticalScrollIndicator = false                    //去掉tableview滚动条
        tableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)     //tableview背景颜色

        DispatchQueue.global(qos: .default).async {
            self.timer = Timer.scheduledTimer(timeInterval: self.rollingTime, target: self, selector: #selector(self.nextPic), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        getData(modelName: "advertising"){(array) in
            self.advertisingArray = array as! [Advertising]
            DispatchQueue.main.async(execute: {self.tableView.reloadRows(at: self.currentIndexPath as [IndexPath], with: UITableViewRowAnimation.fade)})
        }
        getData(modelName: "goodsclass"){(array) in
            self.goodsclassArray = array as! [Goodsclass]
            DispatchQueue.main.async(execute: {self.goodsclassCollectionView.reloadData()})
        }
        getData(modelName: "goods"){(array) in
            self.goodsArray = array as! [Goods]
            DispatchQueue.main.async(execute: {self.goodsCollectionView.reloadData()})
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    func clickPic(picTag: UITapGestureRecognizer) {
        let num = picTag.view!.tag
        let ms = UIStoryboard(name: "Main", bundle: nil)
        let nextController = ms.instantiateViewController(withIdentifier: "AdvWebID") as! AdvWebViewController
        nextController.advertising = self.advertisingArray[num]
        nextController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextController, animated: true)
        }
    
    func nextPic() {
        scrollView.setContentOffset(CGPoint(x: (scrollView.frame.width * CGFloat(self.pageControl.currentPage+2)), y: 0), animated: true)
    }
    
    func pageChanged(sender:UIPageControl) {
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated:true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //广告自动循环轮播
        if(indexPath.row == 0){
            currentIndexPath.append(indexPath as NSIndexPath)
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.isScrollEnabled = true
            scrollView.frame = CGRect(x:0, y:0, width:320, height:120)
            pageControl.numberOfPages = self.advertisingArray.count
            scrollView.contentSize = CGSize(width:self.scrollView.frame.width*CGFloat(self.advertisingArray.count+2), height:self.scrollView.frame.height)
            scrollView.contentOffset = CGPoint(x:scrollView.frame.width, y:0)
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
                    let data:NSData! = NSData(contentsOf: url as URL)
                    let image = UIImage(data: data as Data)
                    let imageView =  UIImageView(image: image)
                    if(i != 0 && i != self.advertisingArray.count+1){
                        imageView.isUserInteractionEnabled = true
                        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clickPic)))
                        imageView.tag = i-1
                    }
                    imageView.frame = CGRect(x:self.scrollView.frame.width*CGFloat(i), y:0, width:self.scrollView.frame.width, height:self.scrollView.frame.height)
                    self.scrollView.addSubview(imageView)
                }
            }
            self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
            self.automaticallyAdjustsScrollViewInsets = false
            scrollView.delegate = self
            pageControl.currentPageIndicatorTintColor = UIColor.orange
            pageControl.pageIndicatorTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
            pageControl.frame = CGRect(x:260, y:100, width:40, height:10)
            pageControl.addTarget(self, action: #selector(pageChanged),for: UIControlEvents.valueChanged)
            cell.addSubview(scrollView)
            cell.addSubview(pageControl)
        }
        //商品大类窗口
        else if(indexPath.row == 1){
            goodsclassCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "goodsclassCell")
            goodsclassCollectionView.frame = CGRect(x:0, y:0, width:320, height:130)
            goodsclassCollectionView.backgroundColor = UIColor.white
            goodsclassCollectionView.delegate = self
            goodsclassCollectionView.dataSource = self
            cell.addSubview(goodsclassCollectionView)
        }
        //商品展示
        else if(indexPath.row == 2){
            goodsCollectionView.collectionViewLayout = layout
            layout.minimumLineSpacing = 3
            layout.minimumInteritemSpacing = 3
            goodsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "goodsCell")
            goodsCollectionView.frame = CGRect(x:0, y:0, width:320, height:220)
            goodsCollectionView.backgroundColor = UIColor.clear
            goodsCollectionView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.9)
            goodsCollectionView.delegate = self
            goodsCollectionView.dataSource = self
            cell.addSubview(goodsCollectionView)
        }
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offsetX = scrollView.contentOffset.x
            if offsetX == 0 {
                scrollView.contentOffset = CGPoint(x:scrollView.frame.width * CGFloat(self.advertisingArray.count), y:0)
            }
            if offsetX == scrollView.frame.width*CGFloat(self.advertisingArray.count+1) {
                scrollView.contentOffset = CGPoint(x:scrollView.frame.width, y:0)
            }
            let currentPage = scrollView.contentOffset.x/scrollView.frame.width-1
            self.pageControl.currentPage = Int(currentPage)
        }
    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offsetX = scrollView.contentOffset.x
            if offsetX == 0 {
                scrollView.contentOffset = CGPoint(x:scrollView.frame.width * CGFloat(self.advertisingArray.count), y:0)
            }
            if offsetX == scrollView.frame.width*CGFloat(self.advertisingArray.count+1) {
                scrollView.contentOffset = CGPoint(x:scrollView.frame.width, y:0)
            }
            let currentPage = scrollView.contentOffset.x/scrollView.frame.width-1
            self.pageControl.currentPage = Int(currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var cell: UICollectionViewCell? = nil
        if(collectionView === goodsclassCollectionView){
            cell = self.goodsclassCollectionView.dequeueReusableCell(withReuseIdentifier: "goodsclassCell", for: indexPath) as UICollectionViewCell
            let imageUrlString: String = self.goodsclassArray[indexPath.row].iconUrl
            let url: NSURL = NSURL(string: imageUrlString)!
            let data: NSData = NSData(contentsOf: url as URL)!
            let image = UIImage(data: data as Data)
            let imageView = UIImageView(frame: CGRect(x:9, y:9, width:20, height:20))
            imageView.image = image
            imageView.backgroundColor = goodclassColor[indexPath.row]
            let view = UIView(frame: CGRect(x:6, y:0, width:38, height:38))
            view.addSubview(imageView)
            view.backgroundColor = goodclassColor[indexPath.row]
            view.layer.cornerRadius = 19
            view.clipsToBounds = true
            let label = UILabel(frame: CGRect(x:0, y:42, width:50, height:8))
            label.text = self.goodsclassArray[indexPath.row].gcName
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 10)
            cell!.addSubview(view)
            cell!.addSubview(label)
        }
        else{
            cell = self.goodsCollectionView.dequeueReusableCell(withReuseIdentifier: "goodsCell", for: indexPath) as UICollectionViewCell
            let imageUrlString: String = self.goodsArray[indexPath.row].goodsImage
            let url: NSURL = NSURL(string: imageUrlString)!
            let data: NSData = NSData(contentsOf: url as URL)!
            let image = UIImage(data: data as Data)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x:0, y:0, width:(self.view.frame.width-6)/2, height:150)
            let nameLabel = UILabel(frame: CGRect(x:10, y:155, width:(self.view.frame.width-6)/2, height:20))
            nameLabel.text = self.goodsArray[indexPath.row].goodsName
            nameLabel.font = UIFont.systemFont(ofSize: 13)
            let priceLabel = UILabel(frame: CGRect(x:10, y:180, width:(self.view.frame.width-6)/2, height:20))
            priceLabel.text = "¥\(self.goodsArray[indexPath.row].goodsPrice)"
            priceLabel.textColor = UIColor.red
            priceLabel.font = UIFont.systemFont(ofSize: 14)
            cell!.addSubview(imageView)
            cell!.addSubview(nameLabel)
            cell!.addSubview(priceLabel)
        }
        cell!.backgroundColor = UIColor.white
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(collectionView === goodsclassCollectionView){
            return CGSize(width: 50, height: 50)
        }
        else{
            return CGSize(width: (self.view.frame.width-6)/2, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if(collectionView === goodsclassCollectionView){
            return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        }
        else{
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if(collectionView === goodsclassCollectionView){
            let ms = UIStoryboard(name: "Main", bundle: nil)
            let nextController = ms.instantiateViewController(withIdentifier: "GoodsclassID") as! GoodsclassViewController
            nextController.goodsclassID = indexPath.row
            nextController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextController, animated: true)
        }
        else{
            let ms = UIStoryboard(name: "Main", bundle: nil)
            let nextController = ms.instantiateViewController(withIdentifier: "GoodsID") as! GoodsViewController
            nextController.goods = self.goodsArray[indexPath.row]
            nextController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextController, animated: true)
        }
    }
}

