//
//  BoardItem.swift
//  Appsolute
//
//  Created by 권민재 on 1/8/25.
//
import Foundation

struct BoardItem: Decodable {
    let boardId: Int
    let title: String?
    let content: String?
    let createdAt: String?
}
