//
//  ServiceLayer.swift
//  MarvelApp
//
//  Created by User on 22/07/2021.
//

import Foundation
import Alamofire

class ServiceLayer {
    
    class func request<T: Codable>(router: URLRequestBuilder, model: T.Type, completion: @escaping (Result<BaseModel<T>, ErrorResponseModel>) -> ()) {
        
        do{
            APIManager.shared.sessionManager.request(
                try router.asURLRequest()
            ).validate().response { (data) in
                ServiceLayer.handleResponseData(data: data, completion: completion)
                
            }
        }catch{
            print(error.localizedDescription)
            completion(.failure(ErrorResponseModel()))
        }
    }
    
    class func handleResponseData<T: Codable>(data: AFDataResponse<Data?>, completion: @escaping (Result<BaseModel<T>, ErrorResponseModel>) -> ()){
        let result = data.result
        var responseBody = BaseModel<T>()
        var responseErrorBody = ErrorResponseModel()
        let decoder = JSONDecoder()

            if let jsonObject = try? decoder.decode(BaseModel<T>.self, from: data.data ?? Data()) {
                responseBody = jsonObject

            }else if let jsonErrorObject = try? decoder.decode(ErrorResponseModel.self, from: data.data ?? Data()) {
                responseErrorBody = jsonErrorObject
            }
        
        switch result{
        case .success(_):
            completion(.success(responseBody))
            break
        case .failure(let error):
            print(error)
            completion(.failure(responseErrorBody))
            break
        }
    }
}

