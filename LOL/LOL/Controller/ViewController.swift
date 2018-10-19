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
    
    let lolApi = LOLApi()
    public var summonerModel : SummonerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callFindSummoner()
        
        
    }
    
    func callFindSummoner() {
        
        //lolApi.getFindSummoner(name: "콩이눈높이교육")
        lolApi.getFindSummoner(name: "콩이눈높이교육") { (responseObject: WebServiceResult?) in
            
            // check
            if(responseObject?.errorOccurred == true) {
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
                    //let data = WebServiceResult().jsonToString(json: json as AnyObject)
                    
                    if let summoner = SummonerModel(json: [json as [String : AnyObject]]) {
                        self.summonerModel = summoner
                        
                    }
                    
                    // set
                    //self.infoMaster._infoPatient.myPatient = patient.items
                }
            }
        }
    }
}





