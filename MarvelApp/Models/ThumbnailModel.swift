//
//  ThumbnailModel.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation
import RealmSwift

class ThumbnailModel : Object, Codable {
    
    @Persisted var path: String?
    @Persisted var `extension`: String?

    func getImageURL() -> String{
        return "\(path ?? "").\(`extension` ?? "jpg")"
    }
}
