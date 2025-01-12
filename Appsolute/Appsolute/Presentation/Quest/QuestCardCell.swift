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
    private let badgeLabel = UIImageView()
    private let titleLabel = UILabel()
    private let divider = UIImageView(image: UIImage(named: "divider"))
    private let expImageView = UIImageView()
    
    
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

        badgeLabel.image = UIImage(named: "leader")
        expImageView.image = UIImage(named: "mid-card")

        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1


        moreButton.setTitle("더보기", for: .normal)
        moreButton.setTitleColor(.darkGray, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        moreButton.backgroundColor = UIColor(hex: "F8F9FA")
        moreButton.layer.cornerRadius = 8
        moreButton.layer.borderWidth = 1
        moreButton.layer.borderColor = UIColor.systemGray3.cgColor

        contentView.addSubview(badgeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(divider)
        contentView.addSubview(expImageView)
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
        }
        divider.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        expImageView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }



        moreButton.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }

    // MARK: - Configure Cell
    func configure(
        //badgeText: String,
        title: String,
        expImage: String,
        buttonAction: @escaping () -> Void
    ) {
        titleLabel.text = title
        expImageView.image = UIImage(named: expImage)
        moreButton.addAction(UIAction { _ in buttonAction() }, for: .touchUpInside)
    }
}
