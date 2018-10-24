//
//  LeagueController.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 23..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

// viewcontroller에서 유저네임 검색 후 id 가져와서,
// leaguecontroller에서 id 값으로 조회된 league 데이터 table view로 보여줄 예정.
// ui 작업 및 바인딩 작업만 하면 됨. 간단 작업 ㄱㅅ


class LeagueController: UITableViewController {
    
    @IBOutlet weak var _tableView: LeagueTableViewCell!
    
    
    let lolApi = LOLApi()
    public var leagueModel : LeagueModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
