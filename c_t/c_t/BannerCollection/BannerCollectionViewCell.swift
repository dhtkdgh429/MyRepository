//
//  BannerCollectionViewCell.swift
//  c_t
//
//  Created by Oh Sangho on 2018. 9. 16..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! {
        didSet {
            self.imageView.image = image
            self.setNeedsLayout()
        }
    }
}
