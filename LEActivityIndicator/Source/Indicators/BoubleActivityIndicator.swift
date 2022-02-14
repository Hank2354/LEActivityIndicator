//
//  BoubleActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 12.02.2022.
//

import Foundation
import UIKit

class BoubleActivityIndicator: UIView, LEActivity {
    
    // MARK: - Information
    var style: LEActivityStyle = .bouble
    var size: LEActivitySize
    
    // MARK: - Internal properties
    let blockAnimateDuration: CFTimeInterval = 0.3
    
    // MARK: - Private properties
    private var transformInAnimation: CABasicAnimation!
    private var transformOutAnimation: CABasicAnimation!
    private var isAnimationStarted: Bool = false
    private var timer: Timer?
    
    private var boubleLayer = CALayer()
    
    // MARK: - Init
    required init(size: LEActivitySize, colorSet: LEActivityColorSet) {
        self.size = size
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
        backgroundColor = .clear
        
        configureLayers()
        setupColors(colorSet)
        transformInAnimation = setupTransformInAnimation()
        transformOutAnimation = setupTransformOutAnimation()
        
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
        boubleLayer.add(transformInAnimation, forKey: nil)
        transformOutAnimation.beginTime = CACurrentMediaTime() + blockAnimateDuration
        boubleLayer.add(transformOutAnimation, forKey: nil)
        timer = Timer.scheduledTimer(withTimeInterval: blockAnimateDuration * 2, repeats: true) { _ in
            self.boubleLayer.add(self.transformInAnimation, forKey: nil)
            self.transformOutAnimation.beginTime = CACurrentMediaTime() + self.blockAnimateDuration
            self.boubleLayer.add(self.transformOutAnimation, forKey: nil)
        }
    }
    
    func hideActivity() {
        guard isAnimationStarted == true else { return }
        
        self.isHidden = true
        isAnimationStarted = false
        
        timer?.invalidate()
        timer = nil
        self.boubleLayer.removeAllAnimations()
    }
    
    // MARK: - Configuration methods
    private func configureLayers() {
        boubleLayer.frame = .init(origin: center, size: bounds.size)
        boubleLayer.position = center
        boubleLayer.cornerRadius = bounds.width / 2
        layer.addSublayer(boubleLayer)
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        boubleLayer.backgroundColor = colorSet.mainColor.cgColor
    }
    
    // MARK: - Animation bodies
    private func setupTransformInAnimation() -> CABasicAnimation {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.duration = blockAnimateDuration
        animation.fromValue = 1
        animation.toValue = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    private func setupTransformOutAnimation() -> CABasicAnimation {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.duration = blockAnimateDuration
        animation.fromValue = 0.3
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
}
