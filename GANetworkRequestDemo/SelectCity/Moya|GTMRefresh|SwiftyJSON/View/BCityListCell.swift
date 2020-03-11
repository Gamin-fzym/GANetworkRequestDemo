//
//  BCityListCell.swift
//  DMSelectCityDemo
//
//  Created by Gamin on 2020/2/23.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit

class BCityListCell: UITableViewCell {

    @IBOutlet weak var cityLab: UILabel!
    @IBOutlet weak var cidLab: UILabel!
    @IBOutlet weak var cntyLab: UILabel!
    
    var cellModel: BCityListModel? {
        didSet {
            cityLab.text = cellModel?.location;
            cidLab.text = cellModel?.cid;
            cntyLab.text = cellModel?.cnty;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
