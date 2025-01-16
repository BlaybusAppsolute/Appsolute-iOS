//
//  BoardViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//

import UIKit
import SnapKit


class BoardHeaderReusableView: UICollectionReusableView {
    
    static let identifier = "BoardHeaderReusableView"
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.textColor = UIColor.black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
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


class BoardViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = BoardViewModel() // ViewModel 초기화
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "게시판"
        setupBackgroundGradient()
        setupCustomBackButton()
        setupCollectionView()
        setupConstraints()
        fetchBoards() 
    }
    
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
        
        // 셀과 헤더 등록
        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.identifier)
        collectionView.register(BoardHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BoardHeaderReusableView.identifier)
        
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func fetchBoards() {
        viewModel.fetchBoards(
            onSuccess: { [weak self] in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData() // 데이터 갱신 후 CollectionView 업데이트
                }
            },
            onFailure: { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.showErrorAlert(message: errorMessage)
                }
            }
        )
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - UI
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 157)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 44) // 헤더 크기 지정
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
}

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.boards.count // ViewModel의 boards 개수를 반환
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.identifier, for: indexPath) as? BoardCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = viewModel.boards[indexPath.item] // ViewModel에서 데이터 가져오기
        cell.configure(with: item)
        return cell
    }
    
    // MARK: - 섹션 헤더 구성
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: BoardHeaderReusableView.identifier,
                for: indexPath
            ) as? BoardHeaderReusableView else {
                return UICollectionReusableView()
            }
            
            // 섹션 제목 설정
            header.configure(title: "공지사항")
            return header
        }
        return UICollectionReusableView()
    }
}
