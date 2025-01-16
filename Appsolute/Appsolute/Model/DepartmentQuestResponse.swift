//
//  DepartmentQuestResponse.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//


import Foundation

struct DepartmentQuestResponse: Decodable {
    let departmentGroupQuestId: Int
    let departmentQuestType: String
    let maxThreshold: Double
    let mediumThreshold: Double
    let departmentGroupQuestStatus: String?
    let mediumPoint: Int
    let maxPoint: Int
    let year: Int?
    let month: Int?
    let week: Int?
    let nowXP: Int
    let departmentName: String
    let departmentGroupName: String
    let note: String?
}
