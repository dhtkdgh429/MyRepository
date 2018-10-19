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
            url = WebService.init().getServiceUrl(string: "/lol/summoner/v3/summoners/by-name/\(urlEncodedName)")
        } else {
            #if DEBUG
            print("Fail to URL Insert")
            #endif
            return
        }
 
        
        //let url = WebService.init().getServiceUrl(string: "/lol/summoner/v3/summoners/by-name/\(name)")
        
        APIManager.sharedManager.request(url, encoding:JSONEncoding.default).responseJSON { (response) in
            #if DEBUG
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            #endif
            switch (response.result) {
            case .success:
                let json = response.result.value as AnyObject
                #if DEBUG
                print("JSON: \(String(describing: json))")
                #endif
                let result = WebService.ParseServiceResult(json as! [String : AnyObject], error: nil)
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
