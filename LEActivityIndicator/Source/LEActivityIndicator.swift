//
//  LEActivityIndicator.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 06.02.2022.
//

import Foundation
import UIKit

protocol LEActivity: UIView {
    func showActivity()
    func hideActivity()
    
    init(size: LEActivitySize, colorSet: LEActivityColorSet)
    
    var style: LEActivityStyle { get }
    var size: LEActivitySize { get }
}

class LEActivityIndicator: UIView {
    
    var currentActivity: LEActivity!
    
    init(style: LEActivityStyle, size: LEActivitySize, colorSet: LEActivityColorSet) {
        super.init(frame: CGRect(origin: .zero, size: size.getCurrentSize()))
        setupLayoutSetting()
        
        switch style {
        case .walking:
            currentActivity = WalkingActivityIndicator(size: size, colorSet: colorSet)
        case .spinner:
            currentActivity = SpinnerActivityIndicator(size: size, colorSet: colorSet)
        case .gradient:
            currentActivity = GradientActivityIndicator(size: size, colorSet: colorSet)
        case .cube:
            currentActivity = CubeActivityIndicator(size: size, colorSet: colorSet)
        case .wave:
            currentActivity = WaveActivityIndicator(size: size, colorSet: colorSet)
        case .bouble:
            currentActivity = BoubleActivityIndicator(size: size, colorSet: colorSet)
        case .line:
            currentActivity = LineActivityIndicator(size: size, colorSet: colorSet)
        case .defaultStyle:
            currentActivity = DefaultActivityIndicator(size: size, colorSet: colorSet)
        }
        
        self.addSubview(currentActivity)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showActivityIndicator() {
        currentActivity.showActivity()
    }
    
    func hideActivityIndicator() {
        currentActivity.hideActivity()
    }
    
    private func setupLayoutSetting() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: self.frame.size.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: self.frame.size.width).isActive = true
    }
    
}
