//
//  EvaluateViewModel.swift
//  Appsolute
//
//  Created by 권민재 on 1/16/25.
//


import Foundation
import Moya

class EvaluateViewModel {
    private let provider = MoyaProvider<EvaluateAPI>()
    
    // 성공 및 오류 콜백
    var onSuccess: ((Evaluate) -> Void)?
    var onError: ((String) -> Void)?
    
    /// 평가 데이터 가져오기
    func fetchEvaluation(year: Int, periodType: String) {
        provider.request(.getEvaluation(year: year, periodType: periodType)) { result in
            switch result {
            case .success(let response):
                print("✅ [DEBUG] 네트워크 요청 성공")
                print("📡 [DEBUG] 응답 코드: \(response.statusCode)")
                print("📡 [DEBUG] 응답 데이터: \(String(data: response.data, encoding: .utf8) ?? "데이터 없음")")
                
                if (200..<300).contains(response.statusCode) {
                    do {
                        // Evaluate 배열로 디코딩
                        let decodedResponse = try JSONDecoder().decode(Evaluate.self, from: response.data)
                        self.onSuccess?(decodedResponse)
                    } catch {
                        print("❌ [DEBUG] 디코딩 오류: \(error.localizedDescription)")
                        self.onError?("데이터 파싱 오류: \(error.localizedDescription)")
                    }
                } else {
                    print("❌ [DEBUG] 상태 코드 오류: \(response.statusCode)")
                    self.onError?("서버 오류: 상태 코드 \(response.statusCode)")
                }
                
            case .failure(let error):
                print("❌ [DEBUG] 네트워크 요청 실패: \(error.localizedDescription)")
                self.onError?("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
}
