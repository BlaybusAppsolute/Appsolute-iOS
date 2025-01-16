//
//  LevelManager.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//
import Foundation


class LevelManager {
    static let shared = LevelManager()
    private init() {}

    // MARK: - 직군별 레벨 데이터
    private let levels: [String: [String: LevelInfo]] = [
        "F": [
            // Lv.1 꿈틀이 씨앗
            "F1-Ⅰ": LevelInfo(displayName: "Lv.1 꿈틀이 씨앗-1", xp: 0, imageName: "레벨01", levelNumber: 1),
            "F1-Ⅱ": LevelInfo(displayName: "Lv.2 꿈틀이 씨앗-2", xp: 13500, imageName: "레벨02", levelNumber: 2),

            // Lv.2 자라나는 새싹
            "F2-Ⅰ": LevelInfo(displayName: "Lv.3 자라나는 새싹-1", xp: 27000, imageName: "레벨02", levelNumber: 2),
            "F2-Ⅱ": LevelInfo(displayName: "Lv.3 자라나는 새싹-2", xp: 39000, imageName: "레벨02", levelNumber: 2),
            "F2-Ⅲ": LevelInfo(displayName: "Lv.3 쑥쑥 잎사귀-1", xp: 51000, imageName: "레벨03", levelNumber: 3),

            // Lv.3 쑥쑥 잎사귀
            "F3-Ⅰ": LevelInfo(displayName: "Lv.3 쑥쑥 잎사귀-2", xp: 63000, imageName: "레벨03", levelNumber: 3),
            "F3-Ⅱ": LevelInfo(displayName: "Lv.3 쑥쑥 잎사귀-3", xp: 78000, imageName: "레벨03", levelNumber: 3),
            "F3-Ⅲ": LevelInfo(displayName: "Lv.4 푸릇푸릇 초목-1", xp: 93000, imageName: "레벨04", levelNumber: 4),

            // Lv.4 푸릇푸릇 초목
            "F4-Ⅰ": LevelInfo(displayName: "Lv.4 푸릇푸릇 초목-2", xp: 108000, imageName: "레벨04", levelNumber: 4),
            "F4-Ⅱ": LevelInfo(displayName: "Lv.5 우뚝 나무-1", xp: 126000, imageName: "레벨05", levelNumber: 5),

            // Lv.5 우뚝 나무
            "F5": LevelInfo(displayName: "Lv.5 우뚝 나무-2", xp: 144000, imageName: "레벨05", levelNumber: 6),

            // Lv.6 만개 꽃나무
            "F6-Ⅰ": LevelInfo(displayName: "Lv.6 만개 꽃나무", xp: 162000, imageName: "레벨06", levelNumber: 12)
        ],
        "B": [
            "B1": LevelInfo(displayName: "Lv.1 꿈틀이 씨앗", xp: 0, imageName: "레벨01", levelNumber: 1),
            "B2": LevelInfo(displayName: "Lv.2 자라나는 새싹", xp: 24000, imageName: "레벨02", levelNumber: 2),
            "B3": LevelInfo(displayName: "Lv.3 쑥쑥 잎사귀", xp: 52000, imageName: "레벨03", levelNumber: 3),
            "B4": LevelInfo(displayName: "Lv.4 푸릇푸릇 초목", xp: 52000, imageName: "레벨04", levelNumber: 4),
            "B5": LevelInfo(displayName: "Lv.5 우뚝 나무", xp: 52000, imageName: "레벨05", levelNumber: 5),
            "B6": LevelInfo(displayName: "Lv.6 만개 꽃나무", xp: 169000, imageName: "레벨06", levelNumber: 6)
        ],
        "G": [
            "G1": LevelInfo(displayName: "Lv.1 꿈틀이 씨앗", xp: 0, imageName: "레벨01", levelNumber: 1),
            "G2": LevelInfo(displayName: "Lv.2 자라나는 새싹", xp: 24000, imageName: "레벨02", levelNumber: 2),
            "G3": LevelInfo(displayName: "Lv.3 쑥쑥 잎사귀", xp: 52000, imageName: "레벨03", levelNumber: 3),
            "G4": LevelInfo(displayName: "Lv.4 푸릇푸릇 초목", xp: 52000, imageName: "레벨04", levelNumber: 4),
            "G5": LevelInfo(displayName: "Lv.5 우뚝 나무", xp: 52000, imageName: "레벨05", levelNumber: 5),
            "G6": LevelInfo(displayName: "Lv.6 만개 꽃나무", xp: 169000, imageName: "레벨06", levelNumber: 6)
        ]
    ]

    // MARK: - 유니코드 레벨 이름 변환
    private func normalizeLevelName(_ levelName: String) -> String {
        return levelName
            .replacingOccurrences(of: "Ⅰ", with: "I")
            .replacingOccurrences(of: "Ⅱ", with: "II")
            .replacingOccurrences(of: "Ⅲ", with: "III")
    }

    func getLevelInfo(for levelName: String) -> LevelInfo? {
        // 유니코드 변환 여부 확인
        let normalizedLevelName: String
        if levels.values.flatMap({ $0.keys }).contains(levelName) {
            // 변환하지 않아도 되는 경우
            normalizedLevelName = levelName
        } else {
            // 변환이 필요한 경우
            normalizedLevelName = normalizeLevelName(levelName)
        }

        // 직군 추출
        let jobGroup = String(normalizedLevelName.prefix(1)) // "F1-I" -> "F"

        // 디버깅 로그
        print("📡 [DEBUG] Original levelName: \(levelName)")
        print("📡 [DEBUG] Normalized levelName: \(normalizedLevelName)")
        print("📡 [DEBUG] jobGroup: \(jobGroup)")

        guard let groupLevels = levels[jobGroup] else {
            print("❌ [DEBUG] 직군 데이터 없음: \(jobGroup)")
            print("📡 [DEBUG] Available jobGroups: \(levels.keys)")
            return nil
        }

        guard let levelInfo = groupLevels[normalizedLevelName] else {
            print("❌ [DEBUG] 해당 레벨 없음: \(normalizedLevelName)")
            print("📡 [DEBUG] Available levels: \(groupLevels.keys)")
            return nil
        }

        print("✅ [DEBUG] levelInfo: \(levelInfo)")
        return levelInfo
    }
    
    func getLevelInfo(forXP xp: Int, levelName: String) -> LevelInfo? {
        // 1. 유니코드 레벨 이름 변환
        let normalizedLevelName = normalizeLevelName(levelName)

        // 2. 직군 추출 (레벨 이름의 첫 글자)
        let jobGroup = String(normalizedLevelName.prefix(1))

        // 디버깅 로그
        print("📡 [DEBUG] Original levelName: \(levelName)")
        print("📡 [DEBUG] Normalized levelName: \(normalizedLevelName)")
        print("📡 [DEBUG] jobGroup: \(jobGroup)")

        // 3. 해당 직군의 레벨 데이터 가져오기
        guard let groupLevels = levels[jobGroup] else {
            print("❌ [DEBUG] 직군 데이터 없음: \(jobGroup)")
            print("📡 [DEBUG] Available jobGroups: \(levels.keys)")
            return nil
        }

        // 4. XP 순으로 정렬
        let sortedLevels = groupLevels.values.sorted { $0.xp < $1.xp }

        // 5. XP 범위에 맞는 레벨 찾기
        for (index, level) in sortedLevels.enumerated() {
            // 현재 레벨의 XP와 다음 레벨의 XP를 비교
            let nextLevelXP = (index + 1 < sortedLevels.count) ? sortedLevels[index + 1].xp : Int.max
            if xp >= level.xp && xp < nextLevelXP {
                return level
            }
        }

        // 6. XP가 모든 범위를 초과하면 마지막 레벨 반환
        return sortedLevels.last
    }


}
