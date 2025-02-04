//
//  HeaderView.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//
import UIKit
import SnapKit
import Then

class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"

    private let dateLabel = UILabel()
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let weekSegmentedControl = WeekSegmentedControl().then {
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }

    var onLeftButtonTap: (() -> Void)?
    var onRightButtonTap: (() -> Void)?
    var onWeekChanged: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = UIColor(hex: "1073f4")

        dateLabel.font = UIFont.boldSystemFont(ofSize: 30)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center

        leftButton.setImage(UIImage(named: "left"), for: .normal)
        leftButton.tintColor = .white
        leftButton.addTarget(self, action: #selector(handleLeftButtonTap), for: .touchUpInside)

        rightButton.setImage(UIImage(named: "right"), for: .normal)
        rightButton.tintColor = .white
        rightButton.addTarget(self, action: #selector(handleRightButtonTap), for: .touchUpInside)

        addSubview(dateLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(weekSegmentedControl)
    }

    private func setupConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }

        leftButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(30)
        }

        rightButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(30)
        }

        weekSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(67)
        }
    }

    @objc private func handleLeftButtonTap() {
        onLeftButtonTap?()
    }

    @objc private func handleRightButtonTap() {
        onRightButtonTap?()
    }

    func configure(date: String, weeks: [(String, String)], selectedWeek: Int, onLeftButtonTap: @escaping () -> Void, onRightButtonTap: @escaping () -> Void, onWeekChanged: @escaping (Int) -> Void) {
        print("📅 [DEBUG] Date: \(date), Weeks: \(weeks), Selected Week: \(selectedWeek)") // 디버깅 코드

        dateLabel.text = date
        weekSegmentedControl.configure(weeks: weeks, selectedIndex: selectedWeek - 1) { selectedWeek in
            print("📅 [DEBUG] Selected Week Changed: \(selectedWeek)") // 디버깅 코드
            onWeekChanged(selectedWeek)
        }
        self.onLeftButtonTap = onLeftButtonTap
        self.onRightButtonTap = onRightButtonTap
    }

}
