//
//  WeekViewModel.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//

import Foundation

class WeekViewModel {
    private let calendar = Calendar.current
    var currentDate: Date = Date() // 현재 날짜
    var weeks: [(title: String, subtitle: String)] = [] // 주차 배열
    var selectedWeek: Int = 1 // 선택된 주차
    var onUpdate: (() -> Void)? // 데이터 변경 시 호출되는 클로저

    init() {
        updateWeeks(for: currentDate) // 현재 날짜 기반으로 주차 계산
    }
    func selectWeek(_ week: Int) {
        guard week > 0 && week <= weeks.count else { return }
        selectedWeek = week
        onUpdate?() // 데이터 변경 시 호출
    }

    func updateWeeks(for date: Date) {
        currentDate = date
        weeks = calculateWeeks(for: date)

        // 오늘 날짜에 해당하는 주차를 계산하고 설정
        selectedWeek = findWeekContaining(date: Date())
        print("📅 [DEBUG] 주차 업데이트 완료. 오늘 날짜의 주차: \(selectedWeek)")

        onUpdate?() // 데이터 변경 이벤트 호출
    }


    func moveMonth(by value: Int) {
        guard let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) else { return }
        updateWeeks(for: newDate)
    }

    func getStartDate(for weekIndex: Int) -> Date? {
        guard weekIndex > 0 && weekIndex <= weeks.count else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // subtitle의 형식에 맞춤

        // 주차의 시작 날짜를 계산
        let dateRange = weeks[weekIndex - 1].subtitle.split(separator: "~").map { $0.trimmingCharacters(in: .whitespaces) }
        guard let startDateString = dateRange.first else { return nil }

        // 날짜 문자열을 Date로 변환
        return formatter.date(from: startDateString)
    }


    private func calculateWeeks(for date: Date) -> [(title: String, subtitle: String)] {
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let lastDayOfMonth = calendar.date(byAdding: .day, value: calendar.range(of: .day, in: .month, for: date)!.count - 1, to: firstDayOfMonth)!

        var weeks: [(title: String, subtitle: String)] = []
        var startOfWeek = firstDayOfMonth

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // 연도를 포함한 날짜 형식

        var weekIndex = 1

        while startOfWeek <= lastDayOfMonth {
            let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
            let endOfWeekAdjusted = min(endOfWeek, lastDayOfMonth)
            let subtitle = "\(formatter.string(from: startOfWeek)) ~ \(formatter.string(from: endOfWeekAdjusted))"

            weeks.append((title: "\(weekIndex)주차", subtitle: subtitle))
            weekIndex += 1
            startOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
        }

        return weeks
    }

    private func findWeekContaining(date: Date) -> Int {
        for (index, week) in weeks.enumerated() {
            guard let start = getStartDate(for: index + 1) else { continue }
            let end = calendar.date(byAdding: .day, value: 6, to: start)!

            // 오늘 날짜가 주차의 시작일과 종료일 사이에 포함되면 해당 주차 반환
            if date >= start && date <= end {
                print("📅 [DEBUG] 오늘 날짜가 포함된 주차: \(index + 1)")
                return index + 1
            }
        }
        print("📅 [DEBUG] 오늘 날짜가 포함된 주차 없음. 기본값 반환.")
        return 1 // 기본값: 첫 번째 주차
    }

    func getCurrentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter.string(from: currentDate)
    }
}
