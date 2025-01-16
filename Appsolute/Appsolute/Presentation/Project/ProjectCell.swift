//
//  ProjectCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/8/25.
//

import UIKit
import SnapKit

class ProjectCell: UICollectionViewCell {
    static let identifier = "ProjectCell"

    // UI Components
    private let bulletView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        //1label.backgroundColor = .red
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()

    private let xpBadge: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.backgroundColor = UIColor(hex: "fff3d4")
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
        clipsToBounds = true

        contentView.addSubview(bulletView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(xpBadge)
    }

    private func setupConstraints() {
        bulletView.snp.makeConstraints {
            $0.width.height.equalTo(8)
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(30)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bulletView.snp.trailing).offset(8)
            $0.centerY.equalTo(bulletView)
            $0.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(bulletView.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.height.equalTo(24)
            $0.trailing.equalToSuperview().inset(20)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(bulletView)
            $0.bottom.equalToSuperview().inset(20)
        }

        xpBadge.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(31)
            $0.width.greaterThanOrEqualTo(115)
        }
    }

    func configure(with project: Project) {
        titleLabel.text = project.projectName
        descriptionLabel.text = project.note
        dateLabel.text = "2025.\(project.month).\(project.day)"
        xpBadge.text = "\(project.grantedPoint)XP 획득"
    }
}

