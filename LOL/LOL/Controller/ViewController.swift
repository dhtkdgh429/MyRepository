//
//  ViewController.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit
import SwiftyJSON

// protocol 사용 안함. 지금은 몇개 없어서 protocol보다 segue가 간단함 ㅎㅎ
protocol CellDataDelegate: class {
        func searchedSummonerId(info: Int)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var _btnSearch: UIButton!
    
    let lolApi = LOLApi()
    public var summoner : SummonerModel?
    public var leagueModel : LeagueModel?
    
    weak var delegate: CellDataDelegate?
    
    // callFindSummoner 서비스로 찾은 id 값
    public var foundId:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //_btnSearch.addTarget(self, action: #selector(setter: _btnSearch), for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "leagueSegue" {

            let leagueVC : LeagueController = segue.destination as! LeagueController
            // delegate 위임
            //leagueVC.delegate = self
            
            
        }
    }
    
    @IBAction private func _btnSearch(_ sender: UIButton) {
        DispatchQueue.main.async {
            if let name = self.inputName.text {
                self.callFindSummoner(userName: name)
            }
        }
        performSegue(withIdentifier: "leagueSegue", sender: sender)
        
        delegate?.searchedSummonerId(info: foundId)
    }
    
//    @objc func btnSearchClicked() {
//
//        // name으로 id 찾는 서비스 호출.
//        if let name = inputName.text {
//
//        }
//    }
    
//    func searchedSummonerId(info:Int) {
//
//        let detailController = LeagueController(nibName: "LeagueController", bundle: nil)
//        detailController.info = self.summoner
//        self.navigationController?.pushViewController(detailController, animated: true)
//    }
    
    
//    func selectPatientDetail(info:MyPatient) {
//
//        let detailController = ViewPatientDetail(nibName: "ViewPatientDetail", bundle: nil)
//        detailController.selectedPatientInfo = info
//        self.navigationController?.pushViewController(detailController, animated: true)
//    }
    
    
    
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
                        self.summoner = summoner
                        self.foundId = summoner.items[0].id
                        
                        // summoner model data 전달
                        //self.delegate?.searchLeagueDetail!(info: summoner)
                        
                    }
                    
                }
            }
        }
    }
    
    
    // findSummoner 서비스로 찾은 id(foundId) 값으로 league 서비스 호출
    func callLeagueBySummonerId(id: Int) {
        
        //lolApi.getFindSummoner(name: "콩이눈높이교육")
        lolApi.getLeagueBySummonerId(id: id) { (responseObject: WebServiceResult?) in
            
            // error check
            if(responseObject?.errorOccurred == true) {
                #if DEBUG
                print("Please Check to Error Message OR Network status")
                print("ErrorMessage : \(responseObject?.errorMessage)")
                #endif
                return
            }
            
            if let json = responseObject?.items2 {
                print("JSON: \(json)") // serialized json response
                
                if((json as AnyObject).isEmpty == true) { // no Data
                    
                }
                else
                {
                    // model에 파싱된 json 데이터 insert
                    if let legue = LeagueModel(json: json as [[String : Any]]) {
                        // 혹시 모르니, 일단 summonerModel 전역으로 빼놓고.
                        self.leagueModel = legue
                        
                        print(legue.arrItems)
                    }
                    
                }
            }
        }
    }
    
    
    
}

/*
 
 1.
func selectPatientDetail(info:MyPatient) {
    
    let detailController = ViewPatientDetail(nibName: "ViewPatientDetail", bundle: nil)
    detailController.selectedPatientInfo = info
    self.navigationController?.pushViewController(detailController, animated: true)
}

 
 2.
func gotoPatientDetail(_ infoData:Schedule) {
    let patient = selectedPatient(info: infoData)
 
 3.
    delegate?.selectPatientDetail?(info:patient)
}
 
 
 4.
 gotoPatientDetail(selectedCell.schedule!)

 
 */
