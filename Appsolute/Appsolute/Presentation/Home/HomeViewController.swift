//
//  HomeViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//
import UIKit
import SnapKit
import Then

struct SectionData {
    let title: String
    var isExpanded: Bool
    let items: [String]
}

class HomeViewController: UIViewController {
    
    var levelInfo: LevelInfo?
    var userInfo: User?
    
    private var expandedIndexPath: IndexPath?
    private var sections: [SectionData] = [
            SectionData(title: "연도별 획득 내역", isExpanded: false, items: ["2025년: 500XP", "2024년: 400XP", "2023년: 350XP"]),
            SectionData(title: "전년도 상세 내역", isExpanded: false, items: ["작업 평가: 100XP", "팀워크: 200XP", "리더십: 150XP"]),
        ]
    
    // MARK: - 데이터
    private let yearlyXPData: [(String, Int)] = [
        ("2025년", 500),
        ("2024년", 400),
        ("2023년", 350)
    ]
    private let detailXPData: (Int, String) = (80, "작업 평가: 100XP\n팀워크: 200XP\n리더십: 150XP")
    
    private let totalXPData = (xp: 1500, subtitle: "Lv.4까지 7500XP 남았어요!") // TotalXP 데이터
    private let currentYearXPData = (xp: 500, percentage: 50, subtitle: "⬆️ 올헤 획득한 경험치 / 올해 획득 가능한 경험치 값이에요", details: [("상반기 인사평가", 150), ("직무별 퀘스트", 200)]) // CurrentYearXP 데이터
    
    // MARK: - UI 요소
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = false
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // MARK: - 라이프 사이클
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupConstraints()
        fetchUsersData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 셀 등록
        collectionView.register(TotalXPCollectionViewCell.self, forCellWithReuseIdentifier: TotalXPCollectionViewCell.identifier)
        collectionView.register(CurrentYearXPCollectionViewCell.self, forCellWithReuseIdentifier: CurrentYearXPCollectionViewCell.identifier)
        collectionView.register(YearlyXPSummaryCell.self, forCellWithReuseIdentifier: YearlyXPSummaryCell.identifier)
        collectionView.register(DetailXPSummaryCell.self, forCellWithReuseIdentifier: DetailXPSummaryCell.identifier)
        
        // 헤더 등록
        collectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.identifier)
//        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EmptyHeader")
        // 레이아웃 설정
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        view.addSubview(collectionView)
    }

    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    private func fetchUsersData() {
        
        let homeViewModel = HomeViewModel()
        homeViewModel.fetchUsers(token: AppKey.token ?? "", onSuccess: { users in
            print("✅ 유저 데이터 가져오기 성공: \(users)")
            UserManager.shared.saveUser(users)
            self.levelInfo = self.refineLevelInfo(for: users)
            self.userInfo = users
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }, onFailure: { errorMessage in
            print("❌ 유저 데이터 가져오기 실패: \(errorMessage)")
        })
    }
    
    func refineLevelInfo(for user: User) -> LevelInfo? {
        let data = LevelManager.shared.getLevelInfo(forXP: user.totalXP, levelName: user.levelName)
        return data
    }
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10 // 셀 간 간격 (픽셀 단위)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // 모든 섹션은 1개의 셀
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalXPCollectionViewCell.identifier, for: indexPath) as? TotalXPCollectionViewCell else {
                    return UICollectionViewCell()
                }
                if let userInfo = userInfo, let levelInfo = levelInfo {
                    cell.configure(user: userInfo, levelInfo: levelInfo)
                }
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentYearXPCollectionViewCell.identifier, for: indexPath) as? CurrentYearXPCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                
                
                if let userInfo = userInfo {
                    let details: [(String, Int)] = [
                        ("작업 평가", userInfo.thisEvaluationXP),
                        ("팀워크", userInfo.thisDepartmentGroupXP),
                        ("프로젝트", userInfo.thisProjectXP),
                        ("퀘스트", userInfo.thisLeQuestXP)
                    ]
                    cell.configure(xp: userInfo.thisYearTotalXP, percentage: Int((Double(userInfo.thisYearTotalXP) / 9000.0) * 100), subtitle: currentYearXPData.subtitle, details: details)
                }
        
                return cell
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YearlyXPSummaryCell.identifier, for: indexPath) as? YearlyXPSummaryCell else {
                    return UICollectionViewCell()
                }
                if let userInfo = userInfo {
                    let yearlyData: [(String, Int)] = [
                        ("2025년(올해)", userInfo.thisYearTotalXP),
                        ("2024년", userInfo.lastYearTotalXP),
                        ("2023년", 0),
                        ("2022년", 0)
                    ]
                    let totalXP = yearlyData.reduce(0) { $0 + $1.1 }
    
                    cell.configure(title: "연도별 획득 내역", data: yearlyData, totalXP: totalXP)
                }
                cell.delegate = self
                
            
                return cell
            case 3:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailXPSummaryCell.identifier ,for: indexPath) as? DetailXPSummaryCell else {
                    return UICollectionViewCell()
                }
            
                cell.configure(xp: userInfo?.lastYearTotalXP ?? 0, percentage: Int((Double(userInfo?.lastYearTotalXP ?? 0) / 9000.0) * 100), subtitle: "작년 누적 경험치 / 다음 레벨에 필요한 경험치 값이에요")
                cell.delegate = self
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    // MARK: 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 200)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 450)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 260)
        case 3:
            return CGSize(width: collectionView.frame.width, height: 250)
        default:
            return CGSize.zero
        }
    }
    
    // MARK: 섹션 헤더 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 341 + statusBarHeight) // 상태바 높이 포함
        }
        
       
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // Section 0: CustomHeaderView
            if indexPath.section == 0 {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: CustomHeaderView.identifier,
                    for: indexPath
                ) as? CustomHeaderView else {
                    fatalError("CustomHeaderView를 dequeue하지 못했습니다.")
                }
                header.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
                header.alertButton.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
                header.delegate = self
        
                header.levelTitleLabel.text = levelInfo?.displayName
                header.backgroundImageView.image = UIImage(named: levelInfo?.imageName ?? "")
                return header
            }

            // Section 1, Section 2, Section 3: 빈 헤더 처리
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "EmptyHeader",
                for: indexPath
            )
            return header
        }

        return UICollectionReusableView()
    }
    
    @objc func profileButtonTapped() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func alertButtonTapped() {
        self.navigationController?.pushViewController(AlertViewController(), animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 섹션 간 간격 조정
        if section == 2 {
            return 0 // 2번 섹션과 3번 섹션 간의 간격을 없앰
        }
        return 10 // 기본 섹션 간 간격
    }
    
    
    
}


extension HomeViewController: CustomHeaderViewDelegate {
    func didTapGuideButton() {
        let guideModalVC = RankGuideModalViewController() // 위에서 만든 모달 뷰 컨트롤러
        guideModalVC.modalPresentationStyle = .overFullScreen
        present(guideModalVC, animated: true)
    }
}
extension HomeViewController: CellExpansionDelegate {
    func didTapExpandButton(in cell: UICollectionViewCell) {
        print("tapped")
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        // 2번, 3번 섹션만 동작
        guard indexPath.section == 2 || indexPath.section == 3 else { return }
        
        // 이전에 펼쳐진 셀이 있는 경우 접기
        if let expandedIndexPath = expandedIndexPath, expandedIndexPath != indexPath {
            if let previousCell = collectionView.cellForItem(at: expandedIndexPath) {
                if let yearlyCell = previousCell as? YearlyXPSummaryCell {
                    yearlyCell.isExpanded = false
                    yearlyCell.toggleExpansion(animated: true)
                } else if let detailCell = previousCell as? DetailXPSummaryCell {
                    detailCell.isExpanded = false
                    detailCell.toggleExpansion(animated: true)
                }
            }
        }
        
        // 동일한 셀을 눌렀다면 접기
        if expandedIndexPath == indexPath {
            expandedIndexPath = nil
            collectionView.performBatchUpdates(nil, completion: nil)
            return
        }
        
        // 새로 선택된 셀 펼침
        if let currentCell = collectionView.cellForItem(at: indexPath) {
            if let yearlyCell = currentCell as? YearlyXPSummaryCell {
                yearlyCell.isExpanded = true
                yearlyCell.toggleExpansion(animated: true)
            } else if let detailCell = currentCell as? DetailXPSummaryCell {
                detailCell.isExpanded = true
                detailCell.toggleExpansion(animated: true)
            }
        }
        
        // 현재 펼쳐진 셀의 IndexPath 저장
        expandedIndexPath = indexPath
        
        // 레이아웃 업데이트
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}


// MARK: - CustomHeaderView Identifier
extension CustomHeaderView {
    static let identifier = "CustomHeaderView"
}



