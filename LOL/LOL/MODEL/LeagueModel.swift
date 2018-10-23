//
//  LeagueModel.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 20..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class LeaguePositionDTO : NSObject { // >> Return value: Set[LeaguePositionDTO]
    
    ////////////////////////////////////////
    //    LeaguePositionDTO
    //    NAME                DATA TYPE
    
    //    rank                string
    //    queueType           string
    //    hotStreak           boolean
    //    wins                int
    //    veteran             boolean
    //    losses              int
    //    freshBlood          boolean
    //    leagueId            string
    //    playerOrTeamName    string
    //    inactive            boolean
    //    playerOrTeamId      string
    //    leagueName          string
    //    tier                string
    //    leaguePoints        int
    
    public var rank:String
    public var queueType:String
    public var hotStreak:Bool
    public var wins:Int
    public var veteran:Bool
    public var losses:Int
    public var freshBlood:Bool
    public var leagueId:String
    public var playerOrTeamName:String
    public var inactive:Bool
    public var playerOrTeamId:String
    public var leagueName:String
    public var tier:String
    public var leaguePoints:Int
    
    public init(json: [String:Any]) {
        self.rank = json["rank"] as! String
        self.queueType = json["queueType"] as! String
        self.hotStreak = json["hotStreak"] as! Bool
        self.wins = json["wins"] as! Int
        self.veteran = json["veteran"] as! Bool
        self.losses = json["losses"] as! Int
        self.freshBlood = json["freshBlood"] as! Bool
        self.leagueId = json["leagueId"] as! String
        self.playerOrTeamName = json["playerOrTeamName"] as! String
        self.inactive = json["inactive"] as! Bool
        self.playerOrTeamId = json["playerOrTeamId"] as! String
        self.leagueName = json["leagueName"] as! String
        self.tier = json["tier"] as! String
        self.leaguePoints = json["leaguePoints"] as! Int
    }
    
    public init(rank: String, queueType: String, hotStreak: Bool, wins: Int, veteran: Bool, losses: Int, freshBlood: Bool, leagueId: String, playerOrTeamName: String, inactive: Bool, playerOrTeamId: String, leagueName: String, tier: String, leaguePoints: Int) {
        
        self.rank = rank
        self.queueType = queueType
        self.hotStreak = hotStreak
        self.wins = wins
        self.veteran = veteran
        self.losses = losses
        self.freshBlood = freshBlood
        self.leagueId = leagueId
        self.playerOrTeamName = playerOrTeamName
        self.inactive = inactive
        self.playerOrTeamId = playerOrTeamId
        self.leagueName = leagueName
        self.tier = tier
        self.leaguePoints = leaguePoints
    }
    
}
/*
 // 사용 안함.
class MiniSeriesDTO: NSObject {
    
    //////////////////////////////////////
    //    MiniSeriesDTO
    //    NAME        DATA TYPE
    
    //    wins        int
    //    losses      int
    //    target      int
    //    progress    string
    
    public var wins:Int
    public var losses:Int
    public var target:Int
    public var progress:String
    
    public init(json: [String:Any]) {
        self.wins = json["wins"] as! Int
        self.losses = json["losses"] as! Int
        self.target = json["target"] as! Int
        self.progress = json["progress"] as! String
    }
    
    public init(wins: Int, losses: Int, target: Int, progress: String) {
        self.wins = wins
        self.losses = losses
        self.target = target
        self.progress = progress
    }
    
}
*/


class LeagueModel: NSObject {
    
    public var items = [LeaguePositionDTO]()
    public var arrItems = [LeaguePositionDTO]()
    
    init?(json: [[String: Any]]) {
        //print(json)
        
        do {
            //var index:Int = 0
            for item in json {
                
                // league 데이터 serializing
                self.items = [LeaguePositionDTO(rank: item["rank"] as! String,
                                                queueType: item["queueType"] as! String,
                                                hotStreak: (item["hotStreak"] as! Bool),
                                                wins: item["wins"] as! Int,
                                                veteran: (item["veteran"] as! Bool),
                                                losses: item["losses"] as! Int,
                                                freshBlood: (item["freshBlood"] as! Bool),
                                                leagueId: item["leagueId"] as! String,
                                                playerOrTeamName: item["playerOrTeamName"] as! String,
                                                inactive: (item["inactive"] as! Bool),
                                                playerOrTeamId: item["playerOrTeamId"] as! String,
                                                leagueName: item["leagueName"] as! String,
                                                tier: item["tier"] as! String,
                                                leaguePoints: item["leaguePoints"] as! Int)]
            
                // dic 데이터 arr에 추가
                arrItems += self.items
            }
            
            
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
        
        
        
    }
    
}


/*
[
    {
        "queueType": "RANKED_FLEX_SR",
        "hotStreak": false,
        "wins": 10,
        "veteran": false,
        "losses": 10,
        "playerOrTeamId": "3175160",
        "leagueName": "Orianna's Destroyers",
        "playerOrTeamName": "콩이눈높이교육",
        "inactive": false,
        "rank": "III",
        "freshBlood": false,
        "leagueId": "76d35c20-2ceb-11e8-a4cc-f01fafdb3b9f",
        "tier": "BRONZE",
        "leaguePoints": 79
    },
    {
        "queueType": "RANKED_SOLO_5x5",
        "hotStreak": false,
        "wins": 588,
        "veteran": true,
        "losses": 593,
        "playerOrTeamId": "3175160",
        "leagueName": "Shen's Maulers",
        "playerOrTeamName": "콩이눈높이교육",
        "inactive": false,
        "rank": "IV",
        "freshBlood": false,
        "leagueId": "f5bc99e0-2c3f-11e8-9647-782bcb4d0dce",
        "tier": "SILVER",
        "leaguePoints": 0
    }
]
*/
