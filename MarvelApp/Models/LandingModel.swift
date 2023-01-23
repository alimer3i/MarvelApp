//
//  LandingModel.swift
//  MarvelApp
//
//  Created by Ali Merhie on 9/8/21.
//

import Foundation

class LandingModel: Codable {
    var title: String?
    var description: String?
    var image: String?

    init() {
        
    }
    init(title: String, description: String, image: String) {
        self.title = title
        self.description = description
        self.image = image

          
      }
}
