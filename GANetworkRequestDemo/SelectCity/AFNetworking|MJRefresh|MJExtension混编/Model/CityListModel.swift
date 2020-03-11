//
//  CityListModel.swift
//  DMSelectCityDemo
//
//  Created by Gamin on 2020/2/23.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit

class CityListModel: NSObject {

    @objc var location: String?;      // 地区／城市名称     卓资
    @objc var cid: String?;           // 地区／城市ID     CN101080402
    @objc var lat: String?;           // 地区／城市纬度     40.89576
    @objc var lon: String?;           // 地区／城市经度     112.577702
    @objc var parent_city: String?;   // 该地区／城市的上级城市     乌兰察布
    @objc var admin_area: String?;    // 该地区／城市所属行政区域     内蒙古
    @objc var cnty: String?;          // 该地区／城市所属国家名称     中国
    @objc var tz: String?;            // 该地区／城市所在时区     +8.0
    @objc var type: String?;          // 该地区／城市的属性，目前有city城市和scenic中国景点     city
    
}
