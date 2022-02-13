//
//  WaveActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 12.02.2022.
//

import Foundation
import UIKit

class WaveActivityIndicator: UIView, LEActivity {
    
    // MARK: - Internal properties
    let blockAnimateDuration: CFTimeInterval = 1
    
    // MARK: - Private properties
    private var positionAnimation: CABasicAnimation!
    private var isAnimationStarted: Bool = false
    private var graphWidth: CGFloat = 2
    private var amplitude: CGFloat = 0.2
    
    private var sinLineLayer = CAShapeLayer()
    
    // MARK: - Init
    required init(size: LEActivitySize, colorSet: LEActivityColorSet) {
        super.init(frame: CGRect(origin: .zero,
                                 size: size.getCurrentSize()))
        backgroundColor = .clear
        
        configureLayers()
        setupColors(colorSet)
        positionAnimation = setupPositionAnimation()
        
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
        sinLineLayer.add(positionAnimation, forKey: nil)
    }
    
    func hideActivity() {
        guard isAnimationStarted == true else { return }
        
        self.isHidden = true
        isAnimationStarted = false
        
        sinLineLayer.removeAllAnimations()
    }
    
    // MARK: - Configuration methods
    private func configureLayers() {
        sinLineLayer.fillColor = UIColor.clear.cgColor
        sinLineLayer.strokeColor = UIColor.blue.cgColor
        sinLineLayer.lineWidth = bounds.height / 10
        sinLineLayer.lineCap = .round
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
        layer.addSublayer(sinLineLayer)
    }
    
    private func setupColors(_ colorSet: LEActivityColorSet) {
        layer.backgroundColor = colorSet.mainColor.cgColor
        sinLineLayer.backgroundColor = colorSet.secondMainColor.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let origin = CGPoint(x: bounds.minX, y: height * 0.50)
        
        let path = UIBezierPath()
        path.move(to: origin)
        
        for angle in stride(from: 5.0, through: 720.0, by: 5.0) {
            let x = origin.x + CGFloat(angle/360.0) * width * graphWidth
            let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        sinLineLayer.path = path.cgPath
    }
    
    // MARK: - Animation bodies
    private func setupPositionAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.duration = blockAnimateDuration
        animation.fromValue = bounds.minX
        animation.toValue = -bounds.maxX*2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.repeatCount = HUGE
        return animation
    }
}
