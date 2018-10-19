//
//  ViewController.swift
//  Collection_inside_Table
//
//  Created by Oh Sangho on 2018. 9. 24..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath)
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath)
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :    // header Cell
            return 100
            
        case 1 :    // Banner Cell
            
            let itemHeight = Constant.getItemWidth(boundWidth: tableView.bounds.size.width)
            
            let totalRow = ceil(Constant.totalItem / Constant.column)
            
            let totalTopBottomOffset = Constant.offset + Constant.offset
            
            let totalSpacing = CGFloat(totalRow - 1) * Constant.minLineSpacing
            
            let totalHeight  = ((itemHeight * CGFloat(totalRow)) + totalTopBottomOffset + totalSpacing)
            
            return totalHeight
            
        default :
            return UITableViewAutomaticDimension
        }
    }
}
