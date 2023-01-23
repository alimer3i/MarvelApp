//
//  CollectionItemProtocol.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation

protocol CollectionItemProtocol {
    var titleText: String {get}
    var imageUrl: String {get}
    var characterID: Int {get set}

}
