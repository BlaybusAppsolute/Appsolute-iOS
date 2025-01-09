//
//  BottomSheetViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//


import UIKit
import SnapKit

class BottomSheetViewController: UIViewController {

    // MARK: - UI Components
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 3
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "리더 뷰어"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .systemBlue
        return label
    }()

    private let projectTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "음성 1센터 업무개선 프로젝트"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let questSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "| 퀘스트 달성 내용"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private let toggleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()

    private let midButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mid", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 12
        return button
    }()

    private let maxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Max", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    private let questDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "✔ 개선 리드"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemOrange
        return label
    }()

    private let xpSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "| 획득 경험치"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private let midXPLabel: UILabel = {
        let label = UILabel()
        label.text = "Mid 달성 완료"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    private let xpBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 8
        return view
    }()

    private let xpBadgeLabel: UILabel = {
        let label = UILabel()
        label.text = "50XP 획득!"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    private let noteSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "| 비고"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "00 효율성 개선"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true

        view.addSubview(headerView)
        view.addSubview(titleLabel)
        view.addSubview(projectTitleLabel)
        view.addSubview(questSectionLabel)
        view.addSubview(toggleView)
        toggleView.addSubview(midButton)
        toggleView.addSubview(maxButton)
        view.addSubview(questDescriptionLabel)
        view.addSubview(xpSectionLabel)
        view.addSubview(midXPLabel)
        view.addSubview(xpBadgeView)
        xpBadgeView.addSubview(xpBadgeLabel)
        view.addSubview(noteSectionLabel)
        view.addSubview(noteLabel)
        view.addSubview(closeButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(4)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }

        projectTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }

        questSectionLabel.snp.makeConstraints {
            $0.top.equalTo(projectTitleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }

        toggleView.snp.makeConstraints {
            $0.top.equalTo(questSectionLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }

        midButton.snp.makeConstraints {
            $0.leading.equalTo(toggleView.snp.leading).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }

        maxButton.snp.makeConstraints {
            $0.trailing.equalTo(toggleView.snp.trailing).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }

        questDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(toggleView.snp.bottom).offset(8)
            $0.leading.equalTo(toggleView.snp.leading)
        }

        xpSectionLabel.snp.makeConstraints {
            $0.top.equalTo(questDescriptionLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }

        midXPLabel.snp.makeConstraints {
            $0.top.equalTo(xpSectionLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        xpBadgeView.snp.makeConstraints {
            $0.centerY.equalTo(midXPLabel)
            $0.leading.equalTo(midXPLabel.snp.trailing).offset(8)
            $0.width.equalTo(80)
            $0.height.equalTo(24)
        }

        xpBadgeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        noteSectionLabel.snp.makeConstraints {
            $0.top.equalTo(midXPLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }

        noteLabel.snp.makeConstraints {
            $0.top.equalTo(noteSectionLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }

        closeButton.snp.makeConstraints {
            $0.top.equalTo(noteLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}
