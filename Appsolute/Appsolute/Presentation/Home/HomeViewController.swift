//
//  HomeViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
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
    
    private var isSectionExpanded = [true, true] // [연도별 획득 내역, 전년도 상세 내역]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupStackView()
        configureViews()
        stackView.backgroundColor = .backgroundColor
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated) // 네비게이션 바 숨기기
//    }
    
    
    // MARK: - Setup Methods
    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
            //make.width.equalToSuperview()
        }
    }
    
    @objc func moveToProfile() {
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = true 
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    // MARK: - Configure Views
    private func configureViews() {
        // 1. 헤더뷰 (스크롤 뷰 안에 포함)
        let headerView = CustomHeaderView()
        headerView.backgroundColor = UIColor(hex: "1073F4") // 헤더 배경색 설정
        stackView.addArrangedSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        headerView.profileButton.addTarget(self, action: #selector(moveToProfile), for: .touchUpInside)
        
        // 2. 총 누적 경험치 섹션
        let totalXPView = TotalXPView(xp: totalXP, subtitle: "Lv.3까지 7500XP 남았어요!")
        stackView.addArrangedSubview(totalXPView)
        totalXPView.snp.makeConstraints { make in
            make.height.equalTo(190)
        }
        
        // 3. 연도별 획득 경험치 섹션
        let details = [
            ("상반기 인사평가:", 150),
            ("직무별 퀘스트:", 150),
            ("리더보어 퀘스트:", 100),
            ("전사 프로젝트:", 100)
        ]
        
        let xpView = CurrentYearXPView(
            xp: 500,
            percentage: 80,
            subtitle: " ↑ ‘올해 획득한 경험치 / 올해 획득 가능한 경험치’ 값이에요",
            details: details
        )
        stackView.addArrangedSubview(xpView)
        xpView.snp.makeConstraints {
            $0.height.equalTo(500)
        }
        
        // 4. 연도별 획득 내역 (접기 가능)
        let yearlyXPSection = ExpandableSectionView(
            title: "연도별 획득 내역",
            isExpanded: isSectionExpanded[0],
            contentViews: yearlyXP.map { YearlyXPItemView(year: $0.0, xp: $0.1) },
            onToggle: { [weak self] in
                self?.toggleSection(index: 0)
            }
        )
        stackView.addArrangedSubview(yearlyXPSection)
        
        // 5. 전년도 상세 내역 (접기 가능)
        let detailedXPSection = ExpandableSectionView(
            title: "전년도 상세 내역",
            isExpanded: isSectionExpanded[1],
            contentViews: detailedXP.map { DetailXPItemView(title: $0.0, value: $0.1) },
            onToggle: { [weak self] in
                self?.toggleSection(index: 1)
            }
        )
        stackView.addArrangedSubview(detailedXPSection)
    }
    
    // MARK: - Actions
    private func toggleSection(index: Int) {
        isSectionExpanded[index].toggle()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            self?.configureViews()
            self?.view.layoutIfNeeded()
        }
    }
}
