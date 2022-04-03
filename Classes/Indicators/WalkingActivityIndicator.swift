//
//  WalkingActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 05.02.2022.
//

import Foundation
import UIKit

class WalkingActivityIndicator: UIView, LEActivity {
    
    // MARK: - Information
    var style: LEActivityStyle = .walking
    var size: LEActivitySize
    
    // MARK: - Internal properties
    let blockAnimateDuration: CFTimeInterval = 0.15
    
    // MARK: - Private properties
    private let firstLine = CALayer()
    private let secondLine = CALayer()
    private let thirdLine = CALayer()
    private var timer: Timer?
    private var isAnimationStarted: Bool = false
    
    // MARK: - Init
    required init(size: LEActivitySize, colorSet: LEActivityColorSet) {
        self.size = size
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
        configureLayers()
        setupColors(colorSet)
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
        
        self.animationBlockOne(delay: CACurrentMediaTime())
        self.animationBlockTwo(delay: CACurrentMediaTime() + self.blockAnimateDuration)
        self.animationBlockThree(delay: CACurrentMediaTime() + self.blockAnimateDuration * 2)
        timer = Timer.scheduledTimer(withTimeInterval: blockAnimateDuration * 3, repeats: true) { _ in
            self.animationBlockOne(delay: CACurrentMediaTime())
            self.animationBlockTwo(delay: CACurrentMediaTime() + self.blockAnimateDuration)
            self.animationBlockThree(delay: CACurrentMediaTime() + self.blockAnimateDuration * 2)
        }
    }
    
    func hideActivity() {
        guard isAnimationStarted == true else { return }
        
        self.isHidden = true
        isAnimationStarted = false
        
        timer?.invalidate()
        timer = nil
        firstLine.removeAllAnimations()
        secondLine.removeAllAnimations()
        thirdLine.removeAllAnimations()
    }
    
    // MARK: - Configuration methods
    private func configureLayers() {
        firstLine.frame = CGRect(origin: .zero,
                                 size: .init(width: self.frame.width * 0.2, height: self.frame.height * 0.64))
        firstLine.position.y = self.frame.midY
        firstLine.cornerRadius = firstLine.frame.width / 2
        self.layer.addSublayer(firstLine)
        
        secondLine.frame = CGRect(origin: .zero,
                                  size: .init(width: self.frame.width * 0.2, height: self.frame.height * 0.64))
        secondLine.position.x = self.frame.midX
        secondLine.position.y = self.frame.midY
        secondLine.cornerRadius = secondLine.frame.width / 2
        self.layer.addSublayer(secondLine)
        
        thirdLine.frame = CGRect(origin: .zero,
                                 size: .init(width: self.frame.width * 0.2, height: self.frame.height * 0.64))
        thirdLine.position.x = self.frame.maxX - thirdLine.frame.width / 2
        thirdLine.position.y = self.frame.midY
        thirdLine.cornerRadius = thirdLine.frame.width / 2
        self.layer.addSublayer(thirdLine)
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        firstLine.backgroundColor = colorSet.mainColor.cgColor
        secondLine.backgroundColor = colorSet.secondMainColor.cgColor
        thirdLine.backgroundColor = colorSet.complementaryColor?.cgColor ?? colorSet.mainColor.cgColor
    }
    
    // MARK: - Animation bodies
    private func lineExpansionAnimation() -> CAAnimationGroup {
        let animationY = CABasicAnimation(keyPath: "transform.scale.y")
        animationY.fromValue = 1
        animationY.toValue = 1.55
        
        let animationX = CABasicAnimation(keyPath: "transform.scale.x")
        animationX.fromValue = 1
        animationX.toValue = 1.4
        
        let group = CAAnimationGroup()
        group.duration = blockAnimateDuration
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false
        group.animations = [animationX, animationY]
        return group
    }
    
    private func lineNarrowingAnimation() -> CAAnimationGroup {
        let animationY = CABasicAnimation(keyPath: "transform.scale.y")
        animationY.fromValue = 1.55
        animationY.toValue = 1
        
        let animationX = CABasicAnimation(keyPath: "transform.scale.x")
        animationX.fromValue = 1.4
        animationX.toValue = 1
        
        let group = CAAnimationGroup()
        group.duration = blockAnimateDuration
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false
        group.animations = [animationX, animationY]
        return group
    }
    
    // MARK: - Animation blocks
    private func animationBlockOne(delay: CFTimeInterval) {
        let narrowingAnim = lineNarrowingAnimation()
        narrowingAnim.beginTime = delay
        firstLine.add(narrowingAnim, forKey: nil)
        
        let expansionAnim = lineExpansionAnimation()
        expansionAnim.beginTime = narrowingAnim.beginTime
        secondLine.add(expansionAnim, forKey: nil)
    }
    
    private func animationBlockTwo(delay: CFTimeInterval) {
        let narrowingAnim = lineNarrowingAnimation()
        narrowingAnim.beginTime = delay
        secondLine.add(narrowingAnim, forKey: nil)
        
        let expansionAnim = lineExpansionAnimation()
        expansionAnim.beginTime = narrowingAnim.beginTime
        thirdLine.add(expansionAnim, forKey: nil)
    }
    
    private func animationBlockThree(delay: CFTimeInterval) {
        let narrowingAnim = lineNarrowingAnimation()
        narrowingAnim.beginTime = delay
        thirdLine.add(narrowingAnim, forKey: nil)
        
        let expansionAnim = lineExpansionAnimation()
        expansionAnim.beginTime = narrowingAnim.beginTime
        firstLine.add(expansionAnim, forKey: nil)
    }
}
