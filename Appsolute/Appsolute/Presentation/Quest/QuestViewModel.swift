//
//  QuestViewModel.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//

import Foundation
import Moya

class QuestViewModel {
    private let provider = MoyaProvider<QuestAPI>()
    
    // 성공 및 오류 콜백
    var onSuccess: ((DepartmentQuestResponse) -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchDepartmentQuest(date: String) {
        print("🔍 [DEBUG] 요청 시작: fetchDepartmentQuest(date: \(date))") // 요청 시작 로그
        
        provider.request(.fetchDepartmentQuest(date: date)) { result in
            switch result {
            case .success(let response):
                print("✅ [DEBUG] 네트워크 요청 성공")
                print("📡 [DEBUG] 응답 코드: \(response.statusCode)")
                print("📡 [DEBUG] 응답 데이터: \(String(data: response.data, encoding: .utf8) ?? "데이터 없음")")
                
                // HTTP 상태 코드 확인
                if (200..<300).contains(response.statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let questResponse = try decoder.decode(DepartmentQuestResponse.self, from: response.data)
                        
                        print("✅ [DEBUG] 디코딩 성공: \(questResponse)")
                        
                        // 성공 콜백 호출
                        self.onSuccess?(questResponse)
                    } catch {
                        print("❌ [DEBUG] 디코딩 오류: \(error.localizedDescription)")
                        self.onError?("데이터 파싱 오류: \(error.localizedDescription)")
                    }
                } else {
                    print("❌ [DEBUG] 비정상 상태 코드: \(response.statusCode)")
                    self.onError?("서버 오류: 상태 코드 \(response.statusCode)")
                }
                
            case .failure(let error):
                print("❌ [DEBUG] 네트워크 요청 실패: \(error.localizedDescription)")
                self.onError?("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
}
