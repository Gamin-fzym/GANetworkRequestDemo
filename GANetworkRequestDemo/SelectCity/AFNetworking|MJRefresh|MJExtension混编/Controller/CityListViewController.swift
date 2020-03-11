//
//  CityListViewController.swift
//  DMSelectCityDemo
//
//  Created by Gamin on 2020/2/23.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit

typealias SelectModelBlock = (_ selectModel: CityListModel) -> ();

class CityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var dataMArr: [CityListModel] = [];
    private var page: Int = 0;
    var selectBlock: SelectModelBlock?;
    
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
        // 纯代码的cell
        //tableView.register(LinkmanListCell.self, forCellReuseIdentifier: "LinkmanListCell");
        // xib的cell
        tableView.register(UINib(nibName: "CityListCell", bundle: nil), forCellReuseIdentifier: "CityListCell");
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.refresh();
        });
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.refreshMore();
        });
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
        CityListAPI.requestCityList(group: "cn", page: "\(page)" as NSString, number: "50", lang: "cn", success: { (responseObject) in
            let weather = responseObject?["HeWeather6"] as! Array<Any>;
            let basic = ((weather[0] as! Dictionary<String, Any>)["basic"]) as! Array<Any>;
            if (basic.count > 0) {
                let listArr = CityListModel.mj_objectArray(withKeyValuesArray: basic);
                self.dataMArr = listArr as! [CityListModel];
            }
            self.tableView.mj_header?.endRefreshing();
            self.tableView.mj_footer?.endRefreshing();
            self.tableView.reloadData();
        }) { (error) in
            
        }
        /*
        CityListAPI.postRequestCityList(group: "cn", page: "\(page)" as NSString, number: "50", lang: "cn", success: { (responseObject) in
            let weather = responseObject?["HeWeather6"] as! Array<Any>;
            let basic = ((weather[0] as! Dictionary<String, Any>)["basic"]) as! Array<Any>;
            if (basic.count > 0) {
                let listArr = CityListModel.mj_objectArray(withKeyValuesArray: basic);
                self.dataMArr = listArr as! [CityListModel];
            }
            self.tableView.mj_header?.endRefreshing();
            self.tableView.mj_footer?.endRefreshing();
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityListCell", for: indexPath) as! CityListCell;
        if (dataMArr.count > indexPath.row) {
            cell.cellModel = dataMArr[indexPath.row];
        } else {
            cell.cellModel = nil;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CityListCell;
        guard let model = cell?.cellModel else {
            return;
        }
        if ((selectBlock) != nil) {
            selectBlock!(model);
        }
        navigationController?.popViewController(animated: true);
    }
}
