//
//  BoubleActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 12.02.2022.
//

import Foundation
import UIKit

class BoubleActivityIndicator: UIView, LEActivity {
    
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
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
        backgroundColor = .clear
        
        configureLayers(size)
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
        
        timer = Timer.scheduledTimer(withTimeInterval: blockAnimateDuration * 2, repeats: true) { _ in
           
        }
    }
    
    func hideActivity() {
        guard isAnimationStarted == true else { return }
        
        self.isHidden = true
        isAnimationStarted = false
        
        self.layer.removeAllAnimations()
    }
    
    // MARK: - Configuration methods
    private func configureLayers(_ size: LEActivitySize) {
        
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        
    }
    
    // MARK: - Animation bodies
    private func setupTransformInAnimation() -> CABasicAnimation {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.duration = blockAnimateDuration
//        animation.fromValue = bounds.maxX
//        animation.toValue = bounds.minX
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    private func setupTransformOutAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = blockAnimateDuration
//        animation.fromValue = bounds.minX
//        animation.toValue = bounds.maxX
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
}
