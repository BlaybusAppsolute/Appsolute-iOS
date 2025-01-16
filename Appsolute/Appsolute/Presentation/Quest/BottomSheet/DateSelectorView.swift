//
//  DateSelectorView.swift
//  Appsolute
//
//  Created by 권민재 on 1/11/25.
//


import UIKit
import SnapKit
import Then

class DateSelectorView: UIView {
    // MARK: - Properties
    private var dates: [String] = [] // 전체 날짜
    private var selectedDate: String?
    private var dateButtons: [UIButton] = []

    // 날짜 선택 시 호출될 클로저
    var onDateSelected: ((String) -> Void)?

    // MARK: - UI Components
    private let containerView = UIView().then {
        $0.backgroundColor = UIColor(hex: "EAF4FF")
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }

    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fillEqually
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(stackView)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }

    // 날짜 설정
    func configureDates(_ dates: [String]) {
        self.dates = dates
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // 기존 버튼 제거
        dateButtons.removeAll()

        dates.forEach { date in
            // 날짜에서 '일(day)'만 추출
            let day = extractDay(from: date)
            let button = createDateButton(title: day)
            stackView.addArrangedSubview(button)
            dateButtons.append(button)
        }

        // 초기 날짜 선택
        if let firstDate = dates.first {
            selectDate(firstDate)
        }
    }

    private func createDateButton(title: String) -> UIButton {
        let button = UIButton(type: .system).then {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(UIColor(hex: "4F6D9C"), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 8
            $0.addTarget(self, action: #selector(dateButtonTapped(_:)), for: .touchUpInside)
        }
        return button
    }

    @objc private func dateButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal),
              let index = dateButtons.firstIndex(of: sender) else { return }

        // 선택한 버튼의 원래 날짜 가져오기
        let selectedFullDate = dates[index]
        selectDate(selectedFullDate)
    }

    private func selectDate(_ date: String) {
        selectedDate = date

        dateButtons.forEach { button in
            let isSelected = (dates.firstIndex(where: { $0 == date }) == dateButtons.firstIndex(of: button))
            updateButtonStyle(button, isSelected: isSelected)
        }

        // 선택된 날짜 전달
        onDateSelected?(date)
    }

    private func updateButtonStyle(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = UIColor(hex: "123B75")
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = .clear
            button.setTitleColor(UIColor(hex: "4F6D9C"), for: .normal)
        }
    }

    private func extractDay(from date: String) -> String {
        // 날짜 형식이 "2025-01-16"와 같다고 가정하고 '16일' 추출
        let components = date.split(separator: "-")
        if components.count == 3, let day = components.last {
            return "\(day)일"
        }
        return date // 형식이 다르면 전체 날짜 반환
    }
}
