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
        //let loginId:String = "dhtkdgh429"
        let apiKey = "RGAPI-3a4d111e-bd21-4d4f-a2f8-97d14f53eb1a"
        
        // URL 생성
        let url = "https://kr.api.riotgames.com\(string)?api_key=\(apiKey)"

        //return "\(url)\(string)"
        return url
    }
    
    static func ParseServiceResult(_ json: [String:AnyObject]?, error: Error?) -> WebServiceResult {
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
            parsedResult.items = [String:AnyObject]()
            
            
            //parsedResult.json = WebServiceResult().serialize(json: json as! String)
            
            // json data key 기준 sorting 수행.
            let sortedJSON = json!.sorted { $0.0 < $1.0 }
            
            for item in sortedJSON {
                
                parsedResult.appendKeyValue(key: item.key, value: item.value)
                
            }
            
            // json data >> string 변환
            parsedResult.json = parsedResult.jsonToString(json: (parsedResult.items as AnyObject) as! [String : AnyObject])
            
            
            if #available(iOS 10.0, *) {
                
                /*
                // 위에서 json과 items 한번에 처리하도록 수정. for문 때문에..
                // items 초기화
                parsedResult.items = [[String:AnyObject]]()
                
                let itemsArray:[String:AnyObject] = json!
                
                 dictionary형태의 json data를 key-value로 분리하여 반환.
                for item in itemsArray {

                    parsedResult.appendKeyValue(key: item.key, value: item.value)

                }
                */
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
                    
                    var parsedItems:[String:AnyObject] = [:]
                    if (object_getClass(item)!.description().range(of: "Dictionary") != nil) {
                        let dic = item as! NSDictionary
                        for key in dic.allKeys {
                            let skey = key as! String
                            let aval = dic.object(forKey: skey)
                            var value:AnyObject?
                            if (object_getClass(aval)!.description().range(of: "AnyObject") != nil) {
                                value = aval as AnyObject
                            }
                            parsedItems[skey] = value as AnyObject
                        }
                    }
                    
                    resultItems.append(parsedItems)
                    
                }
                
                for result in resultItems {
                    parsedResult.append(item: result as! [String : AnyObject])
                }
                
            }
            
            if (object_getClass(json)!.description().range(of: "Dictionary") != nil) {
                if let item = json as? [String:AnyObject] {
                    ///parsedResult.items.append(item)
                    parsedResult.errorMessage = item["ERR_MSG"] as? String
                    parsedResult.errorOccurred = item["ERR_YN"] as? String == "Y" ? true : false
                }
            }
            
            if (object_getClass(json)!.description().range(of: "SingleObjectArray") != nil) {
                if let items = json as? [[String:AnyObject]] {
                    ///parsedResult.items.append(item)
                    let item = items[0]
                    parsedResult.errorMessage = item["ERR_MSG"] as? String
                    parsedResult.errorOccurred = item["ERR_YN"] as? String == "Y" ? true : false
                }
            }
            
            if (object_getClass(json)!.description().range(of: "NSArray") != nil) { // NSCFArray
                if let items = json as? [[String:AnyObject]] {
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
    var errorOccurred = false
    var networkTimeOut = false
    var errorMessage: String!
    var json:String!
    var items = [String:AnyObject]()
    
    override init() {
        super.init()
        self.items = [String:AnyObject]()
        //self.items.reserveCapacity(2)
    }
    
    func append(item:[String:AnyObject]) {
        //self.items.append(item)
        //self.items.updateValue(, forKey: <#T##String#>)
    }
    
    // key-value에서 [String:AnyObject]로 appending하도록 변환.
    func appendKeyValue(key: String, value:AnyObject) {
        
        // items에 appending
        //self.items.append([key:value])
        self.items.updateValue(value, forKey: key)
        
        
    }
    
    
    // json string을 data로 변환하여 json object로 만든다...
    func serialize(json: String) -> [String : AnyObject] {
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
            if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject] {
                self.items = jsonObject
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        
        return self.items
    }
    
    // json object를 string으로 변환한다.
    func jsonToString(json: [String:AnyObject]) -> String {
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

