//
//  ViewController.swift
//  RGB
//
//  Created by Roman on 28.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var viewRGB: UIView!
    
    @IBOutlet var redLabelScore: UILabel!
    @IBOutlet var greenLabelScore: UILabel!
    @IBOutlet var blueLabelScore: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSLider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mixColors()
        setValue()
    }
    
    // MARK: IBAction
    @IBAction func sliderAction(_ sender: UISlider) {
        mixColors()
        switch sender {
        case redSlider:
            redLabelScore.text = string(from: sender)
        case greenSlider:
            greenLabelScore.text = string(from: sender)
        default:
            blueLabelScore.text = string(from: sender)
        }
    }
    
    // MARK: Private Methods
    private func setupView() {
        viewRGB.layer.cornerRadius = viewRGB.frame.height / 5
    }
    
    private func mixColors() {
        viewRGB.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSLider.value), alpha: 1
        )
    }
    
    private func setValue() {
        redLabelScore.text = string(from: redSlider)
        greenLabelScore.text = string(from: greenSlider)
        blueLabelScore.text = string(from: blueSLider)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

