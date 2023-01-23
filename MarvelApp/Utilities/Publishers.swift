//
//  Publishers.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/22/23.
//

import Foundation
import Combine

public extension Publisher where Self.Failure == Never {
    func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, for object: Root) -> AnyCancellable {
        sink { [weak object] (value) in
            object?[keyPath: keyPath] = value
        }
    }
    func sink<Object: AnyObject>(_ object: Object, receiveValue: @escaping (Output, Object) -> Void) -> AnyCancellable {
        sink { [weak object] newValue in
            guard let object else {return}
            receiveValue(newValue, object)
        }
    }
}
