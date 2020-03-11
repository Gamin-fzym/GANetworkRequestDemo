//
//  BCityListAPI.swift
//  GANetworkRequestDemo
//
//  Created by Gamin on 2020/3/9.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit
import Moya

// 和风天气控制台应用的key https://console.heweather.com/app/index
private let CITY_KEY = "447d7b4d0f074982910f76250d55e4e0";

// 请求分类
public enum BCityListAPI {
    case cityList(group: String, page: NSString, number: String, lang: String)  // 城市列表
    case cityInfo(group: String, page: NSString, number: String, lang: String)  // 城市
}
 
// 请求配置
extension BCityListAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {
        switch self {
        case .cityList(_):
            return URL(string: "https://search.heweather.net/top")!
        case .cityInfo(_):
            return URL(string: "https://search.heweather.net/top")!
        }
    }
     
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .cityList(_):
            return "";
        case .cityInfo(_):
            return ""
        }
    }
     
    // 请求类型
    public var method: Moya.Method {
        switch self {
        case .cityList:
            return .get
        case .cityInfo:
            return .post
        }
    }
     
    // 请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .cityList(let group, let page, let number, let lang):
            var params: [String: Any] = [:]
            params["group"] = group;
            params["key"] = CITY_KEY;
            params["number"] = number;
            params["lang"] = lang;
            // 参数放在请求的url中
            return .requestParameters(parameters: params, encoding: URLEncoding.default);
        case .cityInfo(let group, let page, let number, let lang):
            var params: [String: Any] = [:]
            params["group"] = group;
            params["key"] = CITY_KEY;
            params["number"] = number;
            params["lang"] = lang;
            // 参数放在HttpBody中
            return .requestParameters(parameters: params, encoding: URLEncoding.httpBody);
            //return .requestData(jsonToData(jsonDic: params)!);
        default:
            return .requestPlain;
        }
    }
    
    // 字典转Data
    private func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            print("is not a valid json object")
            return nil
        }
        // 利用自带的json库转换成Data
        // 如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        // Data转换成String打印输出
        let str = String(data:data!, encoding: String.Encoding.utf8)
        // 输出json字符串
        print("Json Str:\(str!)")
        return data
    }
     
    // 要对请求执行的验证类型。 默认为`.none`。(可能使用到的次数不多)
    public var validate: Bool {
        return false
    }
     
    // 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
     
    // 请求头
    public var headers: [String: String]? {
        return ["Content-type" : "application/json"];
    }
}
