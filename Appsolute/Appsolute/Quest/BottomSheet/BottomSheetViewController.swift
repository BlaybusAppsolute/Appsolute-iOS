//
//  BottomSheetViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//


import UIKit
import SnapKit

class BottomSheetViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        addComponentsToStackView()
    }

    private func setupViews() {
        view.backgroundColor = .white

        
        scrollView.showsVerticalScrollIndicator = true
        
        scrollView.alwaysBounceVertical = true
        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)

       
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        scrollView.addSubview(stackView)
        
        

       
        closeButton.setTitle("닫기", for: .normal)
        closeButton.backgroundColor = .systemBlue
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.layer.cornerRadius = 12
        view.addSubview(closeButton)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(closeButton.snp.top).offset(-16)
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }

        closeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(45)
            make.height.equalTo(51)
        }
    }

    private func addComponentsToStackView() {
        let headerView = SheetHeaderView()
        headerView.backgroundColor = UIColor(hex: "f6f6f8")
        stackView.addArrangedSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.height.equalTo(120)
        }
        
        let questView = QuestView()
        stackView.addArrangedSubview(questView)
        
        questView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        let statusView = StatusView()
        //statusView.backgroundColor = .red
        stackView.addArrangedSubview(statusView)
        
        statusView.snp.makeConstraints {
            $0.height.equalTo(140)
        }
        
        let financeView = DailyFinanceView()
        stackView.addArrangedSubview(financeView)
        
        financeView.configureDates(
            with: ["1월 15일", "16일", "17일", "18일", "19일", "20일", "21일"],
            selectedDate: "1월 15일"
        )

        financeView.configureDetails(with: [
            ["항목": "인건비", "금액": "4"],
            ["항목": "직원급여", "금액": "1"],
            ["항목": "퇴직급여", "금액": "1"],
            ["항목": "4대 보험료", "금액": "1"],
            ["항목": "설계용역비", "금액": "1"]
        ])
        
        financeView.snp.makeConstraints {
            $0.height.equalTo(500)
        }

    
    }
}
