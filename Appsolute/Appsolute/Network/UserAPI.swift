//
//  Untitled.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//

//http://3.39.101.254/

import Moya

enum UserAPI {
    case login(userId: String, password: String)
    case users(token: String)
    case password(token: String, password: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.39.101.254")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/users/login"
        case .users:
            return "/users"
        case .password:
            return "/users/password"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login,.password:
            return .post
        case .users:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .login(userId, password):
            let parameters = [
                "userId": userId,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .password(_, password):
            let parameters = [
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .users:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        case .users(let token), .password(let token, _):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
