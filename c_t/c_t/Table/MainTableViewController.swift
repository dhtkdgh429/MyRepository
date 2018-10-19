//
//  ViewController.swift
//  c_t
//
//  Created by Oh Sangho on 2018. 9. 16..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController {
    
    var bannerTableCell:BannerTableViewCell?
    
    struct StoryBoard {
        static let bannerTableViewCell = "BannerTableViewCell"
        //static let menuTableViewCell = "MenuTableViewCell"
        static let bannerCollectionViewCell = "BannerCollectionViewCell"
        //static let menuCollectionViewCell = "MenuCollectionViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension MainTableViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Main Table Cell
        // 0 - Banner
        // 1 - Menu
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.bannerTableViewCell, for: indexPath) as! BannerTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        guard let cellHeight:CGFloat = (bannerTableCell!.bannerSize?.height)! else {
//            let cellHeight:CGFloat = 150.0
//            return cellHeight
//        }
        
//        if cellHeight == nil {
//            bannerTableCell?._collectionView.reloadData()
//        }
        let cellHeight:CGFloat = 150.0
        
        return cellHeight
    }
}

extension MainTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? BannerTableViewCell {
            cell._collectionView.dataSource = self
            cell._collectionView.reloadData()
        }
    }
}

extension MainTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.bannerCollectionViewCell, for: indexPath) as! BannerCollectionViewCell
        
        let imageName = "banner\(indexPath.item % 3)"
        cell.imageView?.image = UIImage(named: imageName)
        
        return cell
    }
    
}


