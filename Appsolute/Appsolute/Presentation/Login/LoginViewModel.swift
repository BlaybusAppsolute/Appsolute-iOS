//
//  LoginViewModel.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
import Foundation
import Moya

class LoginViewModel {
    
    // MARK: - Properties
    private let provider = MoyaProvider<UserAPI>()
    
    // MARK: - Methods
    func login(
        userId: String,
        password: String,
        onSuccess: @escaping (LoginResponse) -> Void,
        onFailure: @escaping (String) -> Void
    ) {
        print("🔍 [LoginViewModel] 로그인 요청 - ID: \(userId), Password: \(password)") // 디버깅 로그
        
        provider.request(.login(userId: userId, password: password)) { result in
            switch result {
            case .success(let response):
                print("✅ [LoginViewModel] 응답 수신 - 상태코드: \(response.statusCode)") // 응답 상태 코드 출력
                self.handleResponse(response, onSuccess: onSuccess, onFailure: onFailure)
            case .failure(let error):
                print("❌ [LoginViewModel] 네트워크 오류 발생: \(error.localizedDescription)") // 네트워크 오류 출력
                onFailure("네트워크 오류가 발생했습니다.")
            }
        }
    }
    
    private func handleResponse(
        _ response: Response,
        onSuccess: @escaping (LoginResponse) -> Void,
        onFailure: @escaping (String) -> Void
    ) {
        let decoder = JSONDecoder()
        
        print("🛠️ [LoginViewModel] 응답 데이터 디코딩 중...")
        print("📦 [LoginViewModel] 응답 원본 데이터: \(String(data: response.data, encoding: .utf8) ?? "데이터 없음")") // 원본 응답 데이터
        
        if (200..<300).contains(response.statusCode) {
            // 성공 처리
            if let decodedResponse = try? decoder.decode(LoginResponse.self, from: response.data) {
                print("✅ [LoginViewModel] 디코딩 성공 - JWT: \(decodedResponse.jwtToken), FirstLogin: \(decodedResponse.firstLogin)")
                onSuccess(decodedResponse)
            } else {
                print("❌ [LoginViewModel] 디코딩 실패 - 성공 상태 코드지만 데이터를 디코딩할 수 없습니다.")
                onFailure("응답 데이터를 처리할 수 없습니다.")
            }
        } else {
            // 실패 처리
            if let errorResponse = try? decoder.decode(LoginErrorResponse.self, from: response.data) {
                print("❌ [LoginViewModel] 디코딩 성공 (에러 응답) - 메시지: \(errorResponse.message), 상태: \(errorResponse.status)")
                onFailure(errorResponse.message)
            } else {
                print("❌ [LoginViewModel] 디코딩 실패 - 에러 상태 코드 및 데이터를 디코딩할 수 없습니다.")
                onFailure("알 수 없는 오류가 발생했습니다.")
            }
        }
    }
}
