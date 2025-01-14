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

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
    }

    private let arrowButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .black
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.isHidden = true
    }

    var toggleHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowButton)
        contentView.addSubview(stackView)

        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
        }

        arrowButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(titleLabel)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }

        arrowButton.addTarget(self, action: #selector(toggleExpand), for: .touchUpInside)
    }

    func configure(title: String, data: [(String, Int)], isExpanded: Bool) {
        titleLabel.text = title
        stackView.isHidden = !isExpanded // 확장 상태에 따라 스택뷰 보이기/숨기기

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (year, xp) in data {
            let row = UILabel()
            row.text = "\(year): \(xp)XP"
            stackView.addArrangedSubview(row)
        }

        let rotationAngle: CGFloat = isExpanded ? .pi : 0
        arrowButton.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }

    @objc private func toggleExpand() {
        toggleHandler?()
    }
}
