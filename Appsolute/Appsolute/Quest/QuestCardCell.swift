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

    // MARK: - UI Components
    private let badgeLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stateImageView = UIImageView() // 상태 이미지로 변경
    private let xpLabel = UILabel()
    private let moreButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6

        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 14
        badgeLabel.clipsToBounds = true
        badgeLabel.textColor = .white

        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1

        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .systemGreen
        subtitleLabel.numberOfLines = 1

        stateImageView.contentMode = .scaleAspectFit 
        stateImageView.clipsToBounds = true


        moreButton.setTitle("더보기", for: .normal)
        moreButton.setTitleColor(.darkGray, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        moreButton.backgroundColor = UIColor.systemGray6
        moreButton.layer.cornerRadius = 8
        moreButton.layer.borderWidth = 1
        moreButton.layer.borderColor = UIColor.systemGray3.cgColor

        contentView.addSubview(badgeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stateImageView)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(xpLabel)
        contentView.addSubview(moreButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        badgeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.height.equalTo(28)
            $0.width.equalTo(70)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(badgeLabel.snp.bottom).offset(10)
            $0.leading.equalTo(badgeLabel.snp.leading)
            $0.trailing.lessThanOrEqualTo(stateImageView.snp.leading).offset(-8)
        }



        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        stateImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(subtitleLabel)
            $0.width.equalTo(41)
            $0.height.equalTo(26)
        }


        moreButton.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }

    // MARK: - Configure Cell
    func configure(
        badgeText: String,
        title: String,
        subtitle: String,
        stateImage: UIImage?, // 이미지로 변경
        badgeColor: UIColor,
        xpText: String,
        buttonAction: @escaping () -> Void
    ) {
        badgeLabel.text = badgeText
        badgeLabel.backgroundColor = badgeColor
        titleLabel.text = title
        subtitleLabel.text = subtitle
        stateImageView.image = stateImage // 상태 이미지를 설정
        xpLabel.text = xpText
        moreButton.addAction(UIAction { _ in buttonAction() }, for: .touchUpInside)
    }
}
