//
//  WeekViewModel.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//

import Foundation

class WeekViewModel {
    private let calendar = Calendar.current
    var currentDate: Date = Date()

    var weeks: [(title: String, subtitle: String)] = []
    var currentWeek: Int = 0
    var onUpdate: (() -> Void)?

    init() {
        updateWeeks(for: currentDate)
    }

    func updateWeeks(for date: Date) {
        currentDate = date
        weeks = calculateWeeks(for: date)
        currentWeek = calendar.component(.weekOfMonth, from: date)
        onUpdate?()
    }

    func moveMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            updateWeeks(for: newDate)
        }
    }

    private func calculateWeeks(for date: Date) -> [(title: String, subtitle: String)] {
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let lastDayOfMonth = calendar.date(byAdding: .day, value: calendar.range(of: .day, in: .month, for: date)!.count - 1, to: firstDayOfMonth)!

        var weeks: [(title: String, subtitle: String)] = []
        var startOfWeek = firstDayOfMonth

        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"

        var weekIndex = 1

        while startOfWeek <= lastDayOfMonth {
            let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
            let endOfWeekAdjusted = min(endOfWeek, lastDayOfMonth) // 마지막 날짜를 월 마지막으로 제한
            let subtitle = "\(formatter.string(from: startOfWeek)) - \(formatter.string(from: endOfWeekAdjusted))"

            weeks.append((title: "\(weekIndex) 주차", subtitle: subtitle))

            weekIndex += 1
            startOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
        }

        return weeks
    }


    func getCurrentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter.string(from: currentDate)
    }
}
