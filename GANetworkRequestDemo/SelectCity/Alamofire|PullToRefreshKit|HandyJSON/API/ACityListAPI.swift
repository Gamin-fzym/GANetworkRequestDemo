//
//  ACityListAPI.swift
//  GANetworkRequestDemo
//
//  Created by Gamin on 2020/3/9.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class ACityListAPI: NSObject {
    // 和风天气控制台应用的key https://console.heweather.com/app/index
    static let CITY_KEY = "447d7b4d0f074982910f76250d55e4e0";
    // 域名
    static let CITY_DOMAIN = "https://search.heweather.net";
    
    /*
     参数:
     group  world:全球 cn:中国 overseas:海外（不包括中国）
     number 返回热门城市的数量，默认返回20个，可选1-50个
     lang   多语言，默认为简体中文(lang=en)，海外城市默认为英文。详见 https://dev.heweather.com/docs/refer/i18n
     */
    class func requestCityList(group: String, page: NSString, number: String, lang: String, success:((_ responseObject:AnyObject?) -> Void)?, failure:((_ error:NSError) -> Void)?) -> Void {
        
        let url = CITY_DOMAIN + "/top?" + "group=" + group + "&key=" + CITY_KEY + "&number=" + number + "&lang=" + lang;
        Alamofire.AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseObject) in
            if (responseObject.error == nil) {
                //let tempJSONString = String(data: responseObject.data!, encoding: String.Encoding.utf8);
                let tempDict = try? JSONSerialization.jsonObject(with: responseObject.data!, options: .mutableContainers);
                if tempDict != nil {

                }
                success!(tempDict as AnyObject);
            } else {
                failure!(responseObject.error! as NSError);
            }
        }
    }
    
    // post请求
    class func postRequestCityList(group: String, page: NSString, number: String, lang: String, success:((_ responseObject:AnyObject?) -> Void)?, failure:((_ error:NSError) -> Void)?) -> Void {
        
        let url = CITY_DOMAIN + "/top";
        var parm = [String: Any]();
        parm["group"] = group;
        parm["key"] = CITY_KEY;
        parm["number"] = number;
        parm["lang"] = lang;

        Alamofire.AF.request(url, method: .post, parameters: parm, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseObject) in
            if (responseObject.error == nil) {
                //let tempJSONString = String(data: responseObject.data!, encoding: String.Encoding.utf8);
                let tempDict = try? JSONSerialization.jsonObject(with: responseObject.data!, options: .mutableContainers);
                if tempDict != nil {

                }
                success!(tempDict as AnyObject);
            } else {
                failure!(responseObject.error! as NSError);
            }
        }
    }

}
