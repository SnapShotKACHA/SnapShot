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
    
    func onRequest(_ url: String) {
        Alamofire.request(Method.GET, url).responseJSON {response in
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
    func onRequestWithParams(_ url: String, param: Parameters) {
        print(param.parametersDic)
        Alamofire.Manager.sharedInstance.request(Method.POST, url, parameters:param.parametersDic, encoding:ParameterEncoding.url).responseJSON(options: JSONSerialization.ReadingOptions.mutableContainers){
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
    func didRecieveResults(_ results:AnyObject)
    func didRecieveError(_ error:AnyObject)
}
