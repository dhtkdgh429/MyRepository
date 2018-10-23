//
//  WebService.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WebService: NSObject {

    typealias WebServiceResponse = (WebServiceResult?) -> Void

    // alamofire 세션관리 API매니저 struct 생성
    struct APIManager {
        static let sharedManager: Alamofire.SessionManager = {
            let configuration = URLSessionConfiguration.default
            // retry 3
            configuration.timeoutIntervalForRequest = 3
            return Alamofire.SessionManager(configuration: configuration)
        }()
    }
    
    func getServiceUrl(string : String) -> String {
    
        // LOL API Login ID 및 Api Key
        let apiKey = "RGAPI-1cb7c6d0-79b4-48f9-9c01-9fbd8cc79712"
        
        // URL 생성
        let url = "https://kr.api.riotgames.com\(string)?api_key=\(apiKey)"

        return url
    }
    
    static func ParseServiceResult(_ json: Any?, error: Error?) -> WebServiceResult {
        let parsedResult = WebServiceResult()
        
        if (error != nil) {
            parsedResult.errorOccurred = true
            parsedResult.networkTimeOut =  true
            parsedResult.errorMessage = (error! as NSError).localizedDescription
        }
        else {
            if (json == nil) {
                return (parsedResult)
            }
            // items 초기화
            //parsedResult.items2 = [[String:Any]]()
            
            // any 자료형의 json data를 if로 각 형태에 따라 dictionary or array로 형변환 필요.
            
            /*
            if (object_getClass(json)!.description().range(of: "Dictionary") != nil) {
                let test = json as! [String:Any]
                let sortedJSON = test.sorted { $0.0 < $1.0 }

                for item in sortedJSON {

                    parsedResult.appendKeyValue(key: item.key, value: item.value)

                }
                // json data >> string 변환
                parsedResult.json = parsedResult.jsonToString(json: parsedResult.items as AnyObject)
            }
            
            if (object_getClass(json)!.description().range(of: "NSArray") != nil) { // NSCFArray
                let test = json as! [[String:Any]]
                var resultJSON = [[String:Any]]()
                
//                var index:Int = 0
                for item in test {
                    
                    let sortedJSON = item.sorted { $0.key < $1.key }
                    
                    for (key, value) in sortedJSON {
                        
                        parsedResult.appendKeyValue(key: key, value: value)
                        
                    }
                    
//                    parsedResult.items.sorted { $0.0 < $1.0 }
                    parsedResult.appendItems(items: parsedResult.items)
//                    index = 0
                }
                // json data >> string 변환
                parsedResult.json = parsedResult.jsonToString(json: parsedResult.items2 as AnyObject)
            }
            */
            
            //parsedResult.json = WebServiceResult().serialize(json: json as! String)
            // json data key 기준 sorting 수행.
            
            //let test = json as! [[String:Any]]
            
            
            //let test1 = test.map { $0.first?.key }
            
            
            //let tmpJSON = json as! [[String:Any]]
            //let sortedJSON = tmpJSON.sorted { $0.0 < $1.0 }
//            
//            for item in sortedJSON {
//
//                parsedResult.appendKeyValue(key: item.key, value: item.value)
//
//            }
            
            // json data >> string 변환
            //parsedResult.json = parsedResult.jsonToString(json: (parsedResult.items as AnyObject))
            parsedResult.json = parsedResult.jsonToString(json: json as AnyObject)
            
            if #available(iOS 10.0, *) {
                
                // json data가 array 형태일 때,
                // ex) LeaguePositionDTO api
                if (object_getClass(json)!.description().range(of: "Array") != nil) {
                
                    // 위에서 json과 items 한번에 처리하도록 수정. for문 때문에..
                    // items 초기화
                    parsedResult.items2 = [[String:Any]]()
                    
                    let items:[[String:Any]] = json as! [[String:Any]]
                    var itemsArray = [String:Any]()
                    
                    for item in items {
                        itemsArray = item
                        // dictionary형태의 json data를 key-value로 분리하여 반환.
                        for item in itemsArray {
                            
                            parsedResult.appendKeyValue(key: item.key, value: item.value)
                            
                        }
                        // dic 데이터 items2 arr로 추가하여 데이터 재구성
                        parsedResult.appendItems(items: parsedResult.items)
                    }
                }
                
                // json data가 dictionary 형태일 때,
                // ex) Summoner api
                if (object_getClass(json)!.description().range(of: "Dictionary") != nil) {
                    // 위에서 json과 items 한번에 처리하도록 수정. for문 때문에..
                    // items 초기화
                    parsedResult.items = [String:Any]()
                    
                    let items:[String:Any] = json as! [String:Any]
                    
                    // dictionary형태의 json data를 key-value로 분리하여 반환.
                    for (key,value) in items {
                        
                        parsedResult.appendKeyValue(key: key, value: value)
                        
                    }
                }
                
            }
            else {
                if(parsedResult.items.count > 0) {
                    parsedResult.items.removeAll()
                }
                let items:CFArray = (json as! CFArray?)!
                let itemsArray:Array = items as Array
                //var itemIndex:Int = 0
                
                var resultItems:[Any] = []
                for item in itemsArray {
                    
                    var parsedItems:[String:Any] = [:]
                    if (object_getClass(item)!.description().range(of: "Dictionary") != nil) {
                        let dic = item as! NSDictionary
                        for key in dic.allKeys {
                            let skey = key as! String
                            let aval = dic.object(forKey: skey)
                            var value:Any?
                            if (object_getClass(aval)!.description().range(of: "Any") != nil) {
                                value = aval as Any
                            }
                            parsedItems[skey] = value as Any
                        }
                    }
                    
                    resultItems.append(parsedItems)
                    
                }
                
//                for result in resultItems {
//                    parsedResult.append(item: result as! [String : Any])
//                }
                
            }
            
            // 404 등 status 에러코드 관련 처리. 임시.
            if (object_getClass(json)!.description().range(of: "Dictionary") != nil) {
                if let item = json as? [String:Any], item["status"] != nil {
                    if let dic: [String:Any] = item["status"] as! [String : Any] {
                    
                        parsedResult.errorMessage = dic["message"] as? String
                        parsedResult.errorStatusCode = dic["status_code"] as! Int
                    }
                }
            }
            
            if (object_getClass(json)!.description().range(of: "SingleObjectArray") != nil) {
                if let items = json as? [[String:Any]] {
                    ///parsedResult.items.append(item)
                    let item = items[0]
                    parsedResult.errorMessage = item["ERR_MSG"] as? String
                    parsedResult.errorOccurred = item["ERR_YN"] as? String == "Y" ? true : false
                }
            }
            
            if (object_getClass(json)!.description().range(of: "NSArray") != nil) { // NSCFArray
                if let items = json as? [[String:Any]] {
                    ///parsedResult.items.append(item)
                    let item = items[0]
                    if(item["Value"] as? String == "N") {
                        parsedResult.errorMessage = "Null data"
                        parsedResult.errorOccurred = true
                    }
                }
            }
        }
        
        
        return parsedResult
    }
    
    static func MakeArrayParam(_ params:[String]) ->String {
        var paramString:String = ""
        let count = params.count
        
        if(count > 0) {
            // start with "|"
            paramString.append("|")
            //
            // a,b,c
            for param in params {
                paramString.append(param)
                paramString.append("|")
            }
        }
        else {
            paramString = "||"
        }
        
        return paramString
        
    }
    
    static func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    if let name: String = String(cString: (interface?.ifa_name)!), name == "lo0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    static func getIFAddresses() -> [String] {
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }
        
        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            let addr = ptr.pointee.ifa_addr.pointee
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return addresses
    }
}

class WebServiceResult: NSObject {
    var errorStatusCode:Int?
    var errorOccurred = false
    var networkTimeOut = false
    var errorMessage: String!
    var json:String!
    var items = [String:Any]()
    var items2 = [[String:Any]]()
    
    override init() {
        super.init()
        self.items = [String:Any]()
        //self.items.reserveCapacity(2)
    }
    
    func appendItems(items:[String:Any]) {
        //self.items.append(item)
        //self.items.updateValue(, forKey: )
        
        self.items2.append(items)
    }
    
    // key-value에서 [String:Any]로 appending하도록 변환.
    func appendKeyValue(key: String, value:Any) {
        
        // items에 appending
        //self.items.append([key:value])
        self.items.updateValue(value, forKey: key)
        
    }
    
    // json string을 data로 변환하여 json object로 만든다...
    func serialize(json: String) -> [String : Any] {
        /*
         var jsonDescrypted:String = ""
         // 2018.10.04 OSH - json data 복호화
         jsonDescrypted = SecurityAES.init().decryptAES256(string: json as! String)
         let data = jsonDescrypted.data(using: .utf8)!
         */
        
        // json string을 data로 변환
        let data = json.data(using: .utf8)!
        
        do {
            // data를 json ojbect로 변환
            if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                self.items = jsonObject
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        
        return self.items
    }
    
    // json object를 string으로 변환한다.
    func jsonToString(json: AnyObject) -> String {
        var jsonString:String = ""
        /*
         var jsonEncrypted:String = ""
         let infoMaster = InfoMaster.init()
         let headers = WebService.makeHeader(infoMaster)
         var jsonParam:[String : String] = [String : String]()
         var params: [String: Any] = [String: Any]()
         //var paramsSorted: [String: Any] = [String: Any]()
         
         // 2018.10.04 OSH - 암호화를 위한 json 재조립
         jsonParam = json as! [String:String]
         jsonParam.removeValue(forKey: "uid")
         
         // query_param에 넣을 jsonParam 생성.
         for item in headers {
         jsonParam.append(item.value, key: item.key)
         }
         
         // 파라미터 [String: [String:String]] 구조로 조립
         params["meta"] = WebService.makeMetaParams(infoMaster)
         params["query_param"] = jsonParam
         
         // 2018.10.16 파라미터 구조 sorting
         let paramsSorted = params.sorted { $0.0 < $1.0 }
         */
        do {
            //let data =  try JSONSerialization.data(withJSONObject: paramsSorted, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let data =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            jsonString = String(data: data, encoding: String.Encoding.utf8)! // the data will be converted to the string
            
            // 2018.10.04 OSH - json String >> AES256 && base64 암호화
            //jsonEncrypted = SecurityAES().encryptAES256(string: jsonString)
            
            #if DEBUG
            print(jsonString)
            #endif
        } catch let myJSONError {
            #if DEBUG
            print(myJSONError)
            #endif
        }
        
        // 암호화 결과값 리턴
        //return jsonEncrypted
        
        return jsonString
    }
    
}

