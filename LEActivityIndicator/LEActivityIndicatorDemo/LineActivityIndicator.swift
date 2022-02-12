//
//  LineActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 12.02.2022.
//

import Foundation
import UIKit

class LineActivityIndicator: UIView, LEActivity {
    
    // MARK: - Internal properties
    let blockAnimateDuration: CFTimeInterval = 0.6
    
    // MARK: - Private properties
    private var moveToLeftAnimation: CABasicAnimation!
    private var moveToRightAnimation: CABasicAnimation!
    private var transformAnimation: CABasicAnimation!
    private var isAnimationStarted: Bool = false
    private var timer: Timer?
    
    private var backgroundLayer = CALayer()
    private var inputLayer = CALayer()
    
    // MARK: - Init
    required init(size: LEActivitySize, colorSet: LEActivityColorSet) {
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
        backgroundColor = .clear
        
        configureLayers(size)
        setupColors(colorSet)
        moveToLeftAnimation = setupMoveToLeftAnimation()
        moveToRightAnimation = setupMoveToRightAnimation()
        transformAnimation = setupTransformAnimation()
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
        // SHOW
    }
    
    func hideActivity() {
        guard isAnimationStarted == true else { return }
        
        self.isHidden = true
        isAnimationStarted = false
        
        self.layer.removeAllAnimations()
    }
    
    // MARK: - Configuration methods
    private func configureLayers(_ size: LEActivitySize) {
        // SETUP BACKGROUND LAYER
        backgroundLayer.backgroundColor = UIColor.white.cgColor
        
        backgroundLayer.frame = CGRect(origin: .zero, size: .init(width: bounds.width,
                                                             height: bounds.height / 10))
        
        backgroundLayer.position = .init(x: bounds.midX, y: bounds.midY)
        
        backgroundLayer.cornerRadius = backgroundLayer.frame.height / 2
        
        // SETUP INPUT LAYER
        inputLayer.backgroundColor = UIColor.blue.cgColor
        inputLayer.frame = CGRect(origin: .zero,
                                  size: .init(width: backgroundLayer.bounds.width / 10,
                                                             height: backgroundLayer.bounds.height))
        
        inputLayer.position = .init(x: backgroundLayer.bounds.minX,
                                    y: backgroundLayer.bounds.midY)
        
        inputLayer.cornerRadius = inputLayer.bounds.height / 2
        
        // ADD SUBLAYERS
        layer.addSublayer(backgroundLayer)
        backgroundLayer.addSublayer(inputLayer)
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        
    }
    
    // MARK: - Animation bodies
    private func setupMoveToLeftAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    private func setupMoveToRightAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    private func setupTransformAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
}

