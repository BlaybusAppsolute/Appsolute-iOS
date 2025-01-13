//
//  CurrentYearXPView.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit
import Then

class CurrentYearXPView: UIView {
    
    // UI 요소 선언
    private let titleLabel = UILabel().then {
        $0.text = "금년도 획득 경험치:"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor.black
    }
    
    private let xpLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    private let expView = UIImageView().then {
        $0.image = UIImage(named: "exp")
    }
    private let progressContainer = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 21
        $0.layer.masksToBounds = true
    }
    
//    private let progressBar = UIProgressView().then {
//        $0.tintColor = UIColor(hex: "ffa800")
//        $0.trackTintColor = UIColor(hex: "E0E0E0")
//        $0.layer.cornerRadius = 16
//        $0.layer.masksToBounds = true
//    }
    private let progressBar = CustomProgressView()
    
//    private let subtitleLabel = UILabel().then {
//        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
//        $0.textColor = UIColor(hex: "1073F4")
//        $0.backgroundColor = UIColor(hex: "DCEBFF")
//        $0.layer.cornerRadius = 6
//        $0.layer.masksToBounds = true
//        $0.numberOfLines = 0
//    }
    private let subtitleLabel = SubtitleLabel()
    
    private let detailsContainer = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 8
        $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 4
    }
    private let detailTitleLabel = UILabel().then {
        $0.text = "| 획득 상세내역"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textAlignment = .left
    }
    
    private let totalLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.text = "총계:"
        $0.textColor = UIColor.black
    }
    
    private let totalXPLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = UIColor(hex: "F6AA00")
    }
    
    // 초기화
    init(xp: Int, percentage: Int, subtitle: String, details: [(String, Int)]) {
        super.init(frame: .zero)
        setupViews(xp: xp, percentage: percentage, subtitle: subtitle, details: details)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 구성 메서드
    private func setupViews(xp: Int, percentage: Int, subtitle: String, details: [(String, Int)]) {
        // 데이터 설정
        xpLabel.text = "\(xp)XP"
        subtitleLabel.text = subtitle
        totalXPLabel.text = "\(xp)XP"
        
        // 세부 내역 추가
        addDetails(details)
        
        // 서브뷰 추가
        addSubview(titleLabel)
        addSubview(xpLabel)
        addSubview(expView)
        addSubview(progressContainer)
        progressContainer.addSubview(progressBar)
        progressContainer.addSubview(subtitleLabel)
        addSubview(detailsContainer)
        detailsContainer.addSubview(detailTitleLabel)
        detailsContainer.addSubview(totalLabel)
        detailsContainer.addSubview(totalXPLabel)
        
        progressBar.updateProgress(to: 100)
        //progressBar.backgroundColor = .red
        
        // 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
        }
        xpLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        expView.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.trailing.equalTo(xpLabel.snp.leading).offset(-8)
            make.centerY.equalTo(xpLabel)
        }
        
        progressContainer.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(137)
        }
        
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(progressContainer.snp.top).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
            
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(28)
        }
        detailsContainer.snp.makeConstraints { make in
            make.top.equalTo(progressContainer.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(226)
        }
        detailTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        totalLabel.snp.makeConstraints { make in
            make.bottom.equalTo(detailsContainer.snp.bottom).inset(20)
            make.leading.equalToSuperview().offset(20)
        }
        totalXPLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalLabel)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    // 세부 내역 구성
    private func addDetails(_ details: [(String, Int)]) {
        var lastView: UIView? = nil
        
        for (index, detail) in details.enumerated() {
            let titleLabel = UILabel().then {
                $0.text = detail.0
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.textColor = UIColor.darkGray
            }
            let valueLabel = UILabel().then {
                $0.text = "\(detail.1)XP"
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.textColor = UIColor.black
            }
            
            detailsContainer.addSubview(titleLabel)
            detailsContainer.addSubview(valueLabel)
            
            titleLabel.snp.makeConstraints { make in
                if let lastView = lastView {
                    make.top.equalTo(lastView.snp.bottom).offset(8)
                } else {
                    make.top.equalToSuperview().offset(20)
                }
                make.leading.equalToSuperview().offset(20)
            }
            valueLabel.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.trailing.equalToSuperview().inset(20)
            }
            
            lastView = titleLabel
        }
        
        lastView?.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20) // 마지막 요소 하단 제약
        }
    }
}
