//
//  BoardViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//

import UIKit
import SnapKit

class BoardViewController: UIViewController {

    private let data: [BoardItem] = [
        BoardItem(boardId: 1, title: "상반기 인사발령 안내", content: "2025년 상반기 정기 인사발령 안내", createdAt: "2025.01.04"),
        BoardItem(boardId: 2, title: "복리후생 공지", content: "동호회 운영 지침 및 지원금 신청 방법 안내", createdAt: "2025.01.04"),
        BoardItem(boardId: 3, title: "사내 시스템 임시 점검 안내", content: "1월 20일(토) 02:00-06:00 시스템 점검", createdAt: "2024.12.18")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundGradient()
        setupNavigationBarGradient()
        setupCustomBackButton()
        setupCollectionView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackgroundGradient()
        setupNavigationBarGradient()
    }

    // 화면 전체 배경에 그라데이션 설정
    private func setupBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#B5D4FC").cgColor,
            UIColor(hex: "#E7F1FE").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // 네비게이션 바에 그라데이션 설정
    private func setupNavigationBarGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#B5D4FC").cgColor,
            UIColor(hex: "#E7F1FE").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 88) // 네비게이션 바 높이
        
        if let gradientImage = gradientLayer.toImage() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundImage = gradientImage
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }

    private func setupCustomBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.backward"), transitionMaskImage: UIImage(systemName: "chevron.backward"))
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    //MARK: UI
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 157)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
}

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.identifier, for: indexPath) as? BoardCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = data[indexPath.item]
        cell.configure(with: item)
        return cell
    }
}

// CAGradientLayer를 UIImage로 변환하는 extension
extension CAGradientLayer {
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContext(bounds.size)
        defer { UIGraphicsEndImageContext() }
        render(in: UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}



//class BoardViewController: UIViewController {
//    
//    // MARK: - Properties
//    private let viewModel = BoardViewModel() // ViewModel 초기화
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupBackgroundGradient()
//        setupCustomBackButton()
//        setupCollectionView()
//        setupConstraints()
//        fetchBoards() // 네트워크 요청
//    }
//    
//    private func setupBackgroundGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor(hex: "#B5D4FC").cgColor,
//            UIColor(hex: "#E7F1FE").cgColor
//        ]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//        gradientLayer.frame = view.bounds
//        view.layer.insertSublayer(gradientLayer, at: 0)
//    }
//    
//    private func setupCustomBackButton() {
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backButton
//        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.backward"), transitionMaskImage: UIImage(systemName: "chevron.backward"))
//        appearance.backButtonAppearance.normal.titleTextAttributes = [
//            .foregroundColor: UIColor.clear
//        ]
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//    }
//    
//    private func setupCollectionView() {
//        collectionView.backgroundColor = .clear
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.identifier)
//        view.addSubview(collectionView)
//    }
//    
//    private func setupConstraints() {
//        collectionView.snp.makeConstraints {
//            $0.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    
//    private func fetchBoards() {
//        viewModel.fetchBoards(
//            onSuccess: { [weak self] in
//                DispatchQueue.main.async {
//                    self?.collectionView.reloadData() // 데이터 갱신 후 CollectionView 업데이트
//                }
//            },
//            onFailure: { [weak self] errorMessage in
//                DispatchQueue.main.async {
//                    self?.showErrorAlert(message: errorMessage)
//                }
//            }
//        )
//    }
//    
//    private func showErrorAlert(message: String) {
//        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default))
//        present(alert, animated: true)
//    }
//    
//    // MARK: - UI
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 16
//        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 157)
//        return UICollectionView(frame: .zero, collectionViewLayout: layout)
//    }()
//}
//
//extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.boards.count // ViewModel의 boards 개수를 반환
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.identifier, for: indexPath) as? BoardCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        let item = viewModel.boards[indexPath.item] // ViewModel에서 데이터 가져오기
//        cell.configure(with: item)
//        return cell
//    }
//}
//
