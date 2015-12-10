//
//  NetworkRequest.swift
//  SnapShot
//
//  Created by Jacob Li on 19/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import Alamofire

class HttpControl {
    
    var delegate: HttpProtocol
    
    init(delegate:HttpProtocol) {
        self.delegate = delegate
    }
    
    /**
     接收一个网址，然后回调代理方法，回传数据
     - parameter url: 网址
     */
    
    func onRequest(url: String) {
        Alamofire.request(.POST, url).responseJSON {response in
            if(response.result.error != nil) {
                self.delegate.didRecieveError(response.result.error!)
            } else {
                self.delegate.didRecieveResults(response.result.value!)
            }
        }
    }
    
    /**
     接收一个网址和参数，然后回调代理方法，回传数据
     - parameter url: 网址
     - parameter 参数:
     */
    func onRequestWithParams (url: String, param: Parameters) {
        print(param.parametersDic)
        Alamofire.Manager.sharedInstance.request(Method.POST, url, parameters:param.parametersDic, encoding:ParameterEncoding.URL).responseJSON(options: NSJSONReadingOptions.MutableContainers){
            response -> Void in
            if(response.result.error != nil) {
                self.delegate.didRecieveError(response.result.error!)
            } else {
                self.delegate.didRecieveResults(response.result.value!)
            }
        }
    }
    
}

protocol HttpProtocol {
    func didRecieveResults(results:AnyObject)
    func didRecieveError(error:AnyObject)
}