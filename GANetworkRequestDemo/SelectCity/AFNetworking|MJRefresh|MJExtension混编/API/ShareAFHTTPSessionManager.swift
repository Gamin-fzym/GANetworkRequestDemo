//
//  ShareAFHTTPSessionManager.swift
//  DMSelectCityDemo
//
//  Created by Gamin on 2020/2/24.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit

class ShareAFHTTPSessionManager: AFHTTPSessionManager {
    
    static let shareInstance : ShareAFHTTPSessionManager = {
        let baseUrl = NSURL(string: "xxxxxx")!;
        let manager = ShareAFHTTPSessionManager.init(baseURL: baseUrl as URL, sessionConfiguration: URLSessionConfiguration.default);
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "pplication/json","text/plain") as? Set<String>;
        manager.requestSerializer.timeoutInterval = 60;
        return manager;
    }()
    
    /**
     get请求
     
     - parameter urlString:  请求的url
     - parameter parameters: 请求的参数
     - parameter success:    请求成功回调
     - parameter failure:    请求失败回调
     */
    class func get(urlString:String,parameters:AnyObject?,success:((_ responseObject:AnyObject?) -> Void)?,failure:((_ error:NSError) -> Void)?) -> Void {
        ShareAFHTTPSessionManager.shareInstance.get(urlString, parameters: parameters, progress: { (progress) in
            
        }, success: { (task, responseObject) in
            // 如果responseObject不为空时
            if responseObject != nil {
                success!(responseObject as AnyObject?);
            }
        }, failure: { (task, error) in
            failure!(error as NSError);
        })
    }
    
    /**
     post请求
     
     - parameter urlString:  请求的url
     - parameter parameters: 请求的参数
     - parameter success:    请求成功回调
     - parameter failure:    请求失败回调
     */
    class func post(urlString:String,parameters:AnyObject?,success:((_ responseObject:AnyObject?) -> Void)?,failure:((_ error:NSError) -> Void)?) -> Void {
        ShareAFHTTPSessionManager.shareInstance.post(urlString, parameters: parameters, progress: { (progress) in
            
        }, success: { (task, responseObject) in
            // 如果responseObject不为空时
            if responseObject != nil {
                success!(responseObject as AnyObject?);
            }
        }, failure:  { (task, error) in
            failure!(error as NSError);
        })
    }
    
}
