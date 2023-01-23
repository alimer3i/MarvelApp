//
//  SubjectPropertyWrapper.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/22/23.
//

import Combine

@propertyWrapper
public struct Subject<T> {
//MARK: - Properties
    private let passthrough = PassthroughSubject<T?, Never>()
    private let currentValue = CurrentValueSubject<T?, Never>(nil)
    private var current = false
//MARK: - Initializers
    public init() {
    }
    public init(wrappedValue: T?) {
        current = true
        self.currentValue.value = wrappedValue
    }
//MARK: - Wrapper
    public var wrappedValue: T? {
        get {
            if current {
                return currentValue.value
            }else {
                return nil
            }
        }
        nonmutating set {
            if current {
                currentValue.value = newValue
            }else {
                passthrough.send(newValue)
            }
        }
    }
    public var projectedValue: AnyPublisher<T, Never> {
        get {
            if current {
                return currentValue
                    .compactMap({$0})
                    .eraseToAnyPublisher()
            }else {
                return passthrough
                    .compactMap({$0})
                    .eraseToAnyPublisher()
            }
        }
    }
}

@propertyWrapper
public struct Action {
//MARK: - Properties
    var action: () -> Void {
        return {
            passthrough.send(true)
        }
    }
    private let passthrough = PassthroughSubject<Bool, Never>()
//MARK: - Initializers
    public init() {
    }
//MARK: - Wrapper
    public var wrappedValue: () -> Void {
        get {
            return action
        }
        nonmutating set {
        }
    }
    public var projectedValue: AnyPublisher<Bool, Never> {
        return passthrough
            .eraseToAnyPublisher()
    }
}

@propertyWrapper
public struct SubjectAction<T> {
    //MARK: - Properties
    var action: (T) -> Void {
        return { value in
            passthrough.send(value)
        }
    }
    private let passthrough = PassthroughSubject<T, Never>()
    //MARK: - Initializers
    public init() {
    }
    //MARK: - Wrapper
    public var wrappedValue: (T) -> Void {
        get {
            return action
        }
        nonmutating set {
        }
    }
    public var projectedValue: AnyPublisher<T, Never> {
        return passthrough
            .eraseToAnyPublisher()
    }
}
