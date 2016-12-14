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
    var startTime: Date?
    var finishTime: Date?
    var serviceTime: TimeInterval?
    let timeFormatter = DateFormatter()
    let zoomButtonX = SCREEN_WIDTH - 50
    
    
    func initMapView() {
        timeFormatter.dateFormat = "HH:mm"
        
        speedShotOrderTableView = UITableView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 250, width: SCREEN_WIDTH, height: 250), style: .plain)
        speedShotOrderTableView?.register(UINib(nibName: "SpeedShotOrderCell", bundle: nil), forCellReuseIdentifier: "speedShotOrderCell")
        speedShotOrderTableView?.delegate = self
        speedShotOrderTableView?.dataSource = self
        
        
        mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        mapView?.delegate = self
        
        //设置指南针和比例尺的位置
        mapView?.showsCompass = true
        mapView?.showsScale = true
        mapView?.compassOrigin = CGPoint(x: 10, y: 100)
        mapView?.scaleOrigin = CGPoint(x: 10, y: self.view.frame.height - 100)
        mapView?.setUserTrackingMode(MAUserTrackingMode.follow, animated: true)
        
        mapView!.isShowsUserLocation = true
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
        locationBtn = UIButton(frame: CGRect(x: 15, y: SCREEN_HEIGHT - 300, width: 35, height: 35))
        locationBtn!.setBackgroundImage(UIImage(named: "positionImage"), for: UIControlState())
        locationBtn!.tag = 1;
        locationBtn!.addTarget(self, action:#selector(LocationPhotographerViewController.btnSelector(_:)), for: UIControlEvents.touchUpInside)
        mapView!.addSubview(locationBtn!)
        //放大按钮
        zoomOutBtn = UIButton(frame: CGRect(x: zoomButtonX, y: SCREEN_HEIGHT - 250 - 80, width: 35, height: 35))
        zoomOutBtn!.setBackgroundImage(UIImage(named: "zoomOutImage"), for: UIControlState())
        zoomOutBtn!.tag = 3;
        zoomOutBtn!.addTarget(self, action: #selector(LocationPhotographerViewController.btnSelector(_:)), for: UIControlEvents.touchUpInside)
        mapView!.addSubview(zoomOutBtn!)
        //缩小按钮
        zoomInBtn = UIButton(frame: CGRect(x: zoomButtonX, y: SCREEN_HEIGHT - 250 - 40, width: 35, height: 35))
        zoomInBtn!.setBackgroundImage(UIImage(named: "zoomInImage"), for: UIControlState())
        zoomInBtn!.tag = 4;
        zoomInBtn!.addTarget(self, action: #selector(LocationPhotographerViewController.btnSelector(_:)), for: UIControlEvents.touchUpInside)
        mapView!.addSubview(zoomInBtn!)
    }
    
    func btnSelector(_ sender: UIButton) {
        switch sender.tag {
        case 1://定位
            if centerCoordinate != nil {
                mapView!.setCenter(centerCoordinate, animated: true)
            }
        case 2://刷新
            getLocationRoundFlag()
            mapView!.isShowsUserLocation = true; //YES 为打开定位,NO 为关闭定位
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
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            //取出当前位置的坐标
            print("latitude : \(userLocation.coordinate.latitude),longitude: \(userLocation.coordinate.longitude)");
            centerCoordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
            latitude = CGFloat(userLocation.coordinate.latitude)
            longitude = CGFloat(userLocation.coordinate.longitude)
            mapView.isShowsUserLocation = true;
        }
    }
    
    //清除数据
    func clearMapData(){
        clearMapView()
        clearSearch()
    }
    
    func clearMapView(){
        mapView!.isShowsUserLocation = false
        mapView!.delegate = nil
    }
    
    
    func clearSearch(){
        mapSearch!.delegate = nil
    }
    
    func addAnnotationWithCooordinate(_ coordinate:CLLocationCoordinate2D) {
        let annotation = MAPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "position"
        annotation.subtitle = "locationViewController"
        mapView?.addAnnotation(annotation)
    }
    
    func randomPoint() -> CGPoint {
        var randomPoint = CGPoint.zero
        randomPoint.x = CGFloat(CGFloat(arc4random()).truncatingRemainder(dividingBy: 5)) * 0.003
        randomPoint.y = CGFloat(CGFloat(arc4random()).truncatingRemainder(dividingBy: 5)) * 0.003
        return randomPoint
    }
    
    func offsetToContainRect(_ innerRect:CGRect, outerRect:CGRect) -> CGSize {
        let nudgeRight:Float  = fmaxf(0, Float(outerRect.minX - innerRect.minX))
        //        let nudgeLeft:Float   = fminf(0, Float(CGRectGetMinX(outerRect) - CGRectGetMinX(innerRect)))
        let nudgeTop:Float    = fmaxf(0, Float(outerRect.minX - innerRect.minX))
        //        let nudgeBottom:Float = fminf(0, Float(CGRectGetMinX(outerRect) - CGRectGetMinX(innerRect)))
        return CGSize(width: CGFloat(nudgeRight), height: CGFloat(nudgeTop))
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation .isKind(of: MAPointAnnotation.self) {
            let customResultIdentifier = "customReuseIdentifier"
            
            let annotationView = CustomAnnotation(annotation: annotation, reuseIdentifier: customResultIdentifier)
            annotationView?.canShowCallout = false
            annotationView?.isDraggable = true
            annotationView?.calloutOffset = CGPoint(x: 0, y: -5)
            annotationView?.portraitImageView?.image = UIImage(named: "cameraRedImage")
            return annotationView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "SSorderCell")
            cell.textLabel?.text = "10元快拍：建议拍摄10张左右，时长约5-10分钟"
            cell.textLabel?.textColor = SP_BLUE_COLOR
            return cell
        } else if indexPath.row == 1 {
            let cell: SpeedShotOrderCell = speedShotOrderTableView?.dequeueReusableCell(withIdentifier: "speedShotOrderCell") as! SpeedShotOrderCell
            cell.SSorderCellUserIdLabel.text = "胡桃夹子"
            cell.getOrderButton.addTarget(self, action: #selector(LocationPhotographerViewController.getOrderButtonAction), for: UIControlEvents.touchUpInside)
            return cell
        } else {
            let cell: SpeedShotOrderCell = speedShotOrderTableView?.dequeueReusableCell(withIdentifier: "speedShotOrderCell") as! SpeedShotOrderCell
            cell.SSorderCellUserIdLabel.text = "Summer Li"
            cell.SSordeCellProfileImageView.image = UIImage(named: "profileDefaultForFrontCell")
            cell.getOrderButton.addTarget(self, action: #selector(LocationPhotographerViewController.getOrderButtonAction), for: UIControlEvents.touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 50 : 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getOrderButtonAction() {
        speedShotOrderTableView?.isHidden = true
        speedShotStartFrame = (Bundle.main.loadNibNamed("SpeedShotStartFrame", owner: nil, options: nil) as NSArray).object(at: 0) as? SpeedShotStartFrame
        speedShotStartFrame?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 200, width: SCREEN_WIDTH, height: 200)
        speedShotStartFrame?.SSstartButton.addTarget(self, action: #selector(LocationPhotographerViewController.startOrderButtonAction), for: UIControlEvents.touchUpInside)
        locationBtn?.removeFromSuperview()
        zoomOutBtn?.removeFromSuperview()
        zoomInBtn?.removeFromSuperview()
        locationBtn?.frame = CGRect(x: 15, y: SCREEN_HEIGHT - 250, width: 35, height: 35)
        zoomOutBtn?.frame = CGRect(x: zoomButtonX, y: SCREEN_HEIGHT - 200 - 80, width: 35, height: 35)
        zoomInBtn?.frame = CGRect(x: zoomButtonX, y: SCREEN_HEIGHT - 200 - 40, width: 35, height: 35)
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
        locationBtn?.frame = CGRect(x: 15, y: SCREEN_HEIGHT - 210, width: 35, height: 35)
        zoomOutBtn?.frame = CGRect(x: zoomButtonX, y: SCREEN_HEIGHT - 160 - 80, width: 35, height: 35)
        zoomInBtn?.frame = CGRect(x: zoomButtonX, y: SCREEN_HEIGHT - 160 - 40, width: 35, height: 35)
        self.view.addSubview(locationBtn!)
        self.view.addSubview(zoomOutBtn!)
        self.view.addSubview(zoomInBtn!)
        speedShotFinishedFrame = (Bundle.main.loadNibNamed("SpeedShotFinishedFrame", owner: nil, options: nil) as NSArray).object(at: 0) as? SpeedShotFinishedFrame
        speedShotFinishedFrame?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 160, width: SCREEN_WIDTH, height: 160)
        speedShotFinishedFrame?.SSfinishButton.addTarget(self, action: #selector(LocationPhotographerViewController.finishOrderButtonAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(speedShotFinishedFrame!)
        
        startTime = Date()

    }
    
    func finishOrderButtonAction() {
        backgroudRect = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        backgroudRect!.backgroundColor = UIColor.black
        backgroudRect!.alpha = 0.8
        self.view.addSubview(backgroudRect!)
        
        finishTime = Date()
        serviceTime = finishTime?.timeIntervalSince(startTime!)
        
        serviceFeeFrame = (Bundle.main.loadNibNamed("ServiceFeeFrame", owner: nil, options: nil) as NSArray).object(at: 0) as? ServiceFeeFrame
        serviceFeeFrame?.frame = CGRect(x: (SCREEN_WIDTH - 350)/2, y: 150, width: 350, height: 280)
        serviceFeeFrame?.startTime.text = timeFormatter.string(from: startTime!)
        serviceFeeFrame?.finishTime.text = timeFormatter.string(from: finishTime!)
        serviceFeeFrame?.priceLabel.text = caculateFee(serviceTime!)
        serviceFeeFrame?.controledPriceLabel.text = serviceFeeFrame?.priceLabel.text
        
        closeBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH - (SCREEN_WIDTH - 350)/2 - 10, y: 140, width: 20, height: 20))
        closeBtn!.setBackgroundImage(UIImage(named: "closeButtonImage"), for: UIControlState())
        closeBtn!.addTarget(self, action: #selector(LocationPhotographerViewController.closeButtonAction), for: .touchUpInside)
        self.view.addSubview(serviceFeeFrame!)
        self.view.addSubview(closeBtn!)
    }
    
    func caculateFee(_ serviceTime: TimeInterval) -> String {
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
        MAMapServices.shared().apiKey = AMAP_KEY
        self.modeSegment = UISegmentedControl()
        initMapView()
        initBtns()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(randomPoint())
        print("+++++\(latitude),++++++\(longitude)")
        if latitude != 0 && longitude != 0 {
            for i in 0 ..< 2 {
                self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude! + randomPoint().x ), longitude: CLLocationDegrees(longitude! + randomPoint().y)))
            }
            
            for i in 0 ..< 2 {
                self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude! - randomPoint().x), longitude: CLLocationDegrees(longitude! - randomPoint().y)))
            }
            
            for i in 0 ..< 3 {
                self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude! + randomPoint().x), longitude: CLLocationDegrees(longitude! - randomPoint().y)))
            }
            
            for i in 0 ..< 3 {
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
