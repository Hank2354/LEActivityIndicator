//
//  ViewController.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 03.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private var topStack: UIStackView!
    private var bottomStack: UIStackView!
    private let indicators: [LEActivityIndicator] = [
        LEActivityIndicator(style: .defaultStyle,
                            size: .medium,
                            colorSet: LEActivityColorSet(mainColor: UIColor(red: 0.405, green: 0.722, blue: 0.9, alpha: 1),
                                                         secondMainColor: UIColor(),
                                                         complementaryColor: nil)),
        LEActivityIndicator(style: .spinner,
                            size: .medium,
                            colorSet: LEActivityColorSet(mainColor: .white,
                                                         secondMainColor: UIColor(red: 0.875, green: 0.12, blue: 0.392, alpha: 1),
                                                         complementaryColor: nil)),
        LEActivityIndicator(style: .gradient,
                            size: .medium,
                            colorSet: LEActivityColorSet(mainColor: UIColor(red: 0.827, green: 1, blue: 0.337, alpha: 1),
                                                         secondMainColor: UIColor(red: 0.827, green: 1, blue: 0.337, alpha: 1).withAlphaComponent(0),
                                                         complementaryColor: nil)),
        LEActivityIndicator(style: .wave,
                            size: .medium,
                            colorSet: LEActivityColorSet(mainColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1),
                                                         secondMainColor: UIColor(red: 0.298, green: 0.459, blue: 0.949, alpha: 1),
                                                         complementaryColor: nil)),
        LEActivityIndicator(style: .bouble,
                            size: .medium,
                            colorSet: LEActivityColorSet(mainColor: UIColor(red: 0.137, green: 0.762, blue: 0.162, alpha: 1),
                                                         secondMainColor: UIColor(),
                                                         complementaryColor: nil)),
        LEActivityIndicator(style: .line,
                            size: .medium,
                            colorSet: LEActivityColorSet(mainColor: .white,
                                                         secondMainColor: UIColor(red: 0.243, green: 0.606, blue: 0.942, alpha: 1),
                                                         complementaryColor: nil)),
        LEActivityIndicator(style: .cube,
                            size: .medium,
                            colorSet: LEActivityColorSet(mainColor: UIColor(red: 0.942, green: 0.868, blue: 0.204, alpha: 1),
                                                         secondMainColor: UIColor(red: 0.721, green: 0.666, blue: 0.174, alpha: 1),
                                                         complementaryColor: UIColor(red: 0.475, green: 0.439, blue: 0.111, alpha: 1))),
        LEActivityIndicator(style: .walking,
                            size: .medium,
                            colorSet: LEActivityColorSet(mainColor: UIColor(red: 1, green: 0.718, blue: 0.082, alpha: 1),
                                                         secondMainColor: UIColor(red: 0.869, green: 0.282, blue: 0.35, alpha: 1),
                                                         complementaryColor: UIColor(red: 0.476, green: 0.193, blue: 0.495, alpha: 1))),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        
        setupSubviews()
        addSubviews()
        setupLayout()
        
    }
    
    fileprivate func setupSubviews() {
        // Setup title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "LEActivityIndicators Demo"
        titleLabel.textColor = .systemGray5
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        titleLabel.textAlignment = .center
       
        // Setup indicators view
        var indicatorViews = [PresentationIndicatorView]()
        
        for indicator in indicators {
            let view = PresentationIndicatorView(indicator: indicator)
            indicatorViews.append(view)
        }
        
        topStack = UIStackView(arrangedSubviews: [
            indicatorViews[0],
            indicatorViews[1],
            indicatorViews[2],
            indicatorViews[3]
        ])
        
        bottomStack = UIStackView(arrangedSubviews: [
            indicatorViews[4],
            indicatorViews[5],
            indicatorViews[6],
            indicatorViews[7]
        ])
        
        let stacks = [topStack, bottomStack]
        
        stacks.forEach {
            $0!.axis = .horizontal
            $0!.spacing = 10
            $0!.distribution = .fillEqually
            $0!.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    fileprivate func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(topStack)
        view.addSubview(bottomStack)
    }
    
    fileprivate func setupLayout() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        topStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        topStack.heightAnchor.constraint(equalTo: topStack.widthAnchor, multiplier: 0.25).isActive = true
        
        bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        bottomStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 30).isActive = true
        bottomStack.heightAnchor.constraint(equalTo: topStack.widthAnchor, multiplier: 0.25).isActive = true
    }


}

