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
    private var toggleAnimationButton = UIButton(type: .system)
    
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
                            colorSet: LEActivityColorSet(mainColor: UIColor(red: 0.110, green: 0.110, blue: 0.110, alpha: 1),
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
    
    private var isAnimationEnabled: Bool = true {
        didSet {
            if isAnimationEnabled {
                for indicator in indicators {
                    indicator.showActivityIndicator()
                }
            } else {
                for indicator in indicators {
                    indicator.hideActivityIndicator()
                }
            }
        }
    }
    
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
        
        // Setup button
        toggleAnimationButton.translatesAutoresizingMaskIntoConstraints = false
        toggleAnimationButton.layer.cornerRadius = 10
        toggleAnimationButton.setTitle("Toggle animation", for: .normal)
        toggleAnimationButton.setTitleColor(.darkGray, for: .normal)
        toggleAnimationButton.layer.borderWidth = 1
        toggleAnimationButton.layer.borderColor = UIColor.systemGray5.cgColor
        toggleAnimationButton.backgroundColor = .clear
        toggleAnimationButton.addTarget(self, action: #selector(toggleAnimation), for: .touchUpInside)
        
        // Setup indicators view
        var indicatorViews = [PresentationIndicatorView]()
        
        for indicator in indicators {
            let view = PresentationIndicatorView(indicator: indicator)
            indicatorViews.append(view)
        }
        
        for view in indicatorViews {
            view.addTarget(self, action: #selector(didTapIndicatorView(_:)), for: .touchUpInside)
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
        view.addSubview(toggleAnimationButton)
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
        
        toggleAnimationButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        toggleAnimationButton.heightAnchor.constraint(equalTo: toggleAnimationButton.widthAnchor, multiplier: 0.25).isActive = true
        toggleAnimationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        toggleAnimationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func toggleAnimation() {
        isAnimationEnabled.toggle()
    }
    
    @objc func didTapIndicatorView(_ sender: PresentationIndicatorView) {
        let vc = UIViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        vc.view.backgroundColor = .systemGray4
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.text = "Indicator type: \(sender.indicator.currentActivity.style)\nIndicator size: \(sender.indicator.currentActivity.size)"
        textView.textColor = .white
        textView.backgroundColor = vc.view.backgroundColor
        textView.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        vc.view.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -10).isActive = true
        textView.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 5).isActive = true
        textView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor, constant: -5).isActive = true
        
        if let popoverController = vc.popoverPresentationController {
            popoverController.delegate = self
            popoverController.sourceView = sender
            vc.preferredContentSize = CGSize(width: 200, height: 55)
            
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

