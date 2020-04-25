//
//  Observable.swift
//  Teztez
//
//  Created by Adlet on 4/24/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

@propertyWrapper
final class Observable<Value> {
    var wrappedValue: Value? {
        didSet {
            valueDidChanged()
        }
    }

    var projectedValue: Observable<Value> {
        self
    }

    private var observations = [UUID: (Value?) -> Void]()

    init(wrappedValue: Value?) {
        self.wrappedValue = wrappedValue
    }

    private func valueDidChanged() {
        observations.values.forEach { closure in
            closure(wrappedValue)
        }
    }

    @discardableResult
    func observe<O: AnyObject>(_ observer: O, closure: @escaping (O, Value?) -> Void) -> ObservationToken {
        let id = UUID()
        observations[id] = { [weak self, weak observer] item in
            // If the observer has been deallocated, we can
            // automatically remove the observation closure.
            guard let observer = observer else {
                self?.removeObserver(for: id)
                return
            }

            closure(observer, item)
        }

        if let value = wrappedValue {
            closure(observer, value)
        }

        return ObservationToken { [weak self] in
            self?.removeObserver(for: id)
        }
    }

    private func removeObserver(for id: UUID) {
        observations.removeValue(forKey: id)
    }
}

final class ObservationToken {
    private let cancellationClosure: () -> Void

    init(cancellationClosure: @escaping () -> Void) {
        self.cancellationClosure = cancellationClosure
    }

    func cancel() {
        cancellationClosure()
    }
}

private extension Dictionary where Key == UUID {
    mutating func insert(_ value: Value) -> UUID {
        let id = UUID()
        self[id] = value
        return id
    }
}
