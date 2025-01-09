//
//  HomeViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lv.2 자라나는 새싹"
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }

    // MARK: - Navigation Bar Setup
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 22, weight: .bold)
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .backgroundColor

        view.addSubview(headerBackgroundView)
        headerBackgroundView.addSubview(teamInfoLabel)
        headerBackgroundView.addSubview(sparkleImageView)
        headerBackgroundView.addSubview(groundImageView)
        headerBackgroundView.addSubview(sessackImageView)
        headerBackgroundView.addSubview(bubbleImageView)
        headerBackgroundView.addSubview(bubbleMessageLabel)
        
        headerBackgroundView.addSubview(experienceContainerView)
        experienceContainerView.addSubview(experienceTextLabel)
        experienceContainerView.addSubview(experienceDetailButton)
        experienceContainerView.addSubview(progressBar)

        view.addSubview(evaluationCardView)
        view.addSubview(projectCardView)
        view.addSubview(questCardView)
    }

    private func setupConstraints() {
        headerBackgroundView.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }

        teamInfoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }

        sparkleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        groundImageView.snp.makeConstraints {
            $0.top.equalTo(sparkleImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        sessackImageView.snp.makeConstraints {
            $0.top.equalTo(sparkleImageView.snp.top).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.bottom.equalTo(sessackImageView.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        bubbleMessageLabel.snp.makeConstraints {
            $0.leading.equalTo(bubbleImageView.snp.leading).inset(10)
            $0.trailing.equalTo(bubbleImageView.snp.trailing).inset(10)
            $0.centerY.equalTo(bubbleImageView.snp.centerY)
        }

        experienceContainerView.snp.makeConstraints {
            $0.bottom.equalTo(headerBackgroundView.snp.bottom).inset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(106)
        }

        experienceTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().inset(20)
        }

        experienceDetailButton.snp.makeConstraints {
            $0.centerY.equalTo(experienceTextLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
            $0.width.greaterThanOrEqualTo(60)
        }

        progressBar.snp.makeConstraints {
            $0.top.equalTo(experienceTextLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }

        evaluationCardView.snp.makeConstraints {
            $0.top.equalTo(headerBackgroundView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo((self.view.frame.width - 40) / 2 - 16)
            $0.height.equalTo(136)
        }

        projectCardView.snp.makeConstraints {
            $0.top.equalTo(headerBackgroundView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo((self.view.frame.width - 40) / 2)
            $0.height.equalTo(136)
        }

        questCardView.snp.makeConstraints {
            $0.top.equalTo(evaluationCardView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(136)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(16) // 탭바와의 간격 유지
        }
    }

    private func createCard(title: String, action: Selector) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        cardView.layer.cornerRadius = 12

        // 라벨
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        cardView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(cardView).offset(20)
            $0.top.equalTo(cardView).offset(16)
        }

        // 투명 버튼
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: action, for: .touchUpInside)
        cardView.addSubview(button)
//        button.snp.makeConstraints {
//            $0.edges.equalToSuperview() // 카드 전체를 덮도록 설정
//        }

        return cardView
    }
    
    @objc private func handleEvaluationButtonTap() {
        //let evaluationVC = EvaluationViewController()
        //navigationController?.pushViewController(evaluationVC, animated: true)
    }

    @objc private func handleProjectButtonTap() {
        let projectVC = ProjectViewController()
        navigationController?.pushViewController(projectVC, animated: true)
    }

    @objc private func handleQuestButtonTap() {
        let questVC = BoardViewController()
        navigationController?.pushViewController(questVC, animated: true)
    }

    // MARK: - Views
    private lazy var headerBackgroundView: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    private lazy var teamInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "소속: 음성 2센터 1팀"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()

    private lazy var sparkleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "샤랄라"))
        return view
    }()
    private lazy var bubbleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "bubble"))
        return view
    }()
    private lazy var bubbleMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Lv.3까지 5000XP 남았어요"
        label.textColor = .textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var sessackImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "새싹"))
        return view
    }()
    
    private lazy var groundImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ground"))
        return view
    }()

    private lazy var experienceContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 6
        return view
    }()

    private lazy var experienceTextLabel: UILabel = {
        let label = UILabel()
        label.text = "총 누적 경험치: 4000XP"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var experienceDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("자세히", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.tintColor = .lightGray
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    private lazy var progressBar: GradientProgressBar = {
        let progressBar = GradientProgressBar()
        progressBar.layer.cornerRadius = 20
        progressBar.clipsToBounds = true
        progressBar.progress = 0.4 // 40% 진행
        return progressBar
    }()

    private lazy var evaluationCardView: UIView = createCard(
        title: "인사평가",
        action: #selector(handleEvaluationButtonTap)
    )

    private lazy var projectCardView: UIView = createCard(
        title: "전사 프로젝트",
        action: #selector(handleProjectButtonTap)
    )

    private lazy var questCardView: UIView = createCard(
        title: "퀘스트",
        action: #selector(handleQuestButtonTap)
    )
}
