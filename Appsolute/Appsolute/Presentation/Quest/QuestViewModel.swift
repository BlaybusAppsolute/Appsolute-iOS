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

    // 주간 퀘스트 데이터를 저장할 배열
    var weeklyQuests: [DepartmentQuestResponse] = [] {
        didSet {
            onWeeklyQuestsUpdated?() // 데이터 변경 시 클로저 호출
        }
    }
    var currentQuestDetail: DepartmentQuestDetailResponse? {
            didSet {
                onQuestDetailFetched?() // 디테일 데이터 변경 시 호출
            }
        }

    // 콜백
    var onWeeklyQuestsUpdated: (() -> Void)?
    var onQuestDetailFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    /// 7일 동안의 데이터를 가져오기
    func fetchWeeklyQuests(startDate: String) {
        print("🔍 [DEBUG] 7일 퀘스트 요청 시작: \(startDate)")
        
        var allResponses: [DepartmentQuestResponse] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let initialDate = formatter.date(from: startDate) else {
            onError?("❌ [DEBUG] 시작 날짜 변환 실패")
            return
        }

        let dispatchGroup = DispatchGroup()

        // 7일 데이터를 요청
        for i in 0..<7 {
            guard let currentDate = Calendar.current.date(byAdding: .day, value: i, to: initialDate) else { continue }
            let currentDateString = formatter.string(from: currentDate)
            
            dispatchGroup.enter()
            provider.request(.fetchDepartmentQuest(date: currentDateString)) { result in
                switch result {
                case .success(let response):
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let questResponse = try decoder.decode(DepartmentQuestResponse.self, from: response.data)
                            allResponses.append(questResponse)
                        } catch {
                            print("❌ [DEBUG] 디코딩 오류: \(error)")
                        }
                    } else {
                        print("❌ [DEBUG] 상태 코드 오류: \(response.statusCode)")
                    }
                case .failure(let error):
                    print("❌ [DEBUG] 요청 실패: \(error.localizedDescription)")
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("✅ [DEBUG] 모든 요청 완료, \(allResponses.count)개의 데이터 수신")
            self.weeklyQuests = allResponses // 배열 업데이트
        }
    }
    func fetchQuestDetail(questId: Int) {
        print("🔍 [DEBUG] 디테일 데이터 요청 시작 (questId: \(questId))")
        
        provider.request(.fetchDepartmentQuestDetail(departmentQuestId: questId)) { result in
            switch result {
            case .success(let response):
                print("✅ [DEBUG] 네트워크 요청 성공")
                print("📡 [DEBUG] 응답 코드: \(response.statusCode)")
                print("📡 [DEBUG] 응답 데이터: \(String(data: response.data, encoding: .utf8) ?? "데이터 없음")")
                
                if (200..<300).contains(response.statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let detailResponse = try decoder.decode(DepartmentQuestDetailResponse.self, from: response.data)
                        
                        print("✅ [DEBUG] 디코딩 성공: \(detailResponse)")
                        self.currentQuestDetail = detailResponse // 디테일 데이터 업데이트
                    } catch {
                        print("❌ [DEBUG] 디코딩 오류: \(error)")
                        self.onError?("디코딩 오류: \(error.localizedDescription)")
                    }
                } else {
                    print("❌ [DEBUG] 상태 코드 오류: \(response.statusCode)")
                    self.onError?("서버 오류: 상태 코드 \(response.statusCode)")
                }
                
            case .failure(let error):
                print("❌ [DEBUG] 요청 실패: \(error.localizedDescription)")
                self.onError?("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
}


struct DepartmentQuestDetailResponse: Decodable {
    struct Detail: Decodable {
        let departmentQuestDetailDate: String
        let revenue: Int
        let laborCost: Int
        let designServiceFee: Int
        let employeeSalary: Int
        let retirementBenefit: Int
        let socialInsuranceBenefit: Int
    }
    
    let detailList: [Detail]
    let gainedXP: Int
    let productivity: Int
    let questStatus: String
}
