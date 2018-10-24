//
//  BannerTableViewCell.swift
//  c_t
//
//  Created by Oh Sangho on 2018. 9. 20..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    public var bannerSize:CGSize?
    
    @IBOutlet weak var _collectionView: UICollectionView! {
        didSet {
            _collectionView.dataSource = self
            _collectionView.delegate = self
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

extension BannerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("collection numberOfItemsInSection")
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
        let imageName = "banner0\(indexPath.item % 3)"
        cell.imageView.image = UIImage(named: imageName)
        
        print("collection cellForItemAt : \(imageName)")
        
        return cell
    }
    
}
