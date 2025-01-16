//
//  QuestCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//
import UIKit
import SnapKit
import Then

class LeaderQuestCardCell: UICollectionViewCell {
    static let identifier = "LeaderQuestCardCell"
    
    

    // MARK: - UI Components
    private let badgeLabel = UILabel()
    private let titleLabel = UILabel()
    private let divider = UIImageView(image: UIImage(named: "divider"))
    private let expImageView = UIImageView()
    private let statusLabel = UILabel()
    private let statusButton = UIButton() // MIN, MID, MAX 버튼
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

        // BadgeLabel
        badgeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 8
        badgeLabel.layer.masksToBounds = true

        // StatusLabel
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        statusLabel.textAlignment = .left
        statusLabel.textColor = .gray

        // StatusButton
        statusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.layer.cornerRadius = 8
        statusButton.layer.masksToBounds = true

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
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusButton)
        contentView.addSubview(moreButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        badgeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.height.equalTo(28)
            $0.width.equalTo(70)
        }

        statusButton.snp.makeConstraints {
            $0.centerY.equalTo(statusLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(28)
            $0.width.equalTo(50)
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

        statusLabel.snp.makeConstraints {
            $0.top.equalTo(expImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }

        moreButton.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }

    // MARK: - Configure Cell
    func configure(
        questType: String,
        status: String,
        title: String,
        expImage: String,
        point: Int,
        buttonAction: @escaping () -> Void
    ) {
        
        // 기본 초기화
        badgeLabel.text = nil
        badgeLabel.backgroundColor = .clear
        badgeLabel.textColor = .black
        statusLabel.text = nil
        statusLabel.textColor = .gray
        statusButton.setTitle(nil, for: .normal)
        statusButton.backgroundColor = .clear
        titleLabel.text = nil
        expImageView.image = nil
        
        
        
        
        titleLabel.text = title
        expImageView.image = UIImage(named: expImage)
        moreButton.removeTarget(nil, action: nil, for: .allEvents)
        moreButton.addAction(UIAction { _ in buttonAction() }, for: .touchUpInside)
        
        
        if questType == "직무" {
            badgeLabel.text = "직무별"
            badgeLabel.backgroundColor = UIColor(hex: "cdfff2")
            badgeLabel.textColor = UIColor(hex: "008d6e")
            
            // 상태에 따라 UI 업데이트
            switch status.uppercased() {
            case "READY":
            
                statusLabel.text = "경험치가 아직 그대로예요!"
                statusLabel.textColor = .systemGreen
                statusButton.setTitle("Min", for: .normal)
                statusButton.backgroundColor = .systemGreen
                statusLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            case "ONGOING":
                
               
                statusLabel.text = "경험치가 \(point) 상승했어요!"
                statusLabel.textColor = .systemOrange
                statusButton.setTitle("Mid", for: .normal)
                statusButton.backgroundColor = .systemOrange
                statusLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            case "COMPLETED":
                
                
                statusLabel.text = "경험치가 \(point) 상승했어요!"
                statusLabel.textColor = .systemRed
                statusButton.setTitle("Max", for: .normal)
                statusButton.backgroundColor = .systemRed
                statusLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            default:
                
                statusLabel.text = "상태를 확인할 수 없습니다."
                statusLabel.textColor = .gray
                statusButton.setTitle("None", for: .normal)
                statusButton.backgroundColor = .lightGray
                statusLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            }
        } else {
            badgeLabel.text = "리더부여"
            badgeLabel.backgroundColor = UIColor(hex: "dcebff")
            badgeLabel.textColor = UIColor(hex: "0f69de")
            
            // 상태에 따라 UI 업데이트
            switch status.uppercased() {
            case "MIN":
            
                statusLabel.text = "경험치가 아직 그대로예요!"
                statusLabel.textColor = .systemGreen
                statusButton.setTitle("Min", for: .normal)
                statusButton.backgroundColor = .systemGreen
                statusLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            case "MED":
                
               
                statusLabel.text = "경험치가 \(point) 상승했어요!"
                statusLabel.textColor = .systemOrange
                statusButton.setTitle("Mid", for: .normal)
                statusButton.backgroundColor = .systemOrange
                statusLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            case "MAX":
                
                
                statusLabel.text = "경험치가 \(point) 상승했어요!"
                statusLabel.textColor = .systemRed
                statusButton.setTitle("Max", for: .normal)
                statusButton.backgroundColor = .systemRed
                statusLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            default:
                
                statusLabel.text = "상태를 확인할 수 없습니다."
                statusLabel.textColor = .gray
                statusButton.setTitle("None", for: .normal)
                statusButton.backgroundColor = .lightGray
                statusLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            }
        }
       

        
    }
}
