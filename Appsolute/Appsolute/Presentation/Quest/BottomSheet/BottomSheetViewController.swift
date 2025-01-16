//
//  BottomSheetViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//


import UIKit
import SnapKit
import UIKit
import SnapKit


class BottomSheetViewController: UIViewController {
    
    var questId: Int? // 전달받은 questId
    let viewModel = QuestViewModel() // ViewModel 인스턴스
    
    var status: String?
    var  headerTitle: String?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        addComponentsToStackView()
        bindViewModel()
        fetchQuestDetailIfNeeded() // questId로 데이터를 요청
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
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
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
        // Header View
        let headerView = SheetHeaderView()
        headerView.backgroundColor = UIColor(hex: "f6f6f8")
        headerView.titleLabel.text = headerTitle
        stackView.addArrangedSubview(headerView)
        headerView.snp.makeConstraints {
            $0.height.equalTo(120)
        }
        
        // Quest View
        let questView = QuestView()
        
        if status == "READY" {
            questView.questStatusBar.image = UIImage(named: "min")
            questView.minLabel.textColor = UIColor(hex: "70DD02")
        } else if status == "COMPLETED" {
            questView.questStatusBar.image = UIImage(named: "max")
            questView.maxLabel.textColor = UIColor(hex: "FF3131")
        } else if status == "ONGOING" {
            questView.questStatusBar.image = UIImage(named: "mid")
            questView.midLabel.textColor = UIColor(hex: "FF8A00")
        }
        
        
        stackView.addArrangedSubview(questView)
        questView.snp.makeConstraints {
            $0.height.equalTo(150)
        }
        
        // Status View
        let statusView = StatusView()
        
        if let detail = viewModel.currentQuestDetail {
            statusView.expLabel.text = "\(detail.gainedXP)"
            statusView.productLabel.text = String(format: "%.2f", detail.productivity)
        } else {
            statusView.expLabel.text = "0"
            statusView.productLabel.text = "0.00"
        }
        stackView.addArrangedSubview(statusView)
        statusView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        // Finance View
        let financeView = DailyFinanceView()
        if let detail = viewModel.currentQuestDetail?.detailList {
            financeView.configure(with: detail, gainedXP: 40, productivity: 4.762)
        }
        stackView.addArrangedSubview(financeView)
        financeView.snp.makeConstraints {
            $0.height.equalTo(600)
        }
    }


    private func bindViewModel() {
        viewModel.onQuestDetailFetched = { [weak self] detail in
            guard let self = self else { return }
            DispatchQueue.main.async {
                // 기존 UI 제거
                self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                // 새 데이터로 UI 구성
                self.addComponentsToStackView()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                print("❌ [DEBUG] 에러 발생: \(errorMessage)")
            }
        }
    }


    private func fetchQuestDetailIfNeeded() {
        guard let questId = questId else {
            print("❌ [DEBUG] questId가 없습니다.")
            return
        }
        
        print("🔍 [DEBUG] questId로 데이터 요청 시작: \(questId)")
        viewModel.fetchQuestDetail(questId: questId)
    }

    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
