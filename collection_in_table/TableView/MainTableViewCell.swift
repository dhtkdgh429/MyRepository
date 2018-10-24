//
//  MainTableViewCell.swift
//  collection_in_table
//
//  Created by Oh Sangho on 2018. 9. 16..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var _collectionView: UICollectionView! {
        didSet {
            _collectionView.dataSource = self
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


extension MainTableViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        
        let imageName = "banner\(indexPath.item % 5)"
        cell.bannerImg.image = UIImage(named: imageName)

        return cell
    }
    
}


