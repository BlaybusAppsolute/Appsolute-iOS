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

    // 현재 선택된 주차를 저장 (초기값은 1로 설정)
    private var currentWeek: Int = 1

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = false
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.register(Section1HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Section1HeaderView.identifier)
        collectionView.register(Section2HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Section2HeaderView.identifier)
        collectionView.register(LeaderQuestCardCell.self, forCellWithReuseIdentifier: LeaderQuestCardCell.identifier)
        collectionView.register(QuestCardCell.self, forCellWithReuseIdentifier: QuestCardCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.headerColor
        setupViews()
        setupConstraints()
        bindViewModel()

        viewModel.updateWeeks(for: Date())
        print("📅 [DEBUG] 초기 주차 설정: \(currentWeek)주차")
        updateQuestData(forWeek: currentWeek)
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

//    private func bindViewModel() {
//        viewModel.onUpdate = { [weak self] in
//            guard let self = self else { return }
//            if self.currentWeek != self.viewModel.selectedWeek { // 중복 호출 방지
//                self.currentWeek = self.viewModel.selectedWeek
//                self.updateQuestData(forWeek: self.currentWeek)
//            }
//        }
//
//        questViewModel.onLeaderBoardFetched = { [weak self] in
//            self?.collectionView.reloadData()
//        }
//
//        questViewModel.onWeeklyQuestsUpdated = { [weak self] in
//            self?.collectionView.reloadData()
//        }
//
//        questViewModel.onError = { errorMessage in
//            print("❌ 데이터 가져오기 실패: \(errorMessage)")
//        }
//    }
    private func bindViewModel() {
        // viewModel.onUpdate 콜백 제거 (주차 변경 시 API 중복 호출 방지)
        
        questViewModel.onLeaderBoardFetched = { [weak self] in
            self?.collectionView.reloadData()
        }

        questViewModel.onWeeklyQuestsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }

        questViewModel.onError = { errorMessage in
            print("❌ 데이터 가져오기 실패: \(errorMessage)")
        }
    }
    private var isLoading = false
    private func updateQuestData(forWeek selectedWeek: Int) {
        // 로딩 중이면 호출을 스킵
        guard !isLoading else {
            print("🔍 [DEBUG] 현재 로딩 중입니다. API 호출 스킵.")
            return
        }

        // API 호출 시작
        isLoading = true

        // 주차 업데이트 (동일 주차여도 호출 가능)
        currentWeek = selectedWeek

        // 주차 시작 날짜 계산
        guard let startDate = viewModel.getStartDate(for: selectedWeek) else {
            print("❌ [DEBUG] 주차 시작일 계산 실패")
            isLoading = false
            return
        }

        // 주차 데이터를 요청
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let startDateString = formatter.string(from: startDate)

        // 1. 주차 퀘스트 데이터 요청
        questViewModel.fetchWeeklyQuests(startDate: startDateString)

        // 2. 리더보드 데이터 요청
        let month = Calendar.current.component(.month, from: startDate)
        let userId = UserManager.shared.getUser()?.userId ?? ""
        questViewModel.fetchLeaderBoard(userId: userId, month: month)

        // 로딩 완료 처리
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isLoading = false // API 호출이 완료되면 플래그 해제
            print("✅ [DEBUG] API 호출 완료. isLoading 해제.")
        }
    }
    



    private func presentBottomSheet(title: String, id: Int, status: String) {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.sheetPresentationController?.prefersGrabberVisible = true
        bottomSheetVC.modalPresentationStyle = .automatic
        bottomSheetVC.sheetPresentationController?.detents = [.medium(), .large()]
        
        // ID 전달
        bottomSheetVC.questId = id
        bottomSheetVC.headerTitle = title
        bottomSheetVC.status = status
        present(bottomSheetVC, animated: true)
    }
    private func presentLeaderSheet(board: LeaderBoardResponse) {
        let bottomSheetVC = LeaderBottomSheetViewController()
        bottomSheetVC.sheetPresentationController?.prefersGrabberVisible = true
        bottomSheetVC.modalPresentationStyle = .automatic
        bottomSheetVC.sheetPresentationController?.detents = [.medium(), .large()]
        bottomSheetVC.board = board
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
        case 1:
            return questViewModel.leaderBoardResponses.count
        case 2:
            return questViewModel.weeklyQuests.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            // 섹션 1: LeaderQuestCardCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeaderQuestCardCell.identifier, for: indexPath) as! LeaderQuestCardCell
            let leaderboard = questViewModel.leaderBoardResponses[indexPath.row]
            cell.configure(
                questType: "리더부여",
                status: leaderboard.questStatus,
                title: leaderboard.questName,
                expImage: "leader-board-card",
                point: leaderboard.grantedPoint,
                buttonAction: { [weak self] in
                    self?.presentLeaderSheet(board: leaderboard)
                }
            )
            return cell
            
        case 2:
            // 섹션 2: QuestCardCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestCardCell.identifier, for: indexPath) as! QuestCardCell
            let questName = "\(UserManager.shared.getUser()?.departmentName ?? "") \(UserManager.shared.getUser()?.departmentGroupName ?? "") 퀘스트"
            let weeklyQuest = questViewModel.weeklyQuests[indexPath.row]
            cell.configure(
                questType: "직무",
                status: weeklyQuest.departmentGroupQuestStatus ?? "READY",
                title: questName,
                expImage: "weekly-card",
                point: weeklyQuest.nowXP,
                buttonAction: { [weak self] in
                    self?.presentBottomSheet(title: questName, id: weeklyQuest.departmentGroupQuestId, status: weeklyQuest.departmentGroupQuestStatus ?? "READY")
                }
            )
            return cell
            
        default:
            fatalError("Unexpected section: \(indexPath.section)")
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 216)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0: return CGSize(width: collectionView.frame.width, height: 160)
        case 1, 2: return CGSize(width: collectionView.frame.width, height: 50)
        default: return .zero
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40 // 섹션 간 간격
    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            if indexPath.section == 0 {
//                let header = collectionView.dequeueReusableSupplementaryView(
//                    ofKind: kind,
//                    withReuseIdentifier: HeaderView.identifier,
//                    for: indexPath
//                ) as! HeaderView
//
//                header.configure(
//                    date: viewModel.getCurrentDateString(),
//                    weeks: viewModel.weeks,
//                    selectedWeek: viewModel.selectedWeek,
//                    onLeftButtonTap: { [weak self] in
//                        self?.viewModel.moveMonth(by: -1)
//                        self?.updateQuestData(forWeek: self?.viewModel.selectedWeek ?? 1)
//                    },
//                    onRightButtonTap: { [weak self] in
//                        self?.viewModel.moveMonth(by: 1)
//                        self?.updateQuestData(forWeek: self?.viewModel.selectedWeek ?? 1)
//                    },
//                    onWeekChanged: { [weak self] selectedWeek in
//                        self?.viewModel.selectWeek(selectedWeek)
//                        self?.updateQuestData(forWeek: selectedWeek)
//                    }
//                )
//                return header
//            } else {
//                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
//                let titleLabel = UILabel()
//                titleLabel.text = indexPath.section == 1 ? "리더보드" : "직무 퀘스트"
//                titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
//                sectionHeader.addSubview(titleLabel)
//                titleLabel.snp.makeConstraints { $0.leading.equalToSuperview().offset(16); $0.centerY.equalToSuperview() }
//                return sectionHeader
//            }
//        }
//        return UICollectionReusableView()
//    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderView.identifier,
                    for: indexPath
                ) as! HeaderView
                header.configure(
                    date: viewModel.getCurrentDateString(),
                    weeks: viewModel.weeks,
                    selectedWeek: viewModel.selectedWeek,
                    onLeftButtonTap: { [weak self] in
                        self?.viewModel.moveMonth(by: -1)
                        self?.updateQuestData(forWeek: self?.viewModel.selectedWeek ?? 1)
                    },
                    onRightButtonTap: { [weak self] in
                        self?.viewModel.moveMonth(by: 1)
                        self?.updateQuestData(forWeek: self?.viewModel.selectedWeek ?? 1)
                    },
                    onWeekChanged: { [weak self] selectedWeek in
                        self?.viewModel.selectWeek(selectedWeek)
                        self?.updateQuestData(forWeek: selectedWeek)
                    }
                )
                return header
            case 1:
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: Section1HeaderView.identifier,
                    for: indexPath
                ) as! Section1HeaderView
                sectionHeader.configure(title: "리더 퀘스트")
                return sectionHeader
            case 2:
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: Section2HeaderView.identifier,
                    for: indexPath
                ) as! Section2HeaderView
                sectionHeader.configure(title: "직무 퀘스트")
                return sectionHeader
            default:
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
    }

}
class Section1HeaderView: UICollectionReusableView {
    static let identifier = "Section1HeaderView"

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }

    func configure(title: String) {
        titleLabel.text = title
        titleLabel.textColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class Section2HeaderView: UICollectionReusableView {
    static let identifier = "Section2HeaderView"

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    

    func configure(title: String) {
        titleLabel.text = title
        titleLabel.textColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
