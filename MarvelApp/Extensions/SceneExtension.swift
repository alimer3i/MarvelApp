//
//  SceneExtension.swift
//  MarvelApp
//
//  Created by Ali Merhie on 10/28/19.
//  Copyright © 2019 Ali Merhie. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
extension UIResponder {
    @objc var scene: UIScene? {
        return nil
    }
}

@available(iOS 13.0, *)
extension UIScene {
    @objc override var scene: UIScene? {
        return self
    }
}

@available(iOS 13.0, *)
extension UIView {
    @objc override var scene: UIScene? {
        if let window = self.window {
            return window.windowScene
        } else {
            return self.next?.scene
        }
    }
}

@available(iOS 13.0, *)
extension UIViewController {
    @objc override var scene: UIScene? {
        // Try walking the responder chain
        var res = self.next?.scene
        if (res == nil) {
            // That didn't work. Try asking my parent view controller
            res = self.parent?.scene
        }
        if (res == nil) {
            // That didn't work. Try asking my presenting view controller
            res = self.presentingViewController?.scene
        }

        return res
    }
}
