//
//  HolidayTableViewCell.swift
//  HolidayApi
//
//  Created by Ethan on 2020/1/30.
//  Copyright © 2020 playplay. All rights reserved.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    
    var holiday:Holiday?{
        didSet{
            guard let holiday = holiday else {return}
            
            holiday.name.bind {[weak self] (name) in
                self?.nameLabel.text = name
            }
            holiday.description.bind {[weak self] (description) in
                self?.descriptionLabel.text = description
            }
            holiday.date.value.iso.bind {[weak self] (iso) in
                self?.dateLabel.text = iso
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
