//
//  APIManager.swift
//  MarvelApp
//
//  Created by User on 22/07/2021.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()

    let sessionManager: Session = {
        
        let configuration = URLSessionConfiguration.af.default
        
        //Add these lines if needed but remove the requestCachePolicy line
        configuration.timeoutIntervalForRequest = 100
        configuration.waitsForConnectivity = true
        
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        
        let networkLogger = NetworkLogger()
        let interceptor = RequestInterceptor()
    
        
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            
            
            cachedResponseHandler: nil,
            eventMonitors: [networkLogger]
        )}()
}
