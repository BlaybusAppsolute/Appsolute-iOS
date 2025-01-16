//
//  Project.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//
import Foundation

struct Project: Codable {
    let projectId: Int
    let month: Int
    let day: Int
    let projectName: String
    let grantedPoint: Int?
    let note: String
}
extension Project {
    func formattedDate() -> String {
        // "2024.12.18" 형식으로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: "\(self.month)-\(self.day)") else {
            return "알 수 없음"
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy.MM.dd"
        return displayFormatter.string(from: date)
    }
}
