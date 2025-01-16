//
//  ProjectViewModel.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//


import Foundation
import Moya

class ProjectViewModel {
    // MARK: - Properties
    private let provider = MoyaProvider<ProjectAPI>()
    private(set) var projects: [Project] = []
    
    var onProjectsUpdated: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?

  
    func fetchProjects(userId: String) {
        print("📡 [DEBUG] Fetching projects for userId: \(userId)") // 요청 시작 로그
        
        provider.request(.fetchProjects(userId: userId)) { [weak self] result in
            switch result {
            case .success(let response):
                print("✅ [DEBUG] Request succeeded with status code: \(response.statusCode)")
                print("📦 [DEBUG] Response Data: \(String(data: response.data, encoding: .utf8) ?? "nil")")
                
                do {
                    let decoder = JSONDecoder()
                    let projects = try decoder.decode([Project].self, from: response.data)
                    
                    // 프로젝트 데이터 업데이트
                    self?.projects = projects
                    print("✅ [DEBUG] Decoded Projects: \(projects)")
                    
                    self?.onProjectsUpdated?() // 데이터 변경 알림
                } catch {
                    let errorMessage = "데이터 파싱 실패: \(error.localizedDescription)"
                    print("❌ [DEBUG] \(errorMessage)")
                    self?.onErrorOccurred?(errorMessage)
                }
                
            case .failure(let error):
                let errorMessage = "네트워크 오류: \(error.localizedDescription)"
                print("❌ [DEBUG] \(errorMessage)")
                self?.onErrorOccurred?(errorMessage)
            }
        }
    }
}
