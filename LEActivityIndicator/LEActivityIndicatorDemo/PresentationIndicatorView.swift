//
//  PresentationIndicatorView.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 13.02.2022.
//

import Foundation
import UIKit

final class PresentationIndicatorView: UIView {
    
    private var indicator: LEActivityIndicator!
    
    init(indicator: LEActivityIndicator) {
        self.indicator = indicator
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupLayout()
        
        indicator.showActivityIndicator()
        indicator.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 10
        backgroundColor = UIColor(red: 0.085, green: 0.059, blue: 0.129, alpha: 1)
    }
    
    fileprivate func setupSubviews() {
        addSubview(indicator)
    }
    
    fileprivate func setupLayout() {
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
