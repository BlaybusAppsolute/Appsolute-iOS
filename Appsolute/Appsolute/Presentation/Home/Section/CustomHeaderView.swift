//
//  CustomHeaderView.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit
import Then

class CustomHeaderView: UIView {
    
    private let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "headerbackground")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        setupViews(title: title, subtitle: subtitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews(title: String, subtitle: String) {
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview() // 배경 이미지가 전체를 덮도록 설정
        }
        
        let titleLabel = UILabel().then {
            $0.text = title
            $0.font = UIFont.boldSystemFont(ofSize: 24)
            $0.textColor = .white
            $0.textAlignment = .center
        }

        let subtitleLabel = UILabel().then {
            $0.text = subtitle
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.textColor = .white
            $0.textAlignment = .center
        }

        addSubview(titleLabel)
        addSubview(subtitleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60) // 상태바와 여백 확보
        }

        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
}
