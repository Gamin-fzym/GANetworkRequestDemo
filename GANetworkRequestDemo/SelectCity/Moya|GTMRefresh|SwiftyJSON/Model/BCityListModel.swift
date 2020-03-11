//
//  BCityListModel.swift
//  GANetworkRequestDemo
//
//  Created by Gamin on 2020/3/9.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit
import SwiftyJSON

class BCityListModel: NSObject {

    @objc var location: String?;      // 地区／城市名称     卓资
    @objc var cid: String?;           // 地区／城市ID     CN101080402
    @objc var lat: String?;           // 地区／城市纬度     40.89576
    @objc var lon: String?;           // 地区／城市经度     112.577702
    @objc var parent_city: String?;   // 该地区／城市的上级城市     乌兰察布
    @objc var admin_area: String?;    // 该地区／城市所属行政区域     内蒙古
    @objc var cnty: String?;          // 该地区／城市所属国家名称     中国
    @objc var tz: String?;            // 该地区／城市所在时区     +8.0
    @objc var type: String?;          // 该地区／城市的属性，目前有city城市和scenic中国景点     city

    init(jsonData: JSON) {
        location    = jsonData["location"].stringValue
        cid         = jsonData["cid"].stringValue
        lat         = jsonData["lat"].stringValue
        lon         = jsonData["lon"].stringValue
        parent_city = jsonData["parent_city"].stringValue
        admin_area  = jsonData["admin_area"].stringValue
        cnty        = jsonData["cnty"].stringValue
        tz          = jsonData["tz"].stringValue
        type        = jsonData["type"].stringValue
    }
}

/*
 class BCityListModel: Decodable {

    @objc var location: String?;      // 地区／城市名称     卓资
    @objc var cid: String?;           // 地区／城市ID     CN101080402
    @objc var lat: String?;           // 地区／城市纬度     40.89576
    @objc var lon: String?;           // 地区／城市经度     112.577702
    @objc var parent_city: String?;   // 该地区／城市的上级城市     乌兰察布
    @objc var admin_area: String?;    // 该地区／城市所属行政区域     内蒙古
    @objc var cnty: String?;          // 该地区／城市所属国家名称     中国
    @objc var tz: String?;            // 该地区／城市所在时区     +8.0
    @objc var type: String?;          // 该地区／城市的属性，目前有city城市和scenic中国景点     city

    // 解决服务端下发的key跟APP端上定义的不一致
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case cid
        case lat
    }
}*/

/*
//let decoder = JSONDecoder()
//if let data = try? JSONSerialization.data(withJSONObject: obj, options: []) {
//    let user = try? decoder.decode(BCityListModel.self, from: data)
//}
 */
