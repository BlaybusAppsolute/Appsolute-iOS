//
//  YearlyXPSummaryCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//

import UIKit
import SnapKit
import Then

class YearlyXPSummaryCell: UICollectionViewCell {
    static let identifier = "YearlyXPSummaryCell"
    
    var isExpanded = false
    weak var delegate: CellExpansionDelegate?
    // MARK: - UI 요소
    
    // 헤더뷰
    private let headerView = UIView().then {
        $0.backgroundColor = UIColor(hex: "dcebff")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "연도별 획득 내역"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(hex: "0b52ad")
    }
//    private let toggleButton = UIButton().then {
//        $0.setTitle("펼치기", for: .normal)
//        $0.setTitleColor(.systemBlue, for: .normal)
//        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//    }
    
    // 컨테이너뷰
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    private var yearLabels: [UILabel] = []
    private var xpLabels: [UILabel] = []
    
    private let totalXPTitleLabel = UILabel().then {
        $0.text = "총 누적 경험치:"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = UIColor.black
    }
    
    private let totalXPValueLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    private let xpImageView = UIImageView().then {
        $0.image = UIImage(named: "exp")
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "dcebff")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 뷰 구성
    private func setupViews() {
        contentView.addSubview(headerView)
        headerView.addSubview(titleLabel)
        //headerView.addSubview(toggleButton)
        
        contentView.addSubview(containerView)
        containerView.addSubview(totalXPTitleLabel)
        containerView.addSubview(totalXPValueLabel)
        containerView.addSubview(xpImageView)
        
        // 기본 레이아웃
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50) // 헤더 높이
        }
//        toggleButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().inset(16)
//            make.top.equalToSuperview().offset(16)
//            make.width.equalTo(80)
//            make.height.equalTo(30)
//        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        
        totalXPTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(16)
        }
        
        xpImageView.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.centerY.equalTo(totalXPTitleLabel)
            make.trailing.equalTo(totalXPValueLabel.snp.leading).offset(-4)
        }
        
        totalXPValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(totalXPTitleLabel)
        }
    }
    
    // MARK: - Configure
    func configure(title: String, data: [(String, Int)], totalXP: Int) {
        // 타이틀 레이블 업데이트
        titleLabel.text = title
        totalXPValueLabel.text = "\(totalXP)XP"
        
        // 기존 레이블 제거
        yearLabels.forEach { $0.removeFromSuperview() }
        xpLabels.forEach { $0.removeFromSuperview() }
        yearLabels.removeAll()
        xpLabels.removeAll()
        
        // 동적 레이블 추가
        var lastLabel: UIView = containerView
        for (index, (year, xp)) in data.enumerated() {
            let yearLabel = UILabel().then {
                $0.text = year
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.textColor = UIColor.darkGray
            }
            
            let xpLabel = UILabel().then {
                $0.text = "\(xp)XP"
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.textColor = UIColor.black
            }
            
            containerView.addSubview(yearLabel)
            containerView.addSubview(xpLabel)
            
            yearLabels.append(yearLabel)
            xpLabels.append(xpLabel)
            
            yearLabel.snp.makeConstraints { make in
                if index == 0 {
                    make.top.equalToSuperview().offset(16) // 첫 번째 레이블은 컨테이너뷰의 상단에 붙임
                } else {
                    make.top.equalTo(lastLabel.snp.bottom).offset(16) // 나머지는 이전 레이블 아래
                }
                make.leading.equalToSuperview().offset(16)
            }
            
            xpLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(16)
                make.centerY.equalTo(yearLabel)
            }
            
            lastLabel = yearLabel
        }
        
        // 총 누적 경험치 레이블 위치 업데이트
        totalXPTitleLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(lastLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(16)
        }
        
        // XP 이미지 위치 유지
        xpImageView.snp.remakeConstraints { make in
            make.size.equalTo(22)
            make.centerY.equalTo(totalXPTitleLabel)
            make.trailing.equalTo(totalXPValueLabel.snp.leading).offset(-4)
        }
        
        totalXPValueLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(totalXPTitleLabel)
        }
    }
//    private func setupActions() {
//            toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
//        }
//        
//        @objc private func toggleButtonTapped() {
//            delegate?.didTapExpandButton(in: self) // ViewController로 이벤트 전달
//        }
//        
//        func toggleExpansion(animated: Bool) {
//            if isExpanded {
//                toggleButton.setTitle("접기", for: .normal)
//                // 펼쳐진 상태 UI
//            } else {
//                toggleButton.setTitle("펼치기", for: .normal)
//                // 접힌 상태 UI
//            }
//            
//            if animated {
//                UIView.animate(withDuration: 0.3) {
//                    self.layoutIfNeeded()
//                }
//            }
//        }
}
