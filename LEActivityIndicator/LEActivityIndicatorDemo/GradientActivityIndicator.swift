//
//  GradientActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 06.02.2022.
//

import Foundation
import UIKit

class GradientActivityIndicator: UIView, LEActivity {
    
    // MARK: - Internal properties
    let blockAnimateDuration: CFTimeInterval = 0.5
    
    // MARK: - Private properties
    private var rotateAnimation: CABasicAnimation!
    private var isAnimationStarted: Bool = false
    
    private var lineWidth: CGFloat!
    private var startColor: UIColor!
    private var endColor: UIColor!
    
    // MARK: - Init
    required init(size: LEActivitySize, colorSet: LEActivityColorSet) {
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
        backgroundColor = .clear
        
        configureLayers(size)
        setupColors(colorSet)
        rotateAnimation = setupRotateAnimation()
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal methods
    func showActivity() {
        guard isAnimationStarted == false else { return }
        
        self.isHidden = false
        isAnimationStarted = true
        
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func hideActivity() {
        guard isAnimationStarted == true else { return }
        
        self.isHidden = true
        isAnimationStarted = false
        
        self.layer.removeAllAnimations()
    }
    
    // MARK: - Configuration methods
    private func configureLayers(_ size: LEActivitySize) {
        lineWidth = self.frame.size.width / 10
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        startColor = colorSet.mainColor
        endColor = colorSet.secondMainColor
    }

    override func draw(_ rect: CGRect) {
        
        let circularRect: CGRect = .init(origin: .zero,
                                         size: .init(width: self.frame.size.width - lineWidth,
                                                     height: self.frame.size.height - lineWidth))

        var currentAngle: CGFloat = 0.0

        for i in stride(from:CGFloat(0.0), through: CGFloat(1.0), by: CGFloat(0.005)) {

            let arcPoint: CGPoint = CGPoint(x: rect.width/2, y: rect.height/2)
            let arcRadius: CGFloat = circularRect.width/2
            let arcStartAngle: CGFloat = -CGFloat.pi/2
            let arcEndAngle: CGFloat = i * 2.0 * CGFloat.pi - CGFloat.pi/2

            if currentAngle == 0.0 {
                currentAngle = arcStartAngle
            } else {
                currentAngle = arcEndAngle - 0.05
            }

            let arc: UIBezierPath = UIBezierPath(arcCenter: arcPoint,
                                                 radius: arcRadius,
                                                 startAngle: currentAngle,
                                                 endAngle: arcEndAngle,
                                                 clockwise: true)

            let strokeColor: UIColor = getGradientPointColor(ratio: i, startColor: startColor, endColor: endColor)
            strokeColor.setStroke()

            arc.lineWidth = lineWidth
            arc.lineCapStyle = CGLineCap.butt
            arc.stroke()
        }
    }
    
    private func getGradientPointColor(ratio: CGFloat, startColor: UIColor, endColor: UIColor) -> UIColor {
        
        let sColor = toRGBA(color: startColor)
        let eColor = toRGBA(color: endColor)
        
        let r = (sColor.r - eColor.r) * ratio + eColor.r
        let g = (sColor.g - eColor.g) * ratio + eColor.g
        let b = (sColor.b - eColor.b) * ratio + eColor.b
        let a = (sColor.a - eColor.a) * ratio + eColor.a
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    private func toRGBA(color: UIColor) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (r, g, b, a)
    }
    
    // MARK: - Animation bodies
    private func setupRotateAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = Double.pi * 2
        animation.duration = blockAnimateDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.repeatCount = HUGE
        return animation
    }
}

