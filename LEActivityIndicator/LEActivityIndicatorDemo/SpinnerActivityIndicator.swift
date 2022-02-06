//
//  SpinnerActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 06.02.2022.
//

import Foundation
import UIKit

class SpinnerActivityIndicator: UIView, LEActivity {
    
    // MARK: - Internal properties
    let blockAnimateDuration: CFTimeInterval = 0.5
    
    // MARK: - Private properties
    private var mainCircleShapeLayer = CAShapeLayer()
    private var secondCircleShapeLayer = CAShapeLayer()
    private var rotateAnimation: CABasicAnimation!
    private var isAnimationStarted: Bool = false
    
    // MARK: - Init
    required init(size: LEActivitySize, colorSet: LEActivityColorSet) {
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
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
        let mainCirclePath = UIBezierPath(arcCenter: self.center, radius: self.frame.size.width / 2, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        mainCircleShapeLayer.path = mainCirclePath.cgPath
        mainCircleShapeLayer.fillColor = UIColor.clear.cgColor
        mainCircleShapeLayer.lineWidth = self.frame.size.width / 15
        
        let secondCirclePath = UIBezierPath(arcCenter: self.center, radius: self.frame.size.width / 2, startAngle: CGFloat(Double.pi * 3 / 2), endAngle: CGFloat(0), clockwise: true)
        secondCircleShapeLayer.path = secondCirclePath.cgPath
        secondCircleShapeLayer.fillColor = UIColor.clear.cgColor
        secondCircleShapeLayer.lineWidth = self.frame.size.width / 15
        
        self.layer.addSublayer(mainCircleShapeLayer)
        self.layer.addSublayer(secondCircleShapeLayer)
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        mainCircleShapeLayer.strokeColor = colorSet.mainColor.cgColor
        secondCircleShapeLayer.strokeColor = colorSet.secondMainColor.cgColor
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
