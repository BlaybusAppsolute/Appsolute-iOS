//
//  GradientProgressBar.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//

import UIKit

class GradientProgressBar: UIView {

    private let gradientLayer = CAGradientLayer()
    private let progressLayer = CALayer()

    var progress: CGFloat = 0.0 {
        didSet {
            updateProgress()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
       
        gradientLayer.colors = [
            UIColor(red: 1.0, green: 0.8, blue: 0.2, alpha: 1.0).cgColor,
            UIColor(red: 1.0, green: 0.4, blue: 0.0, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = 20
        self.layer.addSublayer(gradientLayer)

        
        gradientLayer.mask = progressLayer
        progressLayer.backgroundColor = UIColor.white.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        self.backgroundColor = .gray400
        updateProgress()
    }

    private func updateProgress() {
        let progressWidth = bounds.width * progress
        progressLayer.frame = CGRect(x: 0, y: 0, width: progressWidth, height: bounds.height)
    }
}
