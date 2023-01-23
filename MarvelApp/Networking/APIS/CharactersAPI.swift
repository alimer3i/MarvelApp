//
//  CharactersAPI.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation
import Alamofire

enum CharactersAPI:URLRequestBuilder {
    
    case allCharacters(page: Int, limit: Int)
    case comics(characterID: Int)
    case events(characterID: Int)
    case stories(characterID: Int)
    case series(characterID: Int)

    
    var path: String{
        switch self {
        case .allCharacters:
            return "/v1/public/characters"
        case .comics(let characterID):
            return "/v1/public/characters/\(characterID)/comics"
        case .events(let characterID):
            return "/v1/public/characters/\(characterID)/events"
        case .stories(let characterID):
            return "/v1/public/characters/\(characterID)/stories"
        case .series(let characterID):
            return "/v1/public/characters/\(characterID)/series"
        }
    }
    

    var parameters: Parameters?{
        switch self {
        case .allCharacters(let page, let limit):
            return [
                "limit" : limit,
                "offset" :page
            ]
        case .comics:
            return [
                "limit" : 3,
                "offset" :0,
                "orderBy" : "focDate"

            ]
        case .events:
            return [
                "limit" : 3,
                "offset" :0,
                "orderBy" : "startDate"

            ]
        case .stories:
            return [
                "limit" : 3,
                "offset" :0,
                "orderBy" : "modified"

            ]
        case .series:
            return [
                "limit" : 3,
                "offset" :0,
                "orderBy" : "startYear"

            ]
        }
    }
    
    var method: HTTPMethod{
        switch  self {
        case .allCharacters, .comics, .events, .stories, .series:
            return HTTPMethod.get
        
        }
    }
}
