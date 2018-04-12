//
//  SummaryTableViewCell.swift
//  Weather
//
//  Created by Keun young Kim on 2018. 2. 28..
//  Copyright © 2018년 Keun young Kim. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

   @IBOutlet weak var weatherImageView: UIImageView!
   
   @IBOutlet weak var skyNameLabel: UILabel!
   
   @IBOutlet weak var minMaxLabel: UILabel!
   
   @IBOutlet weak var tempLabel: UILabel!
   
   
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      backgroundColor = UIColor.clear
      skyNameLabel.textColor = UIColor.white
      minMaxLabel.textColor = UIColor.white
      tempLabel.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
