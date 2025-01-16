//
//  LeaderQuest.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
struct LeaderQuest: Codable {
    let leaderQuestId: Int
    let leaderQuestName: String
    let leaderQuestType: String
    let rate: String
    let totalQuestPoint: Int
    let maxPoint: Int
    let mediumPoint: Int
    let maxThreshold: String
    let mediumThreshold: String
    let note: String?
}
