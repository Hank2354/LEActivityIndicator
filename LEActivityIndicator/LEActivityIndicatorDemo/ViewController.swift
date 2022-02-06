//
//  ViewController.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 03.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        let someView = LEActivityIndicator(style: .spinner, size: .large, colorSet: .init(mainColor: .white, secondMainColor: .red, complementaryColor: nil))
        view.addSubview(someView)
        someView.showActivityIndicator()
        someView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        someView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }


}

