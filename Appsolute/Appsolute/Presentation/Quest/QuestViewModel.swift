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
    
    // 리더 퀘스트 데이터
    var leaderQuests: [LeaderQuest] = [] {
        didSet {
            onLeaderQuestsFetched?() // 데이터 변경 시 호출
        }
    }

    // 리더보드 데이터 (배열로 변경)
    var leaderBoardResponses: [LeaderBoardResponse] = [] {
        didSet {
            onLeaderBoardFetched?() // 데이터 변경 시 호출
        }
    }

    // 주간 퀘스트 데이터
    var weeklyQuests: [DepartmentQuestResponse] = [] {
        didSet {
            onWeeklyQuestsUpdated?() // 데이터 변경 시 호출
        }
    }

    var currentQuestDetail: DepartmentQuestDetailResponse? {
        didSet {
            if let detail = currentQuestDetail {
                onQuestDetailFetched?(detail) // 디테일 데이터 변경 시 호출
            }
        }
    }

    // 콜백
    var onLeaderQuestsFetched: (() -> Void)?
    var onLeaderBoardFetched: (() -> Void)?
    var onWeeklyQuestsUpdated: (() -> Void)?
    var onQuestDetailFetched: ((DepartmentQuestDetailResponse) -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - 주간 퀘스트 데이터 가져오기
    func fetchWeeklyQuests(startDate: String) {
        print("🔍 [DEBUG] 7일 퀘스트 요청 시작: \(startDate)")

        var allResponses: [DepartmentQuestResponse] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        // 시작 날짜를 Date로 변환
        guard let initialDate = formatter.date(from: startDate) else {
            onError?("❌ [DEBUG] 시작 날짜 변환 실패")
            return
        }

        let dispatchGroup = DispatchGroup()

        // 7일 데이터를 요청
        for i in 0..<7 {
            guard let currentDate = Calendar.current.date(byAdding: .day, value: i, to: initialDate) else {
                print("❌ [DEBUG] 날짜 계산 실패 (i: \(i))")
                continue
            }
            let currentDateString = formatter.string(from: currentDate)
            print("📅 [DEBUG] 요청할 날짜: \(currentDateString)")

            dispatchGroup.enter()
            provider.request(.fetchDepartmentQuest(date: currentDateString)) { result in
                switch result {
                case .success(let response):
                    print("✅ [DEBUG] \(currentDateString) 요청 성공 (상태 코드: \(response.statusCode))")
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let questResponse = try decoder.decode(DepartmentQuestResponse.self, from: response.data)
                            allResponses.append(questResponse)
                            print("✅ [DEBUG] \(currentDateString) 디코딩 성공: \(questResponse)")
                        } catch {
                            print("❌ [DEBUG] \(currentDateString) 디코딩 오류: \(error.localizedDescription)")
                        }
                    } else {
                        print("❌ [DEBUG] \(currentDateString) 상태 코드 오류: \(response.statusCode)")
                    }
                case .failure(let error):
                    print("❌ [DEBUG] \(currentDateString) 요청 실패: \(error.localizedDescription)")
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("✅ [DEBUG] 모든 요청 완료. 수신된 데이터 개수: \(allResponses.count)")
            self.weeklyQuests = allResponses // 배열 업데이트
            allResponses.forEach { quest in
                print("📦 [DEBUG] 수신된 데이터: \(quest)")
            }
        }
    }


    func fetchQuestDetail(questId: Int) {
        print("🔍 [DEBUG] 디테일 데이터 요청 시작 (questId: \(questId))")
        
        provider.request(.fetchDepartmentQuestDetail(departmentQuestId: questId)) { result in
            switch result {
            case .success(let response):
                print("✅ [DEBUG] 네트워크 요청 성공")
                print("📡 [DEBUG] 응답 데이터: \(String(data: response.data, encoding: .utf8) ?? "데이터 없음")")
                
                if (200..<300).contains(response.statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let detailResponse = try decoder.decode(DepartmentQuestDetailResponse.self, from: response.data)
                        self.currentQuestDetail = detailResponse
                        self.onQuestDetailFetched?(detailResponse) // 데이터 전달
                    } catch {
                        print("❌ [DEBUG] 디코딩 오류: \(error.localizedDescription)")
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


    // MARK: - 리더보드 데이터 가져오기
    func fetchLeaderBoard(userId: String, month: Int) {
        print("🔍 [DEBUG] 리더보드 요청 시작 (userId: \(userId), month: \(month))")
        
        provider.request(.fetchLeaderBoard(userId: userId, month: month)) { result in
            switch result {
            case .success(let response):
                print("✅ [DEBUG] 리더보드 네트워크 요청 성공")
                print("📡 [DEBUG] 응답 데이터: \(String(data: response.data, encoding: .utf8) ?? "데이터 없음")")
                
                if (200..<300).contains(response.statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let leaderBoard = try decoder.decode([LeaderBoardResponse].self, from: response.data)
                        self.leaderBoardResponses = leaderBoard // 배열 업데이트
                    } catch {
                        print("❌ [DEBUG] 디코딩 오류: \(error)")
                        self.onError?("디코딩 오류: \(error.localizedDescription)")
                    }
                } else {
                    print("❌ [DEBUG] 상태 코드 오류: \(response.statusCode)")
                    self.onError?("서버 오류: 상태 코드 \(response.statusCode)")
                }
            case .failure(let error):
                print("❌ [DEBUG] 리더보드 요청 실패: \(error.localizedDescription)")
                self.onError?("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - 리더 퀘스트 데이터 가져오기
    func fetchLeaderQuest() {
        print("🔍 [DEBUG] 리더 퀘스트 요청 시작")
        
        provider.request(.fetchLeaderQuest) { result in
            switch result {
            case .success(let response):
                print("✅ [DEBUG] 리더 퀘스트 네트워크 요청 성공")
                print("📡 [DEBUG] 응답 데이터: \(String(data: response.data, encoding: .utf8) ?? "데이터 없음")")
                
                if (200..<300).contains(response.statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let quests = try decoder.decode([LeaderQuest].self, from: response.data)
                        self.leaderQuests = quests
                    } catch {
                        print("❌ [DEBUG] 디코딩 오류: \(error)")
                        self.onError?("디코딩 오류: \(error.localizedDescription)")
                    }
                } else {
                    print("❌ [DEBUG] 상태 코드 오류: \(response.statusCode)")
                    self.onError?("서버 오류: 상태 코드 \(response.statusCode)")
                }
            case .failure(let error):
                print("❌ [DEBUG] 리더 퀘스트 요청 실패: \(error.localizedDescription)")
                self.onError?("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
}


struct DepartmentQuestDetailResponse: Decodable {
    struct Detail: Decodable {
        let departmentQuestDetailDate: String
        let revenue: Double
        let laborCost: Double
        let designServiceFee: Double
        let employeeSalary: Double
        let retirementBenefit: Double
        let socialInsuranceBenefit: Double
    }
    
    let detailList: [Detail]
    let gainedXP: Int
    let productivity: Double
    let questStatus: String
}

struct LeaderQuestResponse: Decodable {
    let employeeName: String
    let month: Int
    let questStatus: String
    let grantedPoint: Int
    let note: String
    let year: Int
}
