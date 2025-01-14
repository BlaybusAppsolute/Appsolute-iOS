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
    private let currentYearXPData = (xp: 500, percentage: 50, subtitle: "올해 획득한 경험치", details: [("상반기 인사평가", 150), ("직무별 퀘스트", 200)]) // CurrentYearXP 데이터
    
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
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 셀 등록
        collectionView.register(YearlyXPSummaryCell.self, forCellWithReuseIdentifier: YearlyXPSummaryCell.identifier)
        collectionView.register(DetailXPSummaryCell.self, forCellWithReuseIdentifier: DetailXPSummaryCell.identifier)
        collectionView.register(TotalXPCollectionViewCell.self, forCellWithReuseIdentifier: TotalXPCollectionViewCell.identifier)
        collectionView.register(CurrentYearXPCollectionViewCell.self, forCellWithReuseIdentifier: CurrentYearXPCollectionViewCell.identifier)
        
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
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // 모든 섹션은 1개의 셀
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalXPCollectionViewCell.identifier, for: indexPath) as? TotalXPCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(xp: totalXPData.xp, subtitle: totalXPData.subtitle)
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentYearXPCollectionViewCell.identifier, for: indexPath) as? CurrentYearXPCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(xp: currentYearXPData.xp, percentage: currentYearXPData.percentage, subtitle: currentYearXPData.subtitle, details: currentYearXPData.details)
                return cell
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YearlyXPSummaryCell.identifier, for: indexPath) as? YearlyXPSummaryCell else {
                    return UICollectionViewCell()
                }

                cell.configure(title: "연도별 획득 내역", data: [("2025년", 500), ("2024년", 400), ("2023년", 350)], isExpanded: false)
                return cell
            case 3:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailXPSummaryCell.identifier, for: indexPath) as? DetailXPSummaryCell else {
                    return UICollectionViewCell()
                }
                cell.configure(title: "전년도 상세 내역", data: [("작업 평가", 100), ("팀워크", 200), ("리더십", 150)], isExpanded: false)
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
        case 2, 3:
            return CGSize(width: collectionView.frame.width, height: 100) // 기본 높이
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
        
        if section == 1 {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 50)
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

}


extension HomeViewController: CustomHeaderViewDelegate {
    func didTapGuideButton() {
        let guideModalVC = RankGuideModalViewController() // 위에서 만든 모달 뷰 컨트롤러
        guideModalVC.modalPresentationStyle = .overFullScreen
        present(guideModalVC, animated: true)
    }
}


// MARK: - CustomHeaderView Identifier
extension CustomHeaderView {
    static let identifier = "CustomHeaderView"
}



