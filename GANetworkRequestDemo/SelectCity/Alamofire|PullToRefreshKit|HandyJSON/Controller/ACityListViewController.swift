//
//  ACityListViewController.swift
//  GANetworkRequestDemo
//
//  Created by Gamin on 2020/3/9.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit
import HandyJSON
import PullToRefreshKit

class ACityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var dataMArr: [ACityListModel] = [];
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
        tableView.register(UINib(nibName: "ACityListCell", bundle: nil), forCellReuseIdentifier: "ACityListCell");
        tableView.configRefreshHeader(container: self) { [weak self] in
            self?.refresh();
        }
        tableView.configRefreshFooter(container:self) { [weak self] in
            self?.refreshMore();
        };
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
        ACityListAPI.requestCityList(group: "cn", page: "\(page)" as NSString, number: "50", lang: "cn", success: { (responseObject) in
            let weather = responseObject?["HeWeather6"] as! Array<Any>;
            let basic = ((weather[0] as! Dictionary<String, Any>)["basic"]) as! Array<Any>;
            if (basic.count > 0) {
                var listArr = Array<Any>();
                for obj in basic {
                    if let model = ACityListModel.deserialize(from: obj as? Dictionary) {
                        listArr.append(model);
                    }
                }
                self.dataMArr = listArr as! [ACityListModel];
            }
            self.tableView.switchRefreshHeader(to: .normal(.success, 0.5));
            self.tableView.switchRefreshFooter(to: .noMoreData);
            self.tableView.reloadData();
        }) { (error) in

        }
        /*
        ACityListAPI.postRequestCityList(group: "cn", page: "\(page)" as NSString, number: "50", lang: "cn", success: { (responseObject) in
            let weather = responseObject?["HeWeather6"] as! Array<Any>;
            let basic = ((weather[0] as! Dictionary<String, Any>)["basic"]) as! Array<Any>;
            if (basic.count > 0) {
                var listArr = Array<Any>();
                for obj in basic {
                    if let model = ACityListModel.deserialize(from: obj as? Dictionary) {
                        listArr.append(model);
                    }
                }
                self.dataMArr = listArr as! [ACityListModel];
            }
            self.tableView.switchRefreshHeader(to: .normal(.success, 0.5));
            self.tableView.switchRefreshFooter(to: .noMoreData);
            self.tableView.reloadData();
        }) { (error) in
            
        }
        */
    }

    // MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ACityListCell", for: indexPath) as! ACityListCell;
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
