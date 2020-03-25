//
//  MyUserDefaults.swift
//  TestEncoding
//
//  Created by Paul Pearson on 3/25/20.
//  Copyright © 2020 RPM Consulting. All rights reserved.
//

import Foundation


class MyUserDefautls {

    static private var userDefaults = UserDefaults.standard
    
    static func saveSetting<T: Encodable>(value: T, key: String) {
        if let data = try? PropertyListEncoder().encode(value) {
            print("saving data: \(data)")
            userDefaults.set(data, forKey: key)
            userDefaults.synchronize()
        }
    }

    static func loadSetting<T: Decodable>(key: String) -> T? {
        if let data = userDefaults.value(forKey: key) as? Data,
        let value = try? PropertyListDecoder().decode(T.self, from: data) {
            return value
        }
        return nil
    }
    
}
