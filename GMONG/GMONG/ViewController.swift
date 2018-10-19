//
//  ViewController.swift
//  GMONG
//
//  Created by Oh Sangho on 2018. 9. 25..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:     // Banner Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell
            return cell
//        case 1:     // Menu Cell
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
//            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // tableView height 동적 할당
        switch indexPath.row {
        case 0:     // Banner Cell
            let itemHeight = Constant.getItemWidth(boundWidth: tableView.bounds.size.width)
            
            let totalRow = ceil(Constant.totalItem / Constant.column)
            
            let totalTopBottomOffset = Constant.offset + Constant.offset
            
            let totalSpacing = CGFloat(totalRow - 1) * Constant.minLineSpacing
            
            let totalHeight  = (itemHeight + totalTopBottomOffset + totalSpacing) / 2
            
            return totalHeight
        case 1:     // Menu Cell
            let itemHeight = Constant.getItemWidth(boundWidth: tableView.bounds.size.width)

            let totalRow = ceil(Constant.totalItem / Constant.column)

            let totalTopBottomOffset = Constant.offset + Constant.offset

            let totalSpacing = CGFloat(totalRow - 1) * Constant.minLineSpacing

            let totalHeight  = (itemHeight + totalTopBottomOffset + totalSpacing)

            return totalHeight
        // height 동적 할당 시 default에서 automaticDimension 필수
        default:
            return UITableView.automaticDimension
        }
    }
}
