//
//  JSONObject.swift
//  gorbilet
//
//  Created by Евгений Дементьев on 23/05/2019.
//  Copyright © 2019 Gorbilet. All rights reserved.
//

import Foundation

public typealias JSONRAW = [String: any Sendable]

public struct JSONObject: Sendable {
    private var dict = JSONRAW()
    private var ready = false

    public let errorLogging = false

    public var rawData: JSONRAW {
        return self.dict
    }
    
    public var isInitialized: Bool {
        return self.ready
    }

    public init() {
        self.ready = true
    }

    public init(dict: JSONRAW) {
        self.dict = dict
        self.ready = true
    }

    public init(data: Data?) {
        if let data = data {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONRAW {
                self.dict = json
                self.ready = true
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
            var currentDict = self.dict
            for index in (0...keys.count - 1) {
                let currentKey = String(keys[index])
                if index < (keys.count - 1) {
                    if let value = currentDict[currentKey] as? JSONRAW {
                        currentDict = value
                    } else {
                        if self.errorLogging { print("key not found: \(key)") }
                        return defaultValue
                    }
                } else {
                    return self.justValue(dict: currentDict, key: String(currentKey), defaultValue: defaultValue)
                }
            }
            return defaultValue
        } else {
            return self.justValue(dict: self.dict, key: key, defaultValue: defaultValue)
        }
    }

    public func exists(key: String) -> Bool {
        let value = self.dict[key]
        guard !(value is NSNull) else { return false }
        return (value != nil)
    }

    public func isEmpty() -> Bool {
        return (self.dict.count == 0)
    }

    public func object(key: String) -> JSONObject {
        let value = self.value(key: key, defaultValue: [String: any Sendable]())
        return JSONObject(dict: value)
    }
    
    public func array(key: String) -> [JSONObject] {
        let array = self.value(key: key, defaultValue: [JSONRAW]())
        var objects = [JSONObject]()
        for item in array {
            objects.append(JSONObject(dict: item))
        }
        return objects
    }

    //
    // MARK: Private
    //
    private func justValue<T>(dict: JSONRAW, key: String, defaultValue: T) -> T {
        // Int
        if defaultValue is Int {
            if let intValue = dict[key] as? Int {
                guard let value = intValue as? T else { return defaultValue }
                return value
            }
            if let doubleValue = dict[key] as? Double {
                guard let value = Int(doubleValue) as? T else { return defaultValue }
                return value
            }
            
            guard let stringValue = dict[key] as? String else { return defaultValue }
            
            if let intValue = Int(stringValue) {
                guard let value = intValue as? T else { return defaultValue }
                return value
            }

            if let doubleValue = Double(stringValue) {
                guard let value = Int(doubleValue) as? T else { return defaultValue }
                return value
            }

            return defaultValue
        // Double
        } else if defaultValue is Double {
            if let doubleValue = dict[key] as? Double {
                guard let value = doubleValue as? T else { return defaultValue }
                return value
            }
            if let intValue = dict[key] as? Int {
                guard let value = Double(intValue) as? T else { return defaultValue }
                return value
            }
            guard let stringValue = dict[key] as? String else { return defaultValue }
            guard let doubleValue = Double(stringValue) else { return defaultValue }
            guard let value = doubleValue as? T else { return defaultValue }
            return value
        // String
        } else if defaultValue is String {
            if let strValue = dict[key] as? String {
                guard let value = strValue as? T else { return defaultValue }
                return value
            }
            guard let intValue = dict[key] as? Int else { return defaultValue }
            let strValue = "\(intValue)"
            guard let value = strValue as? T else { return defaultValue }
            return value
        // Other
        } else {
            if let value = dict[key] as? T { return value } else { return defaultValue }
        }
    }

}
