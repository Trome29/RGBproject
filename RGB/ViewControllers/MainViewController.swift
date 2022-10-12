//
//  MainViewController.swift
//  RGB
//
//  Created by Roman on 12.10.2022.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setupColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
