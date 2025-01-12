//
//  StatusView.swift
//  Appsolute
//
//  Created by 권민재 on 1/10/25.
//

import UIKit
import SnapKit
import Then

class StatusView: UIView {

    let expTitleLabel = UILabel().then {
        $0.text = "| 획득한 경험치"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    private let expLabel = UILabel()

    let productTitleLabel = UILabel().then {
        $0.text = "| 생산성"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    let productLabel = UILabel().then {
        $0.text = "4.762P"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    let dividerView1 = UIImageView().then {
        $0.image = UIImage(named: "divider")
    }

    let dividerView2 = UIImageView().then {
        $0.image = UIImage(named: "divider")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        configureExpLabel(with: 50) // 초기 경험치 값을 설정
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(expTitleLabel)
        addSubview(expLabel)
        addSubview(dividerView1)
        addSubview(productTitleLabel)
        addSubview(productLabel)
        addSubview(dividerView2)
    }

    private func setupConstraints() {
        expTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(16)
        }

        expLabel.snp.makeConstraints {
            $0.top.equalTo(expTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        dividerView1.snp.makeConstraints {
            $0.top.equalTo(expLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        productTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView1.snp.bottom).offset(10)
            $0.leading.equalTo(expTitleLabel.snp.leading)
        }

        productLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(productTitleLabel)
        }

        dividerView2.snp.makeConstraints {
            $0.top.equalTo(productLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
    }

    /// 경험치 라벨을 업데이트하는 메서드
    func configureExpLabel(with value: Int) {
        let attributedString = NSMutableAttributedString()

        // 이미지 첨부 설정
        if let expImage = UIImage(named: "exp") {
            let attachment = NSTextAttachment()
            attachment.image = expImage
            attachment.bounds = CGRect(x: 0, y: -4, width: 20, height: 20) // 이미지 크기와 위치 조정
            let imageString = NSAttributedString(attachment: attachment)
            attributedString.append(imageString)
        }

        // 텍스트 추가
        let textString = NSAttributedString(string: " \(value)XP", attributes: [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.black
        ])
        attributedString.append(textString)

        // UILabel에 설정
        expLabel.attributedText = attributedString
    }

    /// 생산성 라벨을 업데이트하는 메서드
    func updateProductivityLabel(with value: String) {
        productLabel.text = "\(value)P"
    }
}
