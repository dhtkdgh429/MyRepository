//
//  CategoryTableViewCell.swift
//  GMONG
//
//  Created by Oh Sangho on 2018. 9. 25..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // 카테고리 이미지 배열
    var arrCategoryImages = (0...8).map{UIImage(named: "ic_category_\($0)")}
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // collectionView layout set
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(
                top: Constant.offset,
                left: Constant.offset,
                bottom: Constant.offset,
                right: Constant.offset)
            
            layout.minimumInteritemSpacing = Constant.minItemSpacing
            layout.minimumLineSpacing = Constant.minLineSpacing
            
        }
        
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


extension CategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 카테고리 이미지 count만큼 section 생성
        return arrCategoryImages.count
        
    }
    // collectionview cell 바인딩
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        // 배너 이미지 배열에서 이미지 뽑아내기.
        cell.categoryImageView.image = arrCategoryImages[indexPath.row % 9]
        
        return cell
    }
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let itemWidth = Constant.getItemWidth(boundWidth: collectionView.bounds.size.width)
        
        //return CGSize(width: itemWidth, height: itemWidth)
        
        let size = CGSize(width: 125, height: 75)
        return size
    }
}



