//
//  DefaultActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 13.02.2022.
//

import Foundation
import UIKit

class DefaultActivityIndicator: UIView, LEActivity {
    
    // MARK: - Internal properties
    let blockAnimateDuration: CFTimeInterval = 1
    
    // MARK: - Private properties
    private var strokeRotateAnimation: CAAnimationGroup!
    private var isAnimationStarted: Bool = false
    
    private var circleLayer = CAShapeLayer()
    
    // MARK: - Init
    required init(size: LEActivitySize, colorSet: LEActivityColorSet) {
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
        backgroundColor = .clear
        
        configureLayers()
        setupColors(colorSet)
        strokeRotateAnimation = setupStrokeRotateAnimation()
        
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
        circleLayer.add(strokeRotateAnimation, forKey: nil)
    }
    
    func hideActivity() {
        guard isAnimationStarted == true else { return }
        
        self.isHidden = true
        isAnimationStarted = false
        
        circleLayer.removeAllAnimations()
    }
    
    // MARK: - Configuration methods
    private func configureLayers() {
        let path = UIBezierPath(arcCenter: self.center, radius: self.frame.size.width / 2, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = self.frame.size.width / 15
        circleLayer.frame = .init(origin: .zero,
                                  size: .init(width: bounds.width, height: bounds.height))
        circleLayer.lineCap = .round
        layer.addSublayer(circleLayer)
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        circleLayer.strokeColor = colorSet.mainColor.cgColor
    }
    
    // MARK: - Animation bodies
    private func setupStrokeRotateAnimation() -> CAAnimationGroup {
        let beginTime: Double = 0.5
        let strokeStartDuration: Double = 1.2
        let strokeEndDuration: Double = 0.7
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.byValue = Float.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
        groupAnim.duration = strokeStartDuration + beginTime
        groupAnim.repeatCount = .infinity
        groupAnim.isRemovedOnCompletion = false
        groupAnim.fillMode = .forwards
        
        return groupAnim
    }
}
