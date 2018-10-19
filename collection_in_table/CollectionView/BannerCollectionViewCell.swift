//
//  BannerCollectionViewCell.swift
//  collection_in_table
//
//  Created by Oh Sangho on 2018. 9. 16..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BannerCollectionViewCell"
    
    @IBOutlet weak var bannerImg: UIImageView!
    
    var image: UIImage {
        didSet {
            self.bannerImg.image = image
            self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // disable scroll because we dont want collectionview to be scrolled inside cell
    }
}


