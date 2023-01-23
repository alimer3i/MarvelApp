//
//  EventModel.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation
import RealmSwift

class EventModel : Object, Codable, CollectionItemProtocol {
    
    var titleText: String {
        get{
            return title ?? "N/A"
        }
    }
    
    var imageUrl: String{
        get{
            return thumbnail?.getImageURL() ?? ""
        }
    }
    private enum CodingKeys: String, CodingKey {
        case id, title, thumbnail
    }
    
    @Persisted var characterID: Int = 0
    @Persisted var id: Int?
    @Persisted var title: String?
    @Persisted var thumbnail: ThumbnailModel?

}
