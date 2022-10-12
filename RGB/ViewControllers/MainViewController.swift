//
//  MainViewController.swift
//  RGB
//
//  Created by Roman on 12.10.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setupColor(_ color: UIColor)
}

class MainViewController: UIViewController {
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SettingsViewController
        settingsVC?.mainViewBackground = view.backgroundColor
        settingsVC?.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setupColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
