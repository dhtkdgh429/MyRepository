//
//  ViewController.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    let lolApi = LOLApi()
    public var summonerModel : SummonerModel?
    
    // callFindSummoner 서비스로 찾은 id 값
    public var foundId:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        btnSearch.addTarget(self, action: #selector(btnSearchClicked), for: .touchUpInside)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("leagueSegue"):
            if let vc = segue.destination as? LeagueController, let cell = sender as? UITableViewCell, let indexPath = LeagueController.indexPath(for: cell) {
                vc.course = courseList[indexPath.item]
            }
        default:
            super.prepare(for: segue, sender: sender)
        }
    }
    
    @objc func btnSearchClicked() {
        
        // name으로 id 찾는 서비스 호출.
        callFindSummoner(userName: inputName.text!)
        
    }
    
    // userName(= summonerName)으로 id 값 찾기.
    func callFindSummoner(userName: String) {
        
        //lolApi.getFindSummoner(name: "콩이눈높이교육")
        lolApi.getFindSummoner(name: userName) { (responseObject: WebServiceResult?) in
            
            // error check
            if(responseObject?.errorStatusCode != nil) {
                #if DEBUG
                print("Please Check to Error Message OR Network status")
                print("ErrorMessage : \(responseObject?.errorMessage)")
                #endif
                return
            }
            
            if let json = responseObject?.items {
                print("JSON: \(json)") // serialized json response
                
                if((json as AnyObject).isEmpty == true) { // no Data
                    
                }
                else
                {
                    // model에 파싱된 json 데이터 insert
                    if let summoner = SummonerModel(json: [json as [String : Any]]) {
                        // 혹시 모르니, 일단 summonerModel 전역으로 빼놓고.
                        self.summonerModel = summoner
                        self.foundId = summoner.items[0].id
                        
                    }
                    
                }
            }
        }
    }
    
    
}

