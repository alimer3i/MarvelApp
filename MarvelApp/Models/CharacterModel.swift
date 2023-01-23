//
//  CharacterModel.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation

class CharacterModel :Codable {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: ThumbnailModel?
  
    init(){
        
    }
}

