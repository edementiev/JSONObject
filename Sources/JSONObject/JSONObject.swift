//
//  JSONObject.swift
//  gorbilet
//
//  Created by Евгений Дементьев on 23/05/2019.
//  Copyright © 2019 Gorbilet. All rights reserved.
//

import Foundation

public class JSONObject {

    private let errorLogging = false
    private var data = [String: Any]()

    public var rawData: [String: Any] {
        return self.data
    }

    public init() { }

    public init(json: [String: Any]) {
        self.data = json
    }

    public init(data: Data?) {
        if let data = data {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                self.data = json
            } else {
                print("JSONObject: Не могу декодировать JSON\n\(String(decoding: data, as: UTF8.self))")
            }
        } else {
            print("JSONObject: Не могу декодировать JSON\nnil")
        }
    }

    public func value<T>(key: String, defaultValue: T) -> T {
        if key.contains(".") {
            let keys = key.split(separator: ".")
            var currentData = self.data
            for index in (0...keys.count - 1) {
                let currentKey = String(keys[index])
                if index < (keys.count - 1) {
                    if let value = currentData[currentKey] as? [String: Any] {
                        currentData = value
                    } else {
                        if self.errorLogging { print("key not found: \(key)") }
                        return defaultValue
                    }
                } else {
                    return self.justValue(data: currentData, key: String(currentKey), defaultValue: defaultValue)
                }
            }
            return defaultValue
        } else {
            return self.justValue(data: self.data, key: key, defaultValue: defaultValue)
        }
    }

    public func object(key: String) -> JSONObject {
        let value = self.value(key: key, defaultValue: [String: Any]())
        return JSONObject(json: value)
    }

    public func exists(key: String) -> Bool {
        let value = self.data[key]
        guard !(value is NSNull) else { return false }
        return (value != nil)
    }

    public func isEmpty() -> Bool {
        return (self.data.count == 0)
    }

    //
    // MARK: Private
    //
    private func justValue<T>(data: [String: Any], key: String, defaultValue: T) -> T {
        if defaultValue is Int {
            if let intValue = data[key] as? Int {
                guard let value = intValue as? T else { return defaultValue }
                return value
            }
            guard let stringValue = data[key] as? String else { return defaultValue }
            guard let intValue = Int(stringValue) else { return defaultValue }
            guard let value = intValue as? T else { return defaultValue }
            return value
        } else {
            if let value = data[key] as? T { return value } else { return defaultValue }
        }
    }

}
