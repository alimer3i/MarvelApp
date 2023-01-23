//
//  BaseModel.swift
//  MarvelApp
//
//  Created by Ali Merhie on 9/21/21.
//

import Foundation

class BaseModel<Element: Codable>: Codable, Error {
    var code: Int = 0
    var status: String = ""
    var data: DataModel<Element>?
    
    init() {
        
    }
    
}

class DataModel<Element: Codable>: Codable, Error {
    var offset: Int = 0
    var limit: Int = 0
    var total: Int = 0
    var count: Int = 0
    var results: [Element] = []

    
    init() {
        
    }

}
