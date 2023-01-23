//
//  ErrorResponseModel.swift
//  MarvelApp
//
//  Created by Ali Merhie on 9/28/21.
//

import Foundation
import Alamofire

class ErrorResponseModel: Error, Codable {
    
    var code: String  = "Defualt Error"
    var message: String  = "Error"
    @NotCoded
    var error: AFError?

    init() {
        
    }

}
