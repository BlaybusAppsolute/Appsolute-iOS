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
    case fetchDepartmentQuestDetail(departmentQuestId: Int)
    case fetchLeaderQuest
    case fetchLeaderBoard(userId: String, month: Int)
}

extension QuestAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.39.101.254")!
    }
    
    var path: String {
        switch self {
        case .fetchDepartmentQuest:
            return "/department-quest"
        case .fetchDepartmentQuestDetail(let departmentQuestId):
            return "/department-quest/\(departmentQuestId)"
        case .fetchLeaderQuest:
            return "/leader-quest"
        case .fetchLeaderBoard:
            return "/le-Leader-board"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchDepartmentQuest, .fetchDepartmentQuestDetail, .fetchLeaderQuest, .fetchLeaderBoard:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchDepartmentQuest(let date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        case .fetchDepartmentQuestDetail:
            return .requestPlain
        case .fetchLeaderQuest:
            return .requestPlain
        case .fetchLeaderBoard(let userId, let month):
            return .requestParameters(parameters: ["userId": userId, "month": month], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .fetchLeaderQuest:
            return nil // `/leader-quest`는 헤더 필요 없음
        default:
            let token = AppKey.token ?? ""
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json"
            ]
        }
    }
}
