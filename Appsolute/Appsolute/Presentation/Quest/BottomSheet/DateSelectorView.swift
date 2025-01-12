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
    private let dates = ["1월 15일", "16일", "17일", "18일", "19일", "20일", "21일"]
    private var selectedDate: String?
    private var dateButtons: [UIButton] = []
    
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
        configureDates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
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
    
    private func configureDates() {
        dates.forEach { date in
            let button = createDateButton(title: date)
            stackView.addArrangedSubview(button)
            dateButtons.append(button)
        }
        selectDate(dates.first ?? "") // 초기 선택
    }
    
    // MARK: - Button Creation
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
    
    // MARK: - Button Actions
    @objc private func dateButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        selectDate(title)
    }
    
    private func selectDate(_ date: String) {
        selectedDate = date

        dateButtons.forEach { button in
            let isSelected = (button.title(for: .normal) == date)

            // 버튼 스타일 업데이트
            updateButtonStyle(button, isSelected: isSelected)

            // 버튼 크기 업데이트 (애니메이션 적용)
            button.snp.remakeConstraints { make in
                make.height.equalTo(isSelected ? 60 : 48) // 선택된 버튼 크기 증가
                make.width.equalTo(isSelected ? 60 : 48) // 선택된 버튼 크기 증가
            }
        }

        // 레이아웃 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    private func updateButtonStyle(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = UIColor(hex: "123B75") // 선택된 배경색
            button.setTitleColor(.white, for: .normal)     // 선택된 텍스트 색상
        } else {
            button.backgroundColor = .clear               // 기본 배경색
            button.setTitleColor(UIColor(hex: "4F6D9C"), for: .normal) // 기본 텍스트 색상
        }
    }

}
