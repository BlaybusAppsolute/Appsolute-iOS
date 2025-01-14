//
//  ExpandableYearlyXPView.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//


import UIKit
import SnapKit


class ExpandableYearlyXPView: UIView {
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let arrowButton = UIButton(type: .system)
    private let contentView = UIView()
    private var contentHeightConstraint: Constraint?
    private var isExpanded = false

    init(yearlyXPData: [(String, Int)]) {
        super.init(frame: .zero)
        setupUI(yearlyXPData: yearlyXPData)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(yearlyXPData: [(String, Int)]) {
        // Header 설정
        addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(arrowButton)

        titleLabel.text = "연도별 획득 내역"
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
        contentView.clipsToBounds = true
        setupContent(yearlyXPData)

        contentView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            contentHeightConstraint = make.height.equalTo(44).constraint // 초기 최소 높이 설정
        }
    }

    private func setupContent(_ yearlyXPData: [(String, Int)]) {
        var lastView: UIView? = nil
        for (year, xp) in yearlyXPData {
            let yearLabel = UILabel()
            yearLabel.text = year
            yearLabel.font = UIFont.systemFont(ofSize: 14)
            yearLabel.textColor = .black

            let xpLabel = UILabel()
            xpLabel.text = "\(xp)XP"
            xpLabel.font = UIFont.boldSystemFont(ofSize: 14)
            xpLabel.textColor = .black

            contentView.addSubview(yearLabel)
            contentView.addSubview(xpLabel)

            yearLabel.snp.makeConstraints { make in
                if let lastView = lastView {
                    make.top.equalTo(lastView.snp.bottom).offset(8)
                } else {
                    make.top.equalToSuperview().offset(16)
                }
                make.leading.equalToSuperview().offset(16)
            }
            xpLabel.snp.makeConstraints { make in
                make.centerY.equalTo(yearLabel)
                make.trailing.equalToSuperview().inset(16)
            }

            lastView = yearLabel
        }

        lastView?.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
        }
    }

    @objc private func toggleContent() {
        isExpanded.toggle()

        let targetHeight = isExpanded
            ? contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            : 44

        contentHeightConstraint?.update(offset: targetHeight)

        UIView.animate(withDuration: 0.3) {
            self.arrowButton.transform = self.isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
            self.superview?.layoutIfNeeded()
        }
    }
}
