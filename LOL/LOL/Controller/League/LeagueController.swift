//
//  LeagueController.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 24..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

// viewcontroller에서 유저네임 검색 후 id 가져와서,
// leaguecontroller에서 id 값으로 조회된 league 데이터 table view로 보여줄 예정.
// ui 작업 및 바인딩 작업만 하면 됨. 간단 작업 ㄱㅅ


class LeagueController: UIViewController, CellDataDelegate {
    
    
    
    let lolApi = LOLApi()
    var leagueModel : LeagueModel?
    weak var delegate: CellDataDelegate?
    
    var userId:Int?
    public var info : SummonerModel? {
        didSet {
            userId = info?.items[0].id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (userId == nil || userId == 0) {
            print("UserID 값이 없습니다. 정상적인 값을 입력하세엽!")
            
            return
        } else {
            callLeagueBySummonerId(id: userId!)
        }
        
    }
    
    func searchedSummonerId(info: Int) {
        userId = info
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


// MARK: - Table view data source

extension LeagueController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        
        //cell.labelName.text = indexPath.row
        
        return cell
    }
    
    
}
