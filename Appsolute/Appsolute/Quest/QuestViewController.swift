//
//  QuestViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//


import UIKit
import SnapKit

class QuestViewController: UIViewController {

    // MARK: - Properties
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
    private func presentBottomSheet(title: String) {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.sheetPresentationController?.prefersGrabberVisible = false
        bottomSheetVC.modalPresentationStyle = .automatic
        bottomSheetVC.sheetPresentationController?.detents = [.large(), .medium()] // Bottom Sheet 높이 설정
        bottomSheetVC.sheetPresentationController?.prefersGrabberVisible = true // Grabber 표시
        bottomSheetVC.sheetPresentationController?.preferredCornerRadius = 16
        //bottomSheetVC.configure(with: title) // 타이틀 설정
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

        let stateImage: UIImage?
        if indexPath.section == 1 {
            stateImage = UIImage(named: "mid")
            cell.configure(
                badgeText: "월 퀘스트",
                title: "월간 퀘스트 \(indexPath.row + 1)",
                subtitle: "월 퀘스트 설명 \(indexPath.row + 1)",
                stateImage: stateImage,
                badgeColor: .systemBlue,
                xpText: "50 XP",
                buttonAction: { [weak self] in
                    self?.presentBottomSheet(title: "월간 퀘스트 \(indexPath.row + 1)")
                }
            )
        } else {
            let images = ["min", "mid", "max"]
            stateImage = UIImage(named: images[indexPath.row % 3])
            cell.configure(
                badgeText: "주차별 퀘스트",
                title: "주차 퀘스트 \(indexPath.row + 1)",
                subtitle: "주차 퀘스트 설명 \(indexPath.row + 1)",
                stateImage: stateImage,
                badgeColor: .systemGreen,
                xpText: "100 XP",
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
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
                header.configure(
                    date: "2025.01",
                    weeks: [
                        ("1 주차", ""),
                        ("2 주차", ""),
                        ("3 주차", "01.01 - 08"),
                        ("4 주차", ""),
                        ("5 주차", "")
                    ],
                    selectedWeek: 3,
                    onLeftButtonTap: { print("이전 달로 이동") },
                    onRightButtonTap: { print("다음 달로 이동") },
                    onWeekChanged: { selectedWeek in
                        print("선택된 주차: \(selectedWeek)")
                    }
                )
                return header
            } else {
                // 섹션별 헤더
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
