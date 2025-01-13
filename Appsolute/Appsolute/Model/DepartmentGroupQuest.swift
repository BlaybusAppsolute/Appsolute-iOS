//
//  DepartmentGroupQuest.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//


import Foundation

struct DepartmentGroupQuest: Codable {
    let departmentGroupQuestId: Int
    let departmentQuestType: String
    let maxThreshold: Int
    let mediumThreshold: Int
    let departmentGroupQuestStatus: String
    let mediumPoint: Int
    let maxPoint: Int
    let year: Int
    let month: Int
    let week: Int
    let nowXP: Int
    let departmentName: String
    let departmentGroupName: String
    let note: String
}