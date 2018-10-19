//
//  ViewController.swift
//  korbit_proj
//
//  Created by Oh Sangho on 2018. 5. 23..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar border 하단 표시하는 법 확인.
        // 진행중.
        
    }
    
    
    // image 1개(코인이미지),label 2개 (Bitcoin) (KRW)
    // txt 1개 (140,100)
    // 우측 label 2개, txt 2개 volume, 24시간 (-3%)
    
    

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coinList.count   // cell by coin count. forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        
        
        let target = coinList[indexPath.row]
        cell.coinImg.image = UIImage(named: target.coinCode)
        cell.coinName.text = target.tCoinName    // e.g coinCode: ltc_krw tcoinName = LiteCoin
        cell.coinKRW.text = target.tCoinKRW         // target.tcoinKRW = KRW 변환
        cell.coinPrice.text = target.tCoinPrice
        cell.coinRate.text = target.tCoinRate
        
        return cell
    }
    
}
