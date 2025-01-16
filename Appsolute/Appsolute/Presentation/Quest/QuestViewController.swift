//
//  QuestViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//

import UIKit
import SnapKit

class QuestViewController: UIViewController {
    
    private let viewModel = WeekViewModel()
    private let questViewModel = QuestViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = false
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView.register(QuestCardCell.self, forCellWithReuseIdentifier: QuestCardCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.headerColor
        setupViews()
        setupConstraints()
        bindViewModel()
        fetchQuestData()
    }

    private func setupViews() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }

    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        // QuestViewModel의 성공 및 실패 콜백 설정
        questViewModel.onSuccess = { response in
            print("✅ 성공적으로 데이터 가져옴: \(response)")
        }
        questViewModel.onError = { errorMessage in
            print("❌ 데이터 가져오기 실패: \(errorMessage)")
        }
    }
    
//    private func fetchQuestData() {
//        let currentDateString = viewModel.getCurrentDateString() // "yyyy.MM" 형식
//        questViewModel.fetchDepartmentQuest(date: currentDateString)
//    }
    private func fetchQuestData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // "yyyy.MM.dd" 형식
        let currentDateString = formatter.string(from: viewModel.currentDate) // 현재 날짜를 가져옴
        print("=======\(AppKey.token)")
        print("📅 [DEBUG] 요청할 날짜: \(currentDateString)")

        questViewModel.fetchDepartmentQuest(date: currentDateString)
    }
    
    

    private func presentBottomSheet(title: String) {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.sheetPresentationController?.prefersGrabberVisible = true
        bottomSheetVC.modalPresentationStyle = .automatic
        bottomSheetVC.sheetPresentationController?.detents = [.medium(), .large()]
        present(bottomSheetVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension QuestViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 1
        default:
            return 5
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestCardCell.identifier, for: indexPath) as! QuestCardCell

        if indexPath.section == 1 {
            cell.configure(
                title: "월간 퀘스트 \(indexPath.row + 1)",
                expImage: "mid-card",
                buttonAction: { [weak self] in
                    self?.presentBottomSheet(title: "월간 퀘스트 \(indexPath.row + 1)")
                }
            )
        } else {
            let images = ["min-card", "mid-card", "max-card"]
            cell.configure(
                title: "주차 퀘스트 \(indexPath.row + 1)",
                expImage: images[indexPath.row % 3],
                buttonAction: { [weak self] in
                    self?.presentBottomSheet(title: "주차별 퀘스트 \(indexPath.row + 1)")
                }
            )
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 216)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 160)
        } else {
            return CGSize(width: collectionView.frame.width, height: 40)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderView.identifier,
                    for: indexPath
                ) as! HeaderView
                
                header.configure(
                    date: viewModel.getCurrentDateString(),
                    weeks: viewModel.weeks,
                    selectedWeek: viewModel.currentWeek,
                    onLeftButtonTap: { [weak self] in
                        self?.viewModel.moveMonth(by: -1)
                    },
                    onRightButtonTap: { [weak self] in
                        self?.viewModel.moveMonth(by: 1)
                    },
                    onWeekChanged: { selectedWeek in
                        print("선택된 주차: \(selectedWeek)")
                    }
                )
                return header
            } else {
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
                sectionHeader.backgroundColor = .clear

                let titleLabel = UILabel()
                titleLabel.text = indexPath.section == 1 ? "월 퀘스트" : "주차별 퀘스트"
                titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
                titleLabel.textColor = .black
                sectionHeader.addSubview(titleLabel)

                titleLabel.snp.makeConstraints { make in
                    make.leading.equalToSuperview().offset(16)
                    make.centerY.equalToSuperview()
                }

                return sectionHeader
            }
        }
        return UICollectionReusableView()
    }
}
