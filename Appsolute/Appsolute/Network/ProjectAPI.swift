//
//  ProjectAPI.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//
import Moya

enum ProjectAPI {
    case fetchProjects(userId: String) // 특정 userId로 프로젝트 정보 가져오기
}

extension ProjectAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.39.101.254")! // API의 베이스 URL
    }
    
    var path: String {
        switch self {
        case .fetchProjects(let userId):
            return "/project/user/\(userId)" // 경로에 userId 포함
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchProjects:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchProjects:
            return .requestPlain // GET 요청, 추가 파라미터 없음
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"] // 필요 시 Authorization 헤더 추가
    }
    
    var validationType: ValidationType {
        return .successCodes // 성공 응답으로 200-299 허용
    }
}
