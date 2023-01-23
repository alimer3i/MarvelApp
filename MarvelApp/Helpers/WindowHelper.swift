//
//  WindowHelper.swift
//  MarvelApp
//
//  Created by Ali Merhie on 10/30/19.
//  Copyright © 2019 Ali Merhie. All rights reserved.
//

import Foundation
import UIKit

final class WindowHelper {
    public var window: UIWindow
    static let shared = WindowHelper()
    
    private init() {
        window = AppDelegate.shared.window!
    }
}
