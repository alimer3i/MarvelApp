//
//  Bundle.swift
//  MarvelApp
//
//  Created by Ali Merhie on 6/30/22.
//

import Foundation

extension Bundle {
    var displayName: String {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    }
}
