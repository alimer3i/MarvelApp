//
//  CharacterSectionsEnum.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation

enum CharacterSectionsEnum: CaseIterable, Hashable {
    case Comics
    case Events
    case Stories
    case Series
    
    var getTitle: String {
        get{
            switch self {
            case .Comics:
                return "Comics"
            case .Events:
                return "Events"
            case .Stories:
                return "Stories"
            case .Series:
                return "Series"
            }
        }
    }

}
