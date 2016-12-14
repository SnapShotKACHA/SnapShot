//
//  LocationViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 12/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit


class LocationPhotographerViewController: BasicViewController, MAMapViewDelegate, AMapSearchDelegate, UITableViewDataSource, UITableViewDelegate {
    var mapView: MAMapView?
    var mapSearch: AMapSearchAPI?
    var currentLocation: CLLocation?
    var speedShotStartFrame: SpeedShotStartFrame?
    var speedShotFinishedFrame: SpeedShotFinishedFrame?
    var serviceFeeFrame: ServiceFeeFrame?
    var modeSegment: UISegmentedControl?
    var centerMarker:UIImageView!
    var centerCoordinate: CLLocationCoordinate2D!
    var speedShotOrderTableView: UITableView?
    var zoomOutBtn: UIButton?
    var zoomInBtn: UIButton?
    var locationBtn: UIButton?
    var latitude: CGFloat?
    var longitude: CGFloat?
    var backgroudRect: UIView?
    var closeBtn: UIButton?
    var startTime: NSDate?
    var finishTime: NSDate?
    var serviceTime: NSTimeInterval?
    let timeFormatter = NSDateFormatter()
    let zoomButtonX = SCREEN_WIDTH - 50
    
    
    func initMapView() {
        timeFormatter.dateFormat = "HH:mm"
        
        speedShotOrderTableView = UITableView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 250, width: SCREEN_WIDTH, height: 250), style: .Plain)
        speedShotOrderTableView?.registerNib(UINib(nibName: "SpeedShotOrderCell", bundle: nil), forCellReuseIdentifier: "speedShotOrderCell")
        speedShotOrderTableView?.delegate = self
        speedShotOrderTableView?.dataSource = self
        
        
        mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        mapView?.delegate = self
        
        //设置指南针和比例尺的位置
        mapView?.showsCompass = true
        mapView?.showsScale = true
        mapView?.compassOrigin = CGPointMake(10, 100)
        mapView?.scaleOrigin = CGPointMake(10, self.view.frame.height - 100)
        mapView?.setUserTrackingMode(MAUserTrackingMode.Follow, animated: true)
        
        mapView!.showsUserLocation = true
        mapView!.setZoomLevel(14, animated: true)
        self.view.addSubview(mapView!)
        self.view.addSubview(speedShotOrderTableView!)
    }
    
    func initMapSearch() {
        mapSearch = AMapSearchAPI()
        mapSearch?.delegate = self
    }
    
    func initBtns(){
        //        centerMarker = UIImageView(frame: CGRectMake(0, 0, 20, 30))
        //        centerMarker.center = mapView!.center
        //        centerMarker.frame = CGRectMake(centerMarker.frame.origin.x, centerMarker.frame.origin.y + 10, 20, 30);
        //        centerMarker.image = UIImage(named: "locationPinImage")
        //        centerMarker.contentMode = .ScaleAspectFit
        //        mapView!.addSubview(centerMarker)
        //定位按钮
        locationBtn = UIButton(frame: CGRectMake(15, SCREEN_HEIGHT - 300, 35, 35))
        locationBtn!.setBackgroundImage(UIImage(named: "positionImage"), forState: UIControlState.Normal)
        locationBtn!.tag = 1;
        locationBtn!.addTarget(self, action:"btnSelector:", forControlEvents: UIControlEvents.TouchUpInside)
        mapView!.addSubview(locationBtn!)
        //放大按钮
        zoomOutBtn = UIButton(frame: CGRectMake(zoomButtonX, SCREEN_HEIGHT - 250 - 80, 35, 35))
        zoomOutBtn!.setBackgroundImage(UIImage(named: "zoomOutImage"), forState: UIControlState.Normal)
        zoomOutBtn!.tag = 3;
        zoomOutBtn!.addTarget(self, action: "btnSelector:", forControlEvents: UIControlEvents.TouchUpInside)
        mapView!.addSubview(zoomOutBtn!)
        //缩小按钮
        zoomInBtn = UIButton(frame: CGRectMake(zoomButtonX, SCREEN_HEIGHT - 250 - 40, 35, 35))
        zoomInBtn!.setBackgroundImage(UIImage(named: "zoomInImage"), forState: UIControlState.Normal)
        zoomInBtn!.tag = 4;
        zoomInBtn!.addTarget(self, action: "btnSelector:", forControlEvents: UIControlEvents.TouchUpInside)
        mapView!.addSubview(zoomInBtn!)
    }
    
    func btnSelector(sender: UIButton) {
        switch sender.tag {
        case 1://定位
            if centerCoordinate != nil {
                mapView!.setCenterCoordinate(centerCoordinate, animated: true)
            }
        case 2://刷新
            getLocationRoundFlag()
            mapView!.showsUserLocation = true; //YES 为打开定位,NO 为关闭定位
        case 3:
            if mapView!.zoomLevel >= 3 && mapView!.zoomLevel <= 18{
                mapView!.setZoomLevel(mapView!.zoomLevel+1, animated: true)
            }else if mapView!.zoomLevel > 18 && mapView!.zoomLevel <= 19{
                mapView!.setZoomLevel(19, animated: true)
            }
        case 4:
            
            if mapView!.zoomLevel >= 4 && mapView!.zoomLevel <= 19{
                mapView!.setZoomLevel(mapView!.zoomLevel-1, animated: true)
            }else if mapView!.zoomLevel >= 3 && mapView!.zoomLevel < 4{
                mapView!.setZoomLevel(3, animated: true)
            }
        default:
            print("not known ")
        }
    }
    
    func getLocationRoundFlag(){
    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            //取出当前位置的坐标
            print("latitude : \(userLocation.coordinate.latitude),longitude: \(userLocation.coordinate.longitude)");
            centerCoordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
            latitude = CGFloat(userLocation.coordinate.latitude)
            longitude = CGFloat(userLocation.coordinate.longitude)
            mapView.showsUserLocation = true;
        }
    }
    
    //清除数据
    func clearMapData(){
        clearMapView()
        clearSearch()
    }
    
    func clearMapView(){
        mapView!.showsUserLocation = false
        mapView!.delegate = nil
    }
    
    
    func clearSearch(){
        mapSearch!.delegate = nil
    }
    
    func addAnnotationWithCooordinate(coordinate:CLLocationCoordinate2D) {
        let annotation = MAPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "position"
        annotation.subtitle = "locationViewController"
        mapView?.addAnnotation(annotation)
    }
    
    func randomPoint() -> CGPoint {
        var randomPoint = CGPointZero
        randomPoint.x = CGFloat(CGFloat(arc4random()) % 5) * 0.003
        randomPoint.y = CGFloat(CGFloat(arc4random()) % 5) * 0.003
        return randomPoint
    }
    
    func offsetToContainRect(innerRect:CGRect, outerRect:CGRect) -> CGSize {
        let nudgeRight:Float  = fmaxf(0, Float(CGRectGetMinX(outerRect) - CGRectGetMinX(innerRect)))
        //        let nudgeLeft:Float   = fminf(0, Float(CGRectGetMinX(outerRect) - CGRectGetMinX(innerRect)))
        let nudgeTop:Float    = fmaxf(0, Float(CGRectGetMinX(outerRect) - CGRectGetMinX(innerRect)))
        //        let nudgeBottom:Float = fminf(0, Float(CGRectGetMinX(outerRect) - CGRectGetMinX(innerRect)))
        return CGSizeMake(CGFloat(nudgeRight), CGFloat(nudgeTop))
    }
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation .isKindOfClass(MAPointAnnotation) {
            let customResultIdentifier = "customReuseIdentifier"
            
            let annotationView = CustomAnnotation(annotation: annotation, reuseIdentifier: customResultIdentifier)
            annotationView.canShowCallout = false
            annotationView.draggable = true
            annotationView.calloutOffset = CGPointMake(0, -5)
            annotationView.portraitImageView?.image = UIImage(named: "cameraRedImage")
            return annotationView
        }
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "SSorderCell")
            cell.textLabel?.text = "10元快拍：建议拍摄10张左右，时长约5-10分钟"
            cell.textLabel?.textColor = SP_BLUE_COLOR
            return cell
        } else if indexPath.row == 1 {
            let cell: SpeedShotOrderCell = speedShotOrderTableView?.dequeueReusableCellWithIdentifier("speedShotOrderCell") as! SpeedShotOrderCell
            cell.SSorderCellUserIdLabel.text = "胡桃夹子"
            cell.getOrderButton.addTarget(self, action: "getOrderButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        } else {
            let cell: SpeedShotOrderCell = speedShotOrderTableView?.dequeueReusableCellWithIdentifier("speedShotOrderCell") as! SpeedShotOrderCell
            cell.SSorderCellUserIdLabel.text = "Summer Li"
            cell.SSordeCellProfileImageView.image = UIImage(named: "profileDefaultForFrontCell")
            cell.getOrderButton.addTarget(self, action: "getOrderButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row == 0 ? 50 : 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func getOrderButtonAction() {
        speedShotOrderTableView?.hidden = true
        speedShotStartFrame = (NSBundle.mainBundle().loadNibNamed("SpeedShotStartFrame", owner: nil, options: nil) as NSArray).objectAtIndex(0) as? SpeedShotStartFrame
        speedShotStartFrame?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 200, width: SCREEN_WIDTH, height: 200)
        speedShotStartFrame?.SSstartButton.addTarget(self, action: "startOrderButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        locationBtn?.removeFromSuperview()
        zoomOutBtn?.removeFromSuperview()
        zoomInBtn?.removeFromSuperview()
        locationBtn?.frame = CGRectMake(15, SCREEN_HEIGHT - 250, 35, 35)
        zoomOutBtn?.frame = CGRectMake(zoomButtonX, SCREEN_HEIGHT - 200 - 80, 35, 35)
        zoomInBtn?.frame = CGRectMake(zoomButtonX, SCREEN_HEIGHT - 200 - 40, 35, 35)
        self.view.addSubview(locationBtn!)
        self.view.addSubview(zoomOutBtn!)
        self.view.addSubview(zoomInBtn!)
        self.view.addSubview(speedShotStartFrame!)
    }
    
    func startOrderButtonAction() {
        speedShotStartFrame?.removeFromSuperview()
        zoomOutBtn?.removeFromSuperview()
        zoomInBtn?.removeFromSuperview()
        locationBtn?.removeFromSuperview()
        locationBtn?.frame = CGRectMake(15, SCREEN_HEIGHT - 210, 35, 35)
        zoomOutBtn?.frame = CGRectMake(zoomButtonX, SCREEN_HEIGHT - 160 - 80, 35, 35)
        zoomInBtn?.frame = CGRectMake(zoomButtonX, SCREEN_HEIGHT - 160 - 40, 35, 35)
        self.view.addSubview(locationBtn!)
        self.view.addSubview(zoomOutBtn!)
        self.view.addSubview(zoomInBtn!)
        speedShotFinishedFrame = (NSBundle.mainBundle().loadNibNamed("SpeedShotFinishedFrame", owner: nil, options: nil) as NSArray).objectAtIndex(0) as? SpeedShotFinishedFrame
        speedShotFinishedFrame?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 160, width: SCREEN_WIDTH, height: 160)
        speedShotFinishedFrame?.SSfinishButton.addTarget(self, action: "finishOrderButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(speedShotFinishedFrame!)
        
        startTime = NSDate()

    }
    
    func finishOrderButtonAction() {
        backgroudRect = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        backgroudRect!.backgroundColor = UIColor.blackColor()
        backgroudRect!.alpha = 0.8
        self.view.addSubview(backgroudRect!)
        
        finishTime = NSDate()
        serviceTime = finishTime?.timeIntervalSinceDate(startTime!)
        
        serviceFeeFrame = (NSBundle.mainBundle().loadNibNamed("ServiceFeeFrame", owner: nil, options: nil) as NSArray).objectAtIndex(0) as? ServiceFeeFrame
        serviceFeeFrame?.frame = CGRect(x: (SCREEN_WIDTH - 350)/2, y: 150, width: 350, height: 280)
        serviceFeeFrame?.startTime.text = timeFormatter.stringFromDate(startTime!)
        serviceFeeFrame?.finishTime.text = timeFormatter.stringFromDate(finishTime!)
        serviceFeeFrame?.priceLabel.text = caculateFee(serviceTime!)
        serviceFeeFrame?.controledPriceLabel.text = serviceFeeFrame?.priceLabel.text
        
        closeBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH - (SCREEN_WIDTH - 350)/2 - 10, y: 140, width: 20, height: 20))
        closeBtn!.setBackgroundImage(UIImage(named: "closeButtonImage"), forState: UIControlState.Normal)
        closeBtn!.addTarget(self, action: "closeButtonAction", forControlEvents: .TouchUpInside)
        self.view.addSubview(serviceFeeFrame!)
        self.view.addSubview(closeBtn!)
    }
    
    func caculateFee(serviceTime: NSTimeInterval) -> String {
        let tempTime = lround(Double((serviceTime / 60) / 10)) * 10
        if tempTime > 1 {
            return String(tempTime)
        } else {
            return "再多拍一会吧"
        }
    }

    
    func closeButtonAction() {
        backgroudRect?.removeFromSuperview()
        serviceFeeFrame?.removeFromSuperview()
        closeBtn?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "急速约拍"
        MAMapServices.sharedServices().apiKey = AMAP_KEY
        self.modeSegment = UISegmentedControl()
        initMapView()
        initBtns()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print(randomPoint())
        print("+++++\(latitude),++++++\(longitude)")
        if latitude != 0 && longitude != 0 {
            for var i = 0; i < 2; i++ {
                self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude! + randomPoint().x ), longitude: CLLocationDegrees(longitude! + randomPoint().y)))
            }
            
            for var i = 0; i < 2; i++ {
                self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude! - randomPoint().x), longitude: CLLocationDegrees(longitude! - randomPoint().y)))
            }
            
            for var i = 0; i < 3; i++ {
                self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude! + randomPoint().x), longitude: CLLocationDegrees(longitude! - randomPoint().y)))
            }
            
            for var i = 0; i < 3; i++ {
                self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude! - randomPoint().x), longitude: CLLocationDegrees(longitude! + randomPoint().y)))
            }
//        self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: 39.925349, longitude: 116.407098))
//        self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: 39.931165, longitude: 116.400936))
//        self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: 39.912241, longitude: 116.404637))
//        self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: 39.931995, longitude: 116.395151))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}