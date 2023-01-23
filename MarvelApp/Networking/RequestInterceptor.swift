//
//  RequestInterceptor.swift
//  MarvelApp
//
//  Created by User on 22/07/2021.
//

import Foundation
import Alamofire
import UIKit
import CryptoSwift

class RequestInterceptor: Alamofire.RequestInterceptor {
    
    private var isRefreshing = false
    let retryLimit = 5
    let failedRetryLimit = 2
    let retryDelay: TimeInterval = 1
    private var requestsToRetry: [((RetryResult) -> Void)] = []
    private let lock = NSLock()
    
    func adapt( _ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString{
            
//            if urlString.contains(Environment.url){
            let timestamp = "\(Date().timeIntervalSince1970)"
            let hash = "\(timestamp)\(NetworkConfigEnum.privateKey.rawValue)\(NetworkConfigEnum.publicKey.rawValue)".md5()
            urlRequest.url?.appendQueryParameters(["ts" : timestamp])
            urlRequest.url?.appendQueryParameters(["apikey" : NetworkConfigEnum.publicKey.rawValue])
            urlRequest.url?.appendQueryParameters(["hash" : hash])
//        }
    }
        print(urlRequest)
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        if let response = request.task?.response as? HTTPURLResponse{
            let statusCode = response.statusCode
            
            lock.lock() ; defer { lock.unlock() }            
            print("error: \(error)")
            print(request.retryCount)
            
            switch statusCode {
            case 500...599:
                
                if request.retryCount < failedRetryLimit {
                    completion(.retryWithDelay(retryDelay))
                }else{
//                    self.handleErrorResponseResponse(request: request)
                    completion(.doNotRetry)
                }
                break
            default:
//                self.handleErrorResponseResponse(request: request)
                completion(.doNotRetry)
                break
            }
            
        }else{
            completion(.doNotRetry)
        }
    }
    
//    private func handleErrorResponseResponse(request:Request){
//
//        if let response = request.task?.response as? HTTPURLResponse {
//            let fullURL = response.url?.absoluteString ?? ""
//            guard let data = (request as? DataRequest)?.data else{
//                DispatchQueue.main.async {
//                    UIApplication.getTopViewController()?.showAlert(title: "Oops! Something went wrong!", message: "The application has encountered an unknown error,but our technical staff have been automatically notified and will be looking into this with the utmost urgency.", completion: nil)
//                }
//                print("failed to read response data")
//                return
//            }
//
//            if fullURL.contains(AccountAPI.refreshToken.baseURL.absoluteString) {
//                do {
//                    var errorBlock = BaseModel<UserModel>()
//
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                        errorBlock = Mapper<BaseModel<UserModel>>().map(JSON: json)!
//                    }else{
//                        print("error serializing api body response")
//                        return
//                    }
//
//                    self.discardShowingAlertForSomeAPI(fullURL: fullURL, responseCode: errorBlock.responseCode) { (shouldSkip) in
//
//                        if shouldSkip {
//                            print("Api error alert skipped")
//                            return
//                        }
//
//                        DispatchQueue.main.async {
//                            UIApplication.getTopViewController()?.showAlert(title: errorBlock.titleMessage , message: (errorBlock.message ?? "Unkown Error"), buttonTitles: ["OK"], completion: { (int) in })
//                        }
//                    }
//                } catch let error as NSError {
//                    print("Failed to load: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//
//    func discardShowingAlertForSomeAPI(fullURL:String, responseCode: Int = 0, completion:((Bool)->())){
//        switch fullURL {
//        case let str where str.lowercased().contains(AccountAPI.login(phoneCode: "", phoneNumber: "", password: "", grecaptchaResponse: "").path) && responseCode == ResponseCodesEnum.accountNotVerified.rawValue:
//            completion(true)
//            break
//        default:
//            completion(false)
//            break
//        }
//    }
}

