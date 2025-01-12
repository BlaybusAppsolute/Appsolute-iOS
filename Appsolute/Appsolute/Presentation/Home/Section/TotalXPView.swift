//
//  TotalXPView.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit
import Then

class TotalXPView: UIView {
    
    // MARK: - UI Components
    private let titleLabel = UILabel().then {
        $0.text = "총 누적 경험치:"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black 
    }
    private let expView = UIImageView().then {
        $0.image = UIImage(named: "exp")
    }
    
    private let expLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    private let graphContainerView = UIView().then {
        $0.backgroundColor = .white // 배경색
        $0.layer.cornerRadius = 12
    }
    
    private let progressImageView = UIImageView().then {
        $0.image = UIImage(named: "progressIcon") // 시작 아이콘
        $0.contentMode = .scaleAspectFit
    }
    
    private let endImageView = UIImageView().then {
        $0.image = UIImage(named: "leafIcon") // 끝 아이콘
        $0.contentMode = .scaleAspectFit
    }
    
    private let progressLabel = UILabel().then {
        $0.text = "1500XP"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .white
    }
    
    private let subtitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .gray
        $0.backgroundColor = UIColor(hex: "DCEBFF")
        $0.textColor = UIColor(hex: "1073f4")
        $0.textAlignment = .left
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
    }
    
    private let progressBar = UIView().then {
        $0.backgroundColor = UIColor(hex: "E9ECEF")
        $0.layer.cornerRadius = 16
    }
    
    // MARK: - Initializer
    init(xp: Int, subtitle: String) {
        super.init(frame: .zero)
        setupViews()
        configure(xp: xp, subtitle: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func configure(xp: Int, subtitle: String) {
        expLabel.text = "\(xp)XP"
        progressLabel.text = "\(xp)XP"
        subtitleLabel.text = subtitle
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(expView)
        addSubview(expLabel)
        addSubview(graphContainerView)
        graphContainerView.addSubview(progressImageView)
        graphContainerView.addSubview(endImageView)
        graphContainerView.addSubview(progressBar)
        progressBar.addSubview(progressLabel)
        graphContainerView.addSubview(subtitleLabel)
        
        // Title Label
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        // 경험치 Label
        expLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        expView.snp.makeConstraints {
            $0.size.equalTo(22)
            $0.trailing.equalTo(expLabel.snp.leading).offset(-8)
            $0.centerY.equalTo(expLabel)
        }
        
        // 그래프 컨테이너
        graphContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(134)
        }
        
        // Progress 아이콘 (왼쪽)
        progressImageView.snp.makeConstraints { make in
            make.leading.equalTo(graphContainerView).offset(12)
            make.centerY.equalTo(graphContainerView)
            make.size.equalTo(36)
        }
        
        // End 아이콘 (오른쪽)
        endImageView.snp.makeConstraints { make in
            make.trailing.equalTo(graphContainerView).inset(12)
            make.centerY.equalTo(graphContainerView)
            make.size.equalTo(36)
        }
        
        // Progress Bar
        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
        
        // Progress Label
        progressLabel.snp.makeConstraints { make in
            make.centerX.equalTo(progressBar)
            make.centerY.equalTo(progressBar)
        }
        
        // Subtitle Label
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(graphContainerView.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(28)
        }
    }
}
