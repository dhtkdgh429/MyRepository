//
//  lolweb.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 18..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


/// A class responsible for the issuing of GET and POST requests to riotgames API endpoints
open class RiotRequest {
    
//    
//    /// Sets the region URL to the `Region` set in `Configuration`.
//    internal static let regionURL = Region.getHostname(forRegion: Configuration.region)
//    
//    
//    /**
//     Issues a GET request, using `RiotRequest`.
//     
//     - Parameters:
//     - isStatic: whether or not the request is destined for the static API endpoint
//     - url: the URL we want to send the request to
//     - handler: the Completion Handler to be executed upon success
//     */
//    public static func get(isStatic:Bool, forURL url: String, withCompletionHandler handler: @escaping (_ serverResponse: JSON) -> Void)
//    {
//        /// The base URL for use
//        var requestURL = "https://\(Configuration.proxyURL)/\(RiotRequest.regionURL)"
//        
//        //If static, swap in the static API hostname
//        if (isStatic)
//        {
//            requestURL = "https://\(Configuration.proxyURL)/\(Region.getHostname(forRegion: "GLOBAL"))"
//        }
//        requestURL += "\(url)"
//        
//        //Issue the request using `Alamofire`. Obtains a JSON response asynchronously
//        Alamofire.request(requestURL, method: .get, encoding: URLEncoding.default).responseJSON { responseBody in
//            if responseBody.result.value != nil {
//                //Set the server response, to be obtained by the calling class.
//                //There is a much better way of doing this.
//                let serverResponse = JSON(data: responseBody.data!)
//                handler(serverResponse)
//            }
//        }
//    }
    
}
