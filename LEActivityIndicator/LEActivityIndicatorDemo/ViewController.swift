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
        let someView = LEActivityIndicator(style: .defaultStyle,
                                           size: .extraLarge,
                                           colorSet: .init(mainColor: .blue,
                                                           secondMainColor: .green,
                                                           complementaryColor: .blue))
        view.addSubview(someView)
        someView.showActivityIndicator()
        someView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        someView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }


}

