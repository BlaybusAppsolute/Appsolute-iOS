//
//  QuestCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//
import UIKit
import SnapKit

class QuestCardCell: UICollectionViewCell {
    static let identifier = "QuestCardCell"

    private let badgeLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let moreButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6

        badgeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true

        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black

        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray

        moreButton.setTitle("더보기", for: .normal)
        moreButton.setTitleColor(.systemBlue, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)

        contentView.addSubview(badgeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(moreButton)
    }

    private func setupConstraints() {
        badgeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.height.equalTo(20)
            $0.width.equalTo(60)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(badgeLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        moreButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
    }

    func configure(badgeText: String, title: String, subtitle: String, badgeColor: UIColor, buttonAction: @escaping () -> Void) {
        badgeLabel.text = badgeText
        badgeLabel.backgroundColor = badgeColor
        titleLabel.text = title
        subtitleLabel.text = subtitle
        moreButton.addAction(UIAction { _ in buttonAction() }, for: .touchUpInside)
    }
}
