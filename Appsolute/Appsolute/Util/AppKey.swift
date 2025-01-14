//
//  AppKey.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//

struct AppKey {
    
    @UserDefault(key: "token", defaultValue: nil)
    static var token: String?
}
