//
//  CubeActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 12.02.2022.
//

import Foundation
import UIKit

class CubeActivityIndicator: UIView, LEActivity {
    
    // MARK: - Internal properties
    let blockAnimateDuration: CFTimeInterval = 0.6
    
    // MARK: - Private properties
    private var moveUpAnimation: CABasicAnimation!
    private var moveDownAnimation: CABasicAnimation!
    private var rotateAnimation: CABasicAnimation!
    private var isAnimationStarted: Bool = false
    private var timer: Timer?
    
    private var leftSide: CAShapeLayer!
    private var rightSide: CAShapeLayer!
    private var topSide: CAShapeLayer!
    
    // MARK: - Init
    required init(size: LEActivitySize, colorSet: LEActivityColorSet) {
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
        backgroundColor = .clear
        
        configureLayers()
        setupColors(colorSet)
        moveUpAnimation = setupMoveUpAnimation()
        moveDownAnimation = setupMoveDownAnimation()
        moveDownAnimation.beginTime = CACurrentMediaTime() + blockAnimateDuration / 2
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
        self.layer.add(self.moveUpAnimation, forKey: nil)
        self.layer.add(self.moveDownAnimation, forKey: nil)
        self.layer.add(self.rotateAnimation, forKey: nil)
        timer = Timer.scheduledTimer(withTimeInterval: blockAnimateDuration * 1.5, repeats: true) { _ in
            self.layer.add(self.moveUpAnimation, forKey: nil)
            self.moveDownAnimation.beginTime = CACurrentMediaTime() + self.blockAnimateDuration / 2
            self.layer.add(self.moveDownAnimation, forKey: nil)
            self.layer.add(self.rotateAnimation, forKey: nil)
        }
        
    }
    
    func hideActivity() {
        guard isAnimationStarted == true else { return }
        
        self.isHidden = true
        isAnimationStarted = false
        
        timer?.invalidate()
        timer = nil
        self.layer.removeAllAnimations()
    }
    
    // MARK: - Configuration methods
    private func configureLayers() {
        leftSide = createLeftSide()
        rightSide = createRightSide()
        topSide = createTopSide()
        
        layer.addSublayer(topSide)
        layer.addSublayer(rightSide)
        layer.addSublayer(leftSide)
    }
    
    private func createLeftSide() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: .init(x: bounds.minX, y: bounds.height / 4))
        path.addLine(to: .init(x: bounds.midX, y: bounds.midY))
        path.addLine(to: .init(x: bounds.midX, y: bounds.maxY))
        path.addLine(to: .init(x: bounds.minX, y: bounds.height * 3/4))
        path.addLine(to: .init(x: bounds.minX, y: bounds.height / 4))
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        return shapeLayer
    }
    
    private func createRightSide() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: .init(x: bounds.maxX, y: bounds.height / 4))
        path.addLine(to: .init(x: bounds.midX, y: bounds.midY))
        path.addLine(to: .init(x: bounds.midX, y: bounds.maxY))
        path.addLine(to: .init(x: bounds.maxX, y: bounds.height * 3/4))
        path.addLine(to: .init(x: bounds.maxX, y: bounds.height / 4))
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.blue.cgColor
        return shapeLayer
    }
    
    private func createTopSide() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: .init(x: bounds.minX, y: bounds.height / 4))
        path.addLine(to: .init(x: bounds.midX, y: bounds.minY))
        path.addLine(to: .init(x: bounds.maxX, y: bounds.height / 4))
        path.addLine(to: .init(x: bounds.midX, y: bounds.midY))
        path.addLine(to: .init(x: bounds.minX, y: bounds.height / 4))
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.yellow.cgColor
        return shapeLayer
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        topSide.fillColor = colorSet.mainColor.cgColor
        leftSide.fillColor = colorSet.secondMainColor.cgColor
        if let complementaryColor = colorSet.complementaryColor {
            rightSide.fillColor = complementaryColor.cgColor
        } else {
            rightSide.fillColor = UIColor.white.cgColor
        }
    }
    
    // MARK: - Animation bodies
    private func setupRotateAnimation() -> CABasicAnimation {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.toValue = Double.pi * 2
        rotateAnimation.duration = blockAnimateDuration
        rotateAnimation.fillMode = .forwards
        rotateAnimation.isRemovedOnCompletion = false
        return rotateAnimation
    }
    
    private func setupMoveUpAnimation() -> CABasicAnimation {
        let moveUpAnimtation = CABasicAnimation(keyPath: "position.y")
        moveUpAnimtation.fromValue = bounds.midY
        moveUpAnimtation.toValue = -1
        moveUpAnimtation.duration = blockAnimateDuration / 2
        moveUpAnimtation.fillMode = .forwards
        moveUpAnimtation.isRemovedOnCompletion = false
        return moveUpAnimtation
    }
    
    private func setupMoveDownAnimation() -> CABasicAnimation {
        let moveDownAnimtation = CABasicAnimation(keyPath: "position.y")
        moveDownAnimtation.fromValue = -1
        moveDownAnimtation.toValue = bounds.midY
        moveDownAnimtation.duration = blockAnimateDuration / 2
        moveDownAnimtation.fillMode = .forwards
        moveDownAnimtation.isRemovedOnCompletion = false
        return moveDownAnimtation
    }
}
