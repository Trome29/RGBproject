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
    
    // MARK: - IBOutlets
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
    
    // MARK: - Public Properties
    var delegate: SettingsViewControllerDelegate!
    var mainViewBackground: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRGB.backgroundColor = mainViewBackground
        viewRGB.layer.cornerRadius = viewRGB.frame.height / 5
        
        setValueForSliders()
        setValue(for: redLabelScore, greenLabelScore, blueLabelScore)
        setValue(for: redTextField, greenTextField, blueTextField)
        addDoneButton(to: redTextField, greenTextField, blueTextField)
    }
    
    // MARK: - IBActions
    @IBAction func sliderAction(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            setValue(for: redLabelScore)
            setValue(for: redTextField)
        case 1:
            setValue(for: greenLabelScore)
            setValue(for: greenTextField)
        case 2:
            setValue(for: blueLabelScore)
            setValue(for: blueTextField)
        default:
            break
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
    
    private func setValue(for textFields: UITextField...) {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSLider)
    }
    
    private func setValue(for labels: UILabel...) {
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
    
    private func addDoneButton(to textFields: UITextField...) {
        textFields.forEach { textField in
            let toolbar = UIToolbar()
            textField.inputAccessoryView = toolbar
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(doneDidTapped)
            )
            let hiddenItem = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            )
            
            toolbar.items = [hiddenItem, doneButton]
        }
    }
    
    @objc private func doneDidTapped() {
        view.endEditing(true)
    }
}

