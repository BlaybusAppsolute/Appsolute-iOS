//
//  BottomSheetViewController 2.swift
//  Appsolute
//
//  Created by 권민재 on 1/17/25.
//


import UIKit
import SnapKit
import Then

class LeaderBottomSheetViewController: UIViewController {
    
    var questId: Int? // 전달받은 questId
    var board: LeaderBoardResponse?
    
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
        headerView.badgeLabel.text = "리더 부여"
        headerView.badgeLabel.backgroundColor = UIColor(hex: "DCEBFF")
        headerView.badgeLabel.textColor = UIColor(hex: "0F69DE")
        headerView.backgroundColor = UIColor(hex: "f6f6f8")
        headerView.titleLabel.text = "\(UserManager.shared.getUser()?.departmentName ?? "") \(board?.questName ?? "") 프로젝트"
        stackView.addArrangedSubview(headerView)
        headerView.snp.makeConstraints {
            $0.height.equalTo(120)
        }
        
        // Quest View
        let questView = QuestView()
        
        if board?.questStatus == "Min" {
            questView.questStatusBar.image = UIImage(named: "min")
            questView.minLabel.text = "진행전"
            questView.minLabel.textColor = UIColor(hex: "70dd02")
            questView.maxLabel.text = board?.maxThreshold
            questView.midLabel.text = board?.mediumThreshold
        } else if board?.questStatus == "Max" {
            questView.questStatusBar.image = UIImage(named: "max")
            questView.maxLabel.text = board?.maxThreshold
            questView.midLabel.text = board?.mediumThreshold
            questView.maxLabel.textColor = .red
        } else if board?.questStatus == "Med" {
            questView.questStatusBar.image = UIImage(named: "mid")
            questView.midLabel.text = board?.mediumThreshold
            questView.maxLabel.text = board?.maxThreshold
            questView.midLabel.textColor = UIColor(hex: "ff8a00")
        }
        
        
        stackView.addArrangedSubview(questView)
        questView.snp.makeConstraints {
            $0.height.equalTo(150)
        }
        
        // 2. Experience View
        let expView = UIView()
        let expTitleLabel = UILabel()
        let expImageView = UIImageView(image: UIImage(named: "exp"))
        let expValueLabel = UILabel()
        
        // 경험치 제목
        expTitleLabel.text = "| 획득한 경험치"
        expTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        expTitleLabel.textColor = .black
        
        // 동전 이미지 (경험치 아이콘)
        expImageView.contentMode = .scaleAspectFit
        
        // 경험치 값
        expValueLabel.text = "\(board?.grantedPoint ?? 0)XP"
        expValueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        expValueLabel.textColor = .black // 금색 (동전 색상)
        
        // 경험치 뷰에 서브뷰 추가
        expView.addSubview(expTitleLabel)
        expView.addSubview(expImageView)
        expView.addSubview(expValueLabel)
        
        // 경험치 뷰 레이아웃
        expTitleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20)
        }
        
        expValueLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(expTitleLabel)
        }
        expImageView.snp.makeConstraints {
            $0.trailing.equalTo(expValueLabel.snp.leading).offset(-8)
            $0.centerY.equalTo(expTitleLabel)
            $0.width.height.equalTo(22) // 동전 이미지 크기
        }
        
        stackView.addArrangedSubview(expView)
        expView.snp.makeConstraints {
            $0.height.equalTo(50) // 경험치 뷰 높이
        }
        
        
        let noteContainerView = UIView()
        let noteTitle = UILabel().then {
            $0.text = "| 비고"
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 20)
        }
        let noteLabel = UILabel().then {
            $0.text = board?.note ?? "비고없음"
            $0.textColor = UIColor(hex: "495057")
            $0.font = UIFont.systemFont(ofSize: 19)
            $0.numberOfLines = 0 // 여러 줄 지원
        }
        
        noteContainerView.addSubview(noteTitle)
        noteContainerView.addSubview(noteLabel)
        
        if board?.note == nil || board?.note == "" {
            noteLabel.text = " 내용 없음 "
            noteLabel.textAlignment = .center
            noteLabel.textColor = .gray
        } else {
            noteLabel.text = board?.note
            noteLabel.textAlignment = .left
        }
        
        print("💥💥💥======================?\(board?.note)")
        
        noteTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        noteLabel.snp.makeConstraints {
            $0.top.equalTo(noteTitle.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        stackView.addArrangedSubview(noteContainerView)
        noteContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
