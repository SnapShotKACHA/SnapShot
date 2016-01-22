//
//  LocationViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 12/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit


class LocationViewController: BasicViewController, MAMapViewDelegate, AMapSearchDelegate {
    var mapView: MAMapView?
    var mapSearch: AMapSearchAPI?
    var currentLocation: CLLocation?
    var speedShotFrame: SpeedShotFrame?
    var modeSegment: UISegmentedControl?
    var centerMarker:UIImageView!
    var centerCoordinate:CLLocationCoordinate2D!
    
    
    func initMapView() {
        speedShotFrame = (NSBundle.mainBundle().loadNibNamed("SpeedShotFrame", owner: nil, options: nil) as NSArray).objectAtIndex(0) as? SpeedShotFrame
        speedShotFrame?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 160, width: SCREEN_WIDTH, height: 160)
        print(speedShotFrame!.frame.size)
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
        self.view.addSubview(speedShotFrame!)
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
        let locationBtn:UIButton = UIButton(frame: CGRectMake(15, SCREEN_HEIGHT - 230, 35, 35))
        locationBtn.setBackgroundImage(UIImage(named: "positionImage"), forState: UIControlState.Normal)
        locationBtn.tag = 1;
        locationBtn.addTarget(self, action:"btnSelector:", forControlEvents: UIControlEvents.TouchUpInside)
        mapView!.addSubview(locationBtn)
        //放大按钮
        let zoomOutBtn:UIButton = UIButton(frame: CGRectMake(mapView!.frame.size.width-15-35, mapView!.frame.size.height - 80, 35, 35))
        zoomOutBtn.setBackgroundImage(UIImage(named: "zoomOutImage"), forState: UIControlState.Normal)
        zoomOutBtn.tag = 3;
        zoomOutBtn.addTarget(self, action: "btnSelector:", forControlEvents: UIControlEvents.TouchUpInside)
        mapView!.addSubview(zoomOutBtn)
        //缩小按钮
        let zoomInBtn:UIButton = UIButton(frame: CGRectMake(mapView!.frame.size.width - 15-35, mapView!.frame.size.height - 40, 35, 35))
        zoomInBtn.setBackgroundImage(UIImage(named: "zoomInImage"), forState: UIControlState.Normal)
        zoomInBtn.tag = 4;
        zoomInBtn.addTarget(self, action: "btnSelector:", forControlEvents: UIControlEvents.TouchUpInside)
        mapView!.addSubview(zoomInBtn)
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
            centerCoordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude);
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
        randomPoint.x = CGFloat(Int(arc4random()) % (Int)(mapView!.frame.width))
        randomPoint.y = CGFloat(Int(arc4random()) % (Int)(mapView!.frame.height))
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
        
        self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: 39.925349, longitude: 116.407098))
        self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: 39.931165, longitude: 116.400936))
        self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: 39.912241, longitude: 116.404637))
        self.addAnnotationWithCooordinate(CLLocationCoordinate2D(latitude: 39.931995, longitude: 116.395151))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}