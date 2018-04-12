//
//  MemoTableViewCell.swift
//  Memo_Test
//
//  Created by Oh Sangho on 2018. 2. 20..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    static let identifier = "MemoTableViewCell"
    
    
    @IBOutlet weak var memoTitleLabel: UILabel!
    
    @IBOutlet weak var memoContentLabel: UILabel!
    
    @IBOutlet weak var memoDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
