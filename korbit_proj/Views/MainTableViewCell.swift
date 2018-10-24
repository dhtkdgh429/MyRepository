//
//  MainTableViewCell.swift
//  korbit_proj
//
//  Created by Oh Sangho on 2018. 5. 23..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImg: UIImageView!
    
    @IBOutlet weak var coinName: UILabel!
    
    @IBOutlet weak var coinPrice: UILabel!
    
    @IBOutlet weak var coinRate: UILabel!
    
    @IBOutlet weak var KRW: UILabel!
    
    @IBOutlet weak var coinExchange: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
