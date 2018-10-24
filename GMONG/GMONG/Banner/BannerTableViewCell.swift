//
//  BannerTableViewCell.swift
//  GMONG
//
//  Created by Oh Sangho on 2018. 9. 25..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    // 배너 이미지 배열
    var arrBannerImages = (0...5).map{UIImage(named: "banner_\($0)")}
    
    public var timer: DispatchSourceTimer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // collectionview 레이아웃 set
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(
                top: Constant.offset,    // top
                left: Constant.offset,    // left
                bottom: Constant.offset,    // bottom
                right: Constant.offset     // right
            )
            
            layout.minimumInteritemSpacing = Constant.minItemSpacing
            layout.minimumLineSpacing = Constant.minLineSpacing
        }
        // collectionView scrolling.
        //collectionView.isScrollEnabled = true
        
        // collectionView 하나씩 넘기기. paging.
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    // 배너 타이머 구현 코드
    func resumeTimer() {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            timer?.schedule(deadline: .now() + 5, repeating: .seconds(5))
            timer?.setEventHandler(handler: {
                [weak self] in
                if var indexPath = self?.collectionView.indexPathsForVisibleItems.first {
                    indexPath.item += 1
                    
                    self?.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                }
            })
            
            timer?.resume()
        }
    }

}

extension BannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 배너 임의의 다량의 수 1만개 section 지정. index 처음 or 끝인 경우 중간 지점으로 이동하도록 하여 무한 페이징 가능하도록.
        return 10000
    }
    
    // collectionview cell 바인딩
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        // 배너 이미지 배열에서 6개 뽑아내기.
        cell.imageView?.image = arrBannerImages[indexPath.row % 6]
        cell.imageView.layer.cornerRadius = 5
        return cell
    }
}

extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = Constant.getItemWidth(boundWidth: collectionView.bounds.size.width)
        
        return CGSize(width: itemWidth, height: itemWidth)
        //return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // index 처음 or 끝인 경우 중간 지점으로 이동하도록 하여 무한 페이징 가능하도록.
        if (indexPath.row == 0 || indexPath.row == 9999) {
            let targetIndexPath = IndexPath(item: 5000, section: 0)
            collectionView.selectItem(at: targetIndexPath, animated: false, scrollPosition: .centeredHorizontally)
            
            // 배너 타이머 구현
            resumeTimer()
            // focus 업데이트
            cell.updateFocusIfNeeded()
        }
    }
    
}
