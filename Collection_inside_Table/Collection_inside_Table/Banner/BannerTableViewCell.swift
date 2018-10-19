//
//  BannerTableViewCell.swift
//  Collection_inside_Table
//
//  Created by Oh Sangho on 2018. 9. 24..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


extension BannerTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerColelctionView", for: indexPath) as! BannerCollectionViewCell
        let imageName = "banner0\(indexPath.item % 3)"
        
        cell.imageView.image = UIImage(named: imageName)
        
        return cell
    }
}

extension BannerTableViewCell : UICollectionViewDelegate {
    
}

extension BannerTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = Constant.getItemWidth(boundWidth: collectionView.bounds.size.width)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
