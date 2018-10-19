//
//  BannerCollectionViewCell.swift
//  Collection_inside_Table
//
//  Created by Oh Sangho on 2018. 9. 24..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage? {
        didSet {
            self.imageView.image = image
            self.layoutIfNeeded()
        }
    }
}
