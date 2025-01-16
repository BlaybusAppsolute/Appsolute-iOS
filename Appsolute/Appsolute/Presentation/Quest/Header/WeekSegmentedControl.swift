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
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()

        for (index, week) in weeks.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(week.title, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.tag = index
            button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)

            let subtitleLabel = UILabel()
            subtitleLabel.text = week.subtitle
            subtitleLabel.font = UIFont.systemFont(ofSize: 10)
            subtitleLabel.textColor = .gray
            subtitleLabel.textAlignment = .center
            button.addSubview(subtitleLabel)

            subtitleLabel.snp.makeConstraints {
                $0.top.equalTo(button.titleLabel!.snp.bottom).offset(2)
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
                $0.top.bottom.equalToSuperview().inset(1)
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
            if index == selectedIndex {
                button.backgroundColor = UIColor(hex: "073066")
                button.setTitleColor(.white, for: .normal)
                button.subtitleLabel?.isHidden = false
                button.layer.cornerRadius = 16
                button.layer.masksToBounds = true
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.darkGray, for: .normal)
                button.subtitleLabel?.isHidden = true
                button.layer.cornerRadius = 0
                button.layer.masksToBounds = true
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
