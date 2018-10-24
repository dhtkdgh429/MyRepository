//
//  ViewController.swift
//  collection_in_table
//
//  Created by Oh Sangho on 2018. 9. 16..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: // 첫번째, BannerCollectionView cell
            let itemHeight = Constant.getItemWidth(boundWidth: tableView.bounds.size.width)
            
            let totalRow = ceil(Constant.totalItem / Constant.column)
            
            let totalTopBottomOffset = Constant.offset + Constant.offset
            
            let totalSpacing = CGFloat(totalRow - 1) * Constant.minLineSpacing
            
            let totalHeight  = ((itemHeight * CGFloat(totalRow)) + totalTopBottomOffset + totalSpacing)
            
            return totalHeight
            
        case 1: // 두번째, cell
            return 150
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            cell._collectionView.isScrollEnabled = false
            cell._collectionView.dataSource = self
            cell._collectionView.delegate = self
        }
    }
}

extension BannerCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = Constant.getItemWidth(boundWidth: _collectionView.bounds.size.width)
        
        // cell 크기는 정사각형으로 리턴.
        return CGSize(width: itemWidth, height: itemWidth)
    }
}



