//
//  BoardCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/8/25.
//

// MARK: - BoardCollectionViewCell
import UIKit
import SnapKit

class BoardCollectionViewCell: UICollectionViewCell {
    static let identifier = "BoardCollectionViewCell"

    // UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .lightGray
        return label
    }()

    private let newBadge: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .red
        label.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 240/255, alpha: 1)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        clipsToBounds = false

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(newBadge)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(24)
            //$0.bottom.equalTo(dateLabel.snp.top).offset(5)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(24)
        }

        newBadge.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(28)
            $0.width.equalTo(52)
        }
    }

    func configure(with item: BoardItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.content
        let isoDateString = item.createdAt ?? "" // "2025-01-05T07:23:01.000+00:00"
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        // 변환 실행
        if let date = isoFormatter.date(from: isoDateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text = formattedDate // "2025-01-05"
        } else {
            dateLabel.text = "날짜 변환 실패"
        }
    }
}
