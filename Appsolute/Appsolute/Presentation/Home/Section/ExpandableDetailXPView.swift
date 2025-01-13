//
//  ExpandableDetailXPView.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//
import UIKit
import SnapKit

class ExpandableDetailXPView: UIView {
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let arrowButton = UIButton(type: .system)
    private let contentView = UIView()
    private var contentHeightConstraint: Constraint? // 높이 제약 조건 변수
    private var isExpanded = false

    init(detailXPData: (Int, String)) {
        super.init(frame: .zero)
        setupUI(detailXPData: detailXPData)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(detailXPData: (Int, String)) {
        // Header 설정
        addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(arrowButton)

        titleLabel.text = "전년도 상세 내역"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = UIColor(hex: "0B52AD")

        arrowButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        arrowButton.tintColor = UIColor(hex: "0B52AD")
        arrowButton.addTarget(self, action: #selector(toggleContent), for: .touchUpInside)

        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        arrowButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }

        // Content 설정
        addSubview(contentView)
        contentView.clipsToBounds = true // 컨텐츠 잘리지 않도록 설정
        contentView.backgroundColor = UIColor(hex: "F0F8FF")

        // 컨텐츠 구성
        let progressLabel = UILabel()
        progressLabel.text = "\(detailXPData.0)%"
        progressLabel.font = UIFont.boldSystemFont(ofSize: 14)
        progressLabel.textColor = .black

        let descriptionLabel = UILabel()
        descriptionLabel.text = detailXPData.1
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0

        contentView.addSubview(progressLabel)
        contentView.addSubview(descriptionLabel)

        progressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()

            // 높이 제약 조건 설정
            contentHeightConstraint = make.height.equalTo(0).constraint
        }
    }

    @objc private func toggleContent() {
        isExpanded.toggle()

        // 높이 업데이트
        let targetHeight = isExpanded ? contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height : 0
        contentHeightConstraint?.update(offset: targetHeight)

        UIView.animate(withDuration: 0.3) {
            self.arrowButton.transform = self.isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
            self.superview?.layoutIfNeeded()
        }
    }
}
