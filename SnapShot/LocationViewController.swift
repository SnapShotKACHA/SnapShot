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
    var currentLocation:CLLocation?
    var speedShotFrame:SpeedShotFrame?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MAMapServices.sharedServices().apiKey = AMAP_KEY
        initMapView()
    }
    
    func initMapView() {
        speedShotFrame = SpeedShotFrame()
        
        mapView = MAMapView(frame: self.view.bounds)
        mapView?.delegate = self
        mapView!.addSubview(speedShotFrame!)
        self.view.addSubview(mapView!)
        
        //设置指南针和比例尺的位置
        mapView?.showsCompass = true
        mapView?.showsScale = true
        mapView?.compassOrigin = CGPointMake(10, 100)
        mapView?.scaleOrigin = CGPointMake(10, self.view.frame.height - 100)
        
        // 开启定位
        mapView!.showsUserLocation = true
        
        // 设置跟随定位模式，将定位点设置成地图中心点
        mapView!.userTrackingMode = MAUserTrackingMode.Follow
    }
    
    func initMapSearch() {
        mapSearch = AMapSearchAPI()
        mapSearch?.delegate = self
    }
    
    // 逆地理编码
    func reverseGeocoding(){
        
        let coordinate = currentLocation?.coordinate
        
        // 构造 AMapReGeocodeSearchRequest 对象，配置查询参数（中心点坐标）
        let regeo: AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
        
        regeo.location = AMapGeoPoint.locationWithLatitude(CGFloat(coordinate!.latitude), longitude: CGFloat(coordinate!.longitude))
        
        print("regeo :\(regeo)")
        
        // 进行逆地理编码查询
        self.mapSearch!.AMapReGoecodeSearch(regeo)
        
    }
    
    // 定位回调
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            currentLocation = userLocation.location
        }
    }
    
    // 点击Annoation回调
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        // 若点击的是定位标注，则执行逆地理编码
        if view.annotation.isKindOfClass(MAUserLocation){
            reverseGeocoding()
        }
    }
    
    // 逆地理编码回调
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        print("request :\(request)")
        print("response :\(response)")
        
        if (response.regeocode != nil) {
            
            var title = response.regeocode.addressComponent.city
            
            var length: Int = 1
            
            if (length == 0){
                title = response.regeocode.addressComponent.province
            }
            //给定位标注的title和subtitle赋值，在气泡中显示定位点的地址信息
            mapView?.userLocation.title = title
            mapView?.userLocation.subtitle = response.regeocode.formattedAddress
        }
        
    }
    
}