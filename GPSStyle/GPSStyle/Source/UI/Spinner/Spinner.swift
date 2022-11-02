//
//  Spinner.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 31.10.2022.
//

import UIKit

final class Spinner: UIView {
    private lazy var replicatorLayer = CAReplicatorLayer()
    private lazy var shapeLayer: CAShapeLayer = CAShapeLayer()
    private let keyAnimation = "opacityAnimation"
    private var squareLength: CGFloat
    
    init(squareLength: CGFloat) {
        self.squareLength = squareLength
        super.init(frame: .zero)
        layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(shapeLayer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        pin.center().size(squareLength)
        let size = min(bounds.width/2, bounds.height/2)
        let rect = CGRect(x: size/4, y: size/4, width: size/4, height: size/4)
        let path = UIBezierPath(ovalIn: rect)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = ColorName.mainPurple.color.cgColor
        replicatorLayer.frame = bounds
        replicatorLayer.position = CGPoint(x: size, y: size)
    }

    func startAnimation() {
        let delay = 0.01
        let replicates: Int = 120
        replicatorLayer.instanceCount = replicates
        replicatorLayer.instanceDelay = delay
        let angle = CGFloat(2.0 * Double.pi) / CGFloat(replicates)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)

        shapeLayer.opacity = 0
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.0
        opacityAnimation.toValue = 0.7

        opacityAnimation.duration = Double(replicates) * delay
        opacityAnimation.repeatCount = Float.infinity
        opacityAnimation.speed = 2
        shapeLayer.add(opacityAnimation, forKey: keyAnimation)
    }

    func stopAnimation() {
        guard shapeLayer.animation(forKey: keyAnimation) != nil else {
            return
        }
        shapeLayer.removeAnimation(forKey: keyAnimation)
    }

    deinit {
        stopAnimation()
    }
}
