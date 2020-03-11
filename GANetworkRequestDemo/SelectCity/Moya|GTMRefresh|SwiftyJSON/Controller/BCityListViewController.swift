//
//  BCityListViewController.swift
//  GANetworkRequestDemo
//
//  Created by Gamin on 2020/3/9.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit
import GTMRefresh
import SwiftyJSON
import Moya

class BCityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var dataMArr: [BCityListModel] = [];
    private var page: Int = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择城市";
        setupTableViewUI();
    }
    
    func setupTableViewUI() {
        // 设置透明，默认为NO控制器中y=0实际效果上=64，设置为YES时控制器中y=0实际效果上y=0
        navigationController?.navigationBar.isTranslucent = false;
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.insetsContentViewsToSafeArea = false;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.register(UINib(nibName: "BCityListCell", bundle: nil), forCellReuseIdentifier: "BCityListCell");

        tableView.gtm_addRefreshHeaderView { [weak self] in
            self?.refresh();
        }
        tableView.gtm_addLoadMoreFooterView { [weak self] in
            self?.refreshMore();
        }
        refresh();
    }
    
    // 下拉刷新
    func refresh() {
        page = 0;
        dataMArr.removeAll();
        requestDataAction();
    }
    
    // 上拉加载
    func refreshMore() {
        page += 1;
        requestDataAction();
    }
    
    // 数据请求
    func requestDataAction() {
        // 请求的provider
        let CityProvider = MoyaProvider<BCityListAPI>();
        CityProvider.requestNormal(.cityList(group: "cn", page: "\(page)" as NSString, number: "50", lang: "cn"), callbackQueue: nil, progress: { (response) in
            print("response = \(response)")
        }) { (result) in
            switch result {
            case let .success(result):
                do {
                    // try print("result.mapJSON() = \(result.mapJSON())")
                    let responseObject = try result.mapJSON();
                    let weather = (responseObject as! Dictionary<String, Any>) ["HeWeather6"] as! Array<Any>;
                    let basic = ((weather[0] as! Dictionary<String, Any>)["basic"]) as! Array<Any>;
                    if (basic.count > 0) {
                        var listArr = Array<Any>();
                        for obj in basic {
                            // SwiftyJSON 转成JSON对象
                            let jsonData = JSON.init(obj);
                            let model = BCityListModel(jsonData: jsonData);
                            listArr.append(model);
                            /*
                            // JSONDecoder
                            let decoder = JSONDecoder()
                            if let data = try? JSONSerialization.data(withJSONObject: obj, options: []) {
                                let cityModel = try? decoder.decode(BCityListModel.self, from: data)
                                listArr.append(cityModel);
                            }*/
                        }
                        self.dataMArr = listArr as! [BCityListModel];
                    }
                    self.tableView.endRefreshing();
                    //self.tableView.endLoadMore();
                    self.tableView.reloadData();
                } catch {
                    print("MoyaError.jsonMapping(result) = \(MoyaError.jsonMapping(result))")
                }
            default:
                break
            }
        }
    }

    // MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BCityListCell", for: indexPath) as! BCityListCell;
        if (dataMArr.count > indexPath.row) {
            cell.cellModel = dataMArr[indexPath.row];
        } else {
            cell.cellModel = nil;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
