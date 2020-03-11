//
//  HomeViewController.swift
//  DMSelectCityDemo
//
//  Created by Gamin on 2020/2/23.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var selectCityBut: UIButton!
    @IBOutlet weak var picIV: UIImageView!
    @IBOutlet weak var picBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页";
    }

    @IBAction func tapCityListAction(_ sender: Any) {
        let tag = (sender as! UIButton).tag;
        if (tag == 1000) {
            let cityList = CityListViewController();
            cityList.selectBlock = { [weak self] (selectModel: CityListModel) -> () in
                if (!selectModel.isEqual(nil)) {
                    self?.selectCityBut.setTitle("选择了" + (selectModel.location ?? ""), for: .normal);
                }
            }
            navigationController?.pushViewController(cityList, animated: true);
        } else if (tag == 1001) {
            let cityList = ACityListViewController();
            navigationController?.pushViewController(cityList, animated: true);
        } else if (tag == 1002) {
            let cityList = BCityListViewController();
            navigationController?.pushViewController(cityList, animated: true);
        }
    }
    
}
