//
//  User.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//

import Moya

enum BoardAPI {
    case getBoards // 게시판 조회
}

extension BoardAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.39.101.254")!
    }
    
    var path: String {
        switch self {
        case .getBoards:
            return "/board"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBoards:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getBoards:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

}
