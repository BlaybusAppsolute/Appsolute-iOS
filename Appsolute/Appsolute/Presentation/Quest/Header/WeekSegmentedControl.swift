//
//  WeekSegmentedControl.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//


import UIKit
import SnapKit

class WeekSegmentedControl: UIView {
    private var weeks: [(title: String, subtitle: String)] = [] {
        didSet {
            setupButtons()
        }
    }
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0 {
        didSet {
            updateButtonStyles()
            onWeekSelected?(selectedIndex + 1)
        }
    }

    var onWeekSelected: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtons() {
        // 기존 버튼 제거
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()

        for (index, week) in weeks.enumerated() {
            // 버튼 생성
            let button = UIButton(type: .system)
            button.tag = index
            button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)

            // 버튼의 텍스트와 스타일 설정
            let titleLabel = UILabel()
            titleLabel.text = week.title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            titleLabel.textAlignment = .center
            titleLabel.textColor = index == selectedIndex ? .white : .darkGray

            let subtitleLabel = UILabel()
            subtitleLabel.text = week.subtitle
            subtitleLabel.font = UIFont.systemFont(ofSize: 10)
            subtitleLabel.textAlignment = .center
            subtitleLabel.textColor = index == selectedIndex ? .white : .gray

            // 버튼에 서브뷰 추가
            button.addSubview(titleLabel)
            button.addSubview(subtitleLabel)

            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(8)
                $0.centerX.equalToSuperview()
            }

            subtitleLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(4)
                $0.centerX.equalToSuperview()
            }

            buttons.append(button)
            addSubview(button)
        }

        setupConstraints()
        updateButtonStyles()
    }

    private func setupConstraints() {
        for (index, button) in buttons.enumerated() {
            button.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(4)
                $0.width.equalToSuperview().dividedBy(buttons.count)
                if index == 0 {
                    $0.leading.equalToSuperview()
                } else {
                    $0.leading.equalTo(buttons[index - 1].snp.trailing)
                }
            }
        }
    }

    private func updateButtonStyles() {
        for (index, button) in buttons.enumerated() {
            button.backgroundColor = index == selectedIndex ? UIColor(hex: "073066") : .clear
            button.layer.cornerRadius = index == selectedIndex ? 16 : 0
            button.layer.masksToBounds = true

            // 각 버튼의 텍스트 색상 변경
            if let titleLabel = button.subviews.first(where: { $0 is UILabel }) as? UILabel,
               let subtitleLabel = button.subviews.last(where: { $0 is UILabel }) as? UILabel {
                titleLabel.textColor = index == selectedIndex ? .white : .darkGray
                subtitleLabel.textColor = index == selectedIndex ? .white : .gray
            }
        }
    }

    @objc private func handleButtonTap(_ sender: UIButton) {
        selectedIndex = sender.tag
    }

    func configure(weeks: [(String, String)], selectedIndex: Int, onWeekSelected: @escaping (Int) -> Void) {
        self.weeks = weeks
        self.selectedIndex = selectedIndex
        self.onWeekSelected = onWeekSelected
    }
}
