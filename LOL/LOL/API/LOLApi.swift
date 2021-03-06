//
//  LOLApi.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LOLApi : WebService {
    
    // default
    // 소환사 조회하는 서비스
    func getFindSummoner(name: String, onCompletion: @escaping WebServiceResponse) {
        
        // 인코딩 여부. 기본 값 true
        var isEncoded:Bool = true
        var url:String = ""
        
        // name 파라미터를 가져와서 URL 인코딩.
        guard let urlEncodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else
        {
            // 인코딩 실패 시, DEBUGING 및 isEncoded false로 변경
            isEncoded = false
            
            #if DEBUG
            print("Fail to URL Encoding")
            #endif
            return
        }
        // isEncoded 값이 true 이면, url 넣고 서비스 수행. 아니면 리턴.
        if (isEncoded == true) {
            url = WebService().getServiceUrl(string: "/lol/summoner/v3/summoners/by-name/\(urlEncodedName)")
        } else {
            #if DEBUG
            print("Fail to URL Insert")
            #endif
            return
        }
 
        
        APIManager.sharedManager.request(url).responseJSON { response in
            #if DEBUG
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            #endif
            switch (response.result) {
            case .success:
                let json = response.result.value
                #if DEBUG
                print("JSON: \(String(describing: json))")
                #endif
                let result = WebService.ParseServiceResult(json, error: nil)
                onCompletion(result)
            case .failure(let error):
                #if DEBUG
                print(error)
                #endif
                let result = WebService.ParseServiceResult(nil, error: error)
                onCompletion(result)
            }
        }
        /*
        // 요청 시 debug sample
        Request: Optional(https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/%EC%BD%A9%EC%9D%B4%EB%88%88%EB%86%92%EC%9D%B4%EA%B5%90%EC%9C%A1?api_key=RGAPI-3a4d111e-bd21-4d4f-a2f8-97d14f53eb1a)
        Response: Optional(<NSHTTPURLResponse: 0x600002b6caa0> { URL: https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/%EC%BD%A9%EC%9D%B4%EB%88%88%EB%86%92%EC%9D%B4%EA%B5%90%EC%9C%A1?api_key=RGAPI-3a4d111e-bd21-4d4f-a2f8-97d14f53eb1a } { Status Code: 200, Headers {
        Connection =     (
        "keep-alive"
        );
        "Content-Encoding" =     (
        gzip
        );
        "Content-Length" =     (
        148
        );
        "Content-Type" =     (
        "application/json;charset=utf-8"
        );
        Date =     (
        "Fri, 19 Oct 2018  09:43:59 GMT"
        );
        Vary =     (
        "Accept-Encoding"
        );
        "X-App-Rate-Limit" =     (
        "20:1,100:120"
        );
        "X-App-Rate-Limit-Count" =     (
        "1:1,2:120"
        );
        "X-Method-Rate-Limit" =     (
        "2000:60"
        );
        "X-Method-Rate-Limit-Count" =     (
        "2:60"
        );
        } })
        Result: SUCCESS
        */
    }
    
    func getLeagueBySummonerId(id: Int, onCompletion: @escaping WebServiceResponse) {
        
        // https://kr.api.riotgames.com/lol/league/v3/positions/by-summoner/3175160
        let url = WebService().getServiceUrl(string: "/lol/league/v3/positions/by-summoner/\(id)")
        
        APIManager.sharedManager.request(url).responseJSON { (response) in
            #if DEBUG
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            #endif
            switch (response.result) {
            case .success:
                let json = response.result.value
                #if DEBUG
                print("JSON: \(String(describing: json))")
                #endif
                let result = WebService.ParseServiceResult(json, error: nil)
                onCompletion(result)
            case .failure(let error):
                #if DEBUG
                print(error)
                #endif
                let result = WebService.ParseServiceResult(nil, error: error)
                onCompletion(result)
            }
        }
        
    }
    
    
}
