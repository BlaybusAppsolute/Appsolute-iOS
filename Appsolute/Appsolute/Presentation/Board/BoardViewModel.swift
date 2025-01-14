//
//  BoardViewModel.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//

import Foundation
import Moya

class BoardViewModel {
    
 
    private let provider = MoyaProvider<BoardAPI>()
    
    
    var boards: [BoardItem] = []
    
    func fetchBoards(
        onSuccess: @escaping () -> Void,
        onFailure: @escaping (String) -> Void
    ) {
        provider.request(.getBoards) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    // 디코딩
                    let decodedResponse = try JSONDecoder().decode([BoardItem].self, from: response.data)
                    self?.boards = decodedResponse
                    print("✅ [BoardViewModel] 게시판 데이터 로드 성공: \(decodedResponse)")
                    onSuccess()
                } catch {
                    print("❌ [BoardViewModel] 디코딩 실패: \(error.localizedDescription)")
                    onFailure("데이터를 처리하는 중 오류가 발생했습니다.")
                }
                
            case .failure(let error):
                print("❌ [BoardViewModel] 네트워크 오류: \(error.localizedDescription)")
                onFailure("네트워크 연결 상태를 확인해주세요.")
            }
        }
    }
}
