//
//  LeaderBoardResponse.swift
//  Appsolute
//
//  Created by 권민재 on 1/16/25.
//


struct LeaderBoardResponse: Codable {
    let employeeName: String
    let month: Int
    let questStatus: String
    let grantedPoint: Int
    let note: String?
    let year: Int
}