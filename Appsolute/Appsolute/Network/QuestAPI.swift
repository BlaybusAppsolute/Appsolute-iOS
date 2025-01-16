//
//  QuestAPI.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//

import Foundation
import Moya

enum QuestAPI {
    case fetchDepartmentQuest(date: String)
}

extension QuestAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.39.101.254")!
    }
    
    var path: String {
        switch self {
        case .fetchDepartmentQuest:
            return "/department-quest"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchDepartmentQuest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchDepartmentQuest(let date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        let token = AppKey.token ?? ""
        return [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
    }
    
    
}
