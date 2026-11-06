//
//  RingView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

class RingView: UIView {

    private let lineWidth: CGFloat = 6

    private lazy var trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.line.cgColor
        layer.lineWidth = lineWidth
        return layer
    }()

    private lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.gold.cgColor
        layer.lineWidth = lineWidth
        layer.strokeEnd = 0
        return layer
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .green1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }

    private func configureConstraints() {
        addSubview(valueLabel)

        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: -CGFloat.pi / 2,
                                endAngle: CGFloat.pi * 3 / 2,
                                clockwise: true)

        trackLayer.path = path.cgPath
        progressLayer.path = path.cgPath
    }

    func configure(minutes: Int, progress: Double) {
        valueLabel.text = "\(minutes)"
        progressLayer.strokeEnd = CGFloat(progress)
    }
}
