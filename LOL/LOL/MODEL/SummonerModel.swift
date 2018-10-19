//
//  SummonerModel.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class Summoner: NSObject {
    
    /////////////////////////
    //profileIconId    int    ID of the summoner icon associated with the summoner.
    //name             string    Summoner name.
    //summonerLevel    long    Summoner level associated with the summoner.
    //revisionDate     long    Date summoner was last modified specified as epoch milliseconds. The following events will update this timestamp: profile icon change, playing the tutorial or advanced tutorial, finishing a game, summoner name change
    //id               long    Summoner ID.
    //accountId        long    Account ID.
    
    // 계정 ID.
    public var accountId:Int
    // 소환사 ID.
    public var id:Int
    // 소환사 이름
    public var name:String
    // 소환 자와 관련된 소환 아이콘의 ID.
    public var profileIconId:Int
    // 날짜 소환자가 마지막으로 수정 된 시간은 에포크 밀리 초입니다. 다음 이벤트는이 타임 스탬프를 업데이트합니다 : 프로필 아이콘 변경, 자습서 또는 고급 자습서 재생, 게임 마무리, 소집 자 이름 변경
    public var revisionDate:Int
    // 소환사와 관련된 소더 레벨.
    public var summonerLevel:Int
    
    public init(json: [String: AnyObject]) {
        self.accountId         = json["accountId"] as! Int
        self.id                = json["id"] as! Int
        self.name              = (json["name"] as! String)
        self.profileIconId     = json["profileIconId"] as! Int
        self.revisionDate      = json["revisionDate"] as! Int
        self.summonerLevel     = json["summonerLevel"] as! Int
        
    }
    
}

class SummonerModel: NSObject {
    
    public var items = [Summoner]()
//    init?(data: Data) {
//        do {
//            if let json = try JSONSerialization.jsonObject(with: data) as? [[String: AnyObject]] {
//                
//                self.items = json.map { Summoner(json: $0) }
//                
//            }
//        } catch {
//            print("Error deserializing JSON: \(error)")
//            return nil
//        }
//    }
    
    init?(json: [[String: AnyObject]]) {
        //print(json)
        
        self.items = json.map { Summoner(json: $0) }
        
    }
    
}

/* json data sample
 
{
    "profileIconId": 3378,
    "name": "콩이눈높이교육",
    "summonerLevel": 148,
    "accountId": 520979,
    "id": 3175160,
    "revisionDate": 1539823028000
}
 
*/

//
//extension Dictionary where Key == Date, Value == Array<Summoner> {
//
//    mutating func append(_ list:Summoner, key:Date) {
//
//        if var value = self[key] {
//            // if an array exist, append to it
//            value.append(list)
//            self[key] = value
//
//        } else {
//            // create a new array since there is nothing here
//            self[key] = [list]
//        }
//    }
//}
//
//extension Dictionary where Key == String, Value == Array<Summoner> {
//
//    mutating func append(_ list:Summoner, key:String) {
//
//        if var value = self[key] {
//            // if an array exist, append to it
//            value.append(list)
//            self[key] = value
//
//        } else {
//            // create a new array since there is nothing here
//            self[key] = [list]
//        }
//    }
//}
