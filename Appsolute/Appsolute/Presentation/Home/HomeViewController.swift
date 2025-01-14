//
//  HomeViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // 데이터
    private let totalXP = 1500
    private let currentYearXP = 500
    private let yearlyXP = [
        ("2025년", 500),
        ("2024년", 400),
        ("2023년", 350),
        ("2022년", 250)
    ]
    private let detailedXP = [
        ("삽화 인사하기", "150XP"),
        ("일일 퀘스트", "150XP"),
        ("인테리어 데코", "100XP"),
        ("친구 초대하기", "100XP")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupStackView()
        configureViews()
        stackView.backgroundColor = .backgroundColor
    }
    private func fetchUserData() {
        guard let token = AppKey.token else { print("토큰 없음"); return }
        
        
        
    }
    
    // MARK: - Setup Methods
    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
       
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
    }
    
    @objc func moveToProfile() {
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    // MARK: - Configure Views
    private func configureViews() {
        // 1. 헤더뷰
        let headerView = CustomHeaderView()
        headerView.backgroundColor = UIColor(hex: "1073F4")
        stackView.addArrangedSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(380)
        }
        headerView.profileButton.addTarget(self, action: #selector(moveToProfile), for: .touchUpInside)
        headerView.delegate = self
        
        // 2. 총 누적 경험치 섹션
        let totalXPView = TotalXPView(xp: totalXP, subtitle: "Lv.3까지 7500XP 남았어요!")
        stackView.addArrangedSubview(totalXPView)
        totalXPView.snp.makeConstraints { make in
            make.height.equalTo(190)
        }
        
        // 3. 금년도 획득 경험치 섹션
        let xpView = CurrentYearXPView(
            xp: currentYearXP,
            percentage: 80,
            subtitle: " ↑ ‘올해 획득한 경험치 / 올해 획득 가능한 경험치’ 값이에요",
            details: [
                ("상반기 인사평가:", 150),
                ("직무별 퀘스트:", 150),
                ("리더보어 퀘스트:", 100),
                ("전사 프로젝트:", 100)
            ]
        )
        stackView.addArrangedSubview(xpView)
        xpView.snp.makeConstraints {
            $0.height.equalTo(440)
        }
        
        // 4. 연도별 획득 경험치 섹션
        let yearlyXPView = ExpandableYearlyXPView(yearlyXPData: yearlyXP)
        stackView.addArrangedSubview(yearlyXPView)
        yearlyXPView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
//        // 5. 전년도 상세 경험치 섹션
//        let detailXPView = ExpandableDetailXPView(detailXPData: (80, "‘작년 누적 경험치 / 다음 레벨에 필요한 경험치’ 값이에요"))
//        stackView.addArrangedSubview(detailXPView)
        
        // 6. 빈 공간 추가
//        let emptyView = UIView().then {
//            $0.backgroundColor = UIColor(hex: "DCEBFF")
//        }
//        stackView.addArrangedSubview(emptyView)
//        emptyView.snp.makeConstraints {
//            $0.height.equalTo(100)
//        }
    }
}
extension HomeViewController: CustomHeaderViewDelegate {
    func didTapGuideButton() {
        let guideModalVC = RankGuideModalViewController() // 위에서 만든 모달 뷰 컨트롤러
        guideModalVC.modalPresentationStyle = .overFullScreen
        present(guideModalVC, animated: true)
    }
}
