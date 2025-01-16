//
//  HomeViewModel.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//

import Foundation
import Moya

class HomeViewModel {

    private let provider = MoyaProvider<UserAPI>()
    
    func fetchUsers(token: String, onSuccess: @escaping (User) -> Void, onFailure: @escaping (String) -> Void) {
        provider.request(.users(token: token)) { result in
            switch result {
            case .success(let response):
                self.handleResponse(response, onSuccess: onSuccess, onFailure: onFailure)
            case .failure(let error):
                onFailure("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
  
    private func handleResponse(
        _ response: Response,
        onSuccess: @escaping (User) -> Void,
        onFailure: @escaping (String) -> Void
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // JSON 키 컨버팅
        
        if (200..<300).contains(response.statusCode) {
            do {
                let users = try decoder.decode(User.self, from: response.data)
                onSuccess(users)
            } catch {
                onFailure("데이터 파싱 실패: \(error.localizedDescription)")
            }
        } else {
            do {
                let errorResponse = try decoder.decode(LoginErrorResponse.self, from: response.data)
                onFailure(errorResponse.message)
            } catch {
                onFailure("알 수 없는 오류가 발생했습니다.")
            }
        }
    }
}

