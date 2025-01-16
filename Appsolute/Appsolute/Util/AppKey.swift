//
//  AppKey.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//

struct AppKey {
    
    @UserDefault(key: "token", defaultValue: nil)
    static var token: String?
    
    @UserDefault(key: "profileImage", defaultValue: "프로필 사진-1")
    static var profileImage: String
}
