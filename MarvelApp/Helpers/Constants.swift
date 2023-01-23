//
//  Constants.swift
//  MarvelApp
//
//  Created by Ali Merhie on 9/27/21.
//

import Foundation

enum Environment: String {
    static var config: Environment {
    #if DEBUG_MODE
        return Environment.debug
    #else
        return Environment.release
    #endif
    }
    case release = "Release"
    case debug = "Debug"

    static var url: String {
        switch Environment.config {
            case .release:
                return "http://gateway.marvel.com"
            case .debug:
                return "http://gateway.marvel.com"
        }
    }
}
