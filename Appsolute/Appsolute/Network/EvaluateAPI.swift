//
//  Evaluate.swift
//  Appsolute
//
//  Created by 권민재 on 1/16/25.
//

import Foundation
import Moya

enum EvaluateAPI {
    case getEvaluation(year: Int, periodType: String)
}

// MARK: - Moya TargetType Extension
extension EvaluateAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.39.101.254")! // API 서버 URL
    }

    var path: String {
        switch self {
        case .getEvaluation:
            return "/evaluation"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getEvaluation:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getEvaluation(let year, let periodType):
            // 쿼리 파라미터 설정
            return .requestParameters(
                parameters: [
                    "year": year,
                    "periodType": periodType
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        let token = AppKey.token ?? "" // 토큰을 AppKey에서 가져오기
        return [
            "Authorization": "Bearer \(token)", // 인증 헤더 추가
            "Accept": "*/*",
            "Content-Type": "application/json"
        ]
    }
}
import Foundation

struct Evaluate: Decodable {
    let gradeName: String
    let xp: Int
}
