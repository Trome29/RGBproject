//
//  ViewController.swift
//  RGB
//
//  Created by Roman on 28.09.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setupColor(_ color: UIColor)
}

class SettingsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var viewRGB: UIView!
    
    @IBOutlet var redLabelScore: UILabel!
    @IBOutlet var greenLabelScore: UILabel!
    @IBOutlet var blueLabelScore: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSLider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    var mainViewBackground: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRGB.backgroundColor = mainViewBackground
        viewRGB.layer.cornerRadius = viewRGB.frame.height / 5
        
        setValueForSliders()
        setValue(to: redLabelScore, greenLabelScore, blueLabelScore)
        setValue(to: redTextField, greenTextField, blueTextField)
    }
    
    // MARK: - IBAction
    @IBAction func sliderAction(_ sender: UISlider) {
        
        // переделать повторяющийся код, теги??
        switch sender.tag {
        case 0:
            setValue(to: redLabelScore)
            setValue(to: redTextField)
        case 1:
            setValue(to: greenLabelScore)
            setValue(to: greenTextField)
        case 2:
            setValue(to: blueLabelScore)
            setValue(to: blueTextField)
        default: break
        }
        mixColors()
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setupColor(viewRGB.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    
    // MARK: - Private Methods
    
    private func mixColors() {
        viewRGB.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSLider.value), alpha: 1
        )
    }
    
    private func setValue(to textFields: UITextField...) {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSLider)
    }
    
    private func setValue(to labels: UILabel...) {
        redLabelScore.text = string(from: redSlider)
        greenLabelScore.text = string(from: greenSlider)
        blueLabelScore.text = string(from: blueSLider)
    }
    
    
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }

    private func setValueForSliders() {
        let ciColor = CIColor(color: mainViewBackground)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSLider.value = Float(ciColor.blue)
    }
}

