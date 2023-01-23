//
//  KeyboardHelper.swift
//  MarvelApp
//
//  Created by Ali Merhie on 11/24/20.
//  Copyright © 2020 Ali Merhie. All rights reserved.
//

import Foundation
import UIKit

class KeyboardHelper {
    public static func dismiss() {
        UIApplication.shared.sendAction("resignFirstResponder", to:nil, from:nil, for:nil)
    }

}
