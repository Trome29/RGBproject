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
    @IBOutlet var blueSlider: UISlider!
    
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
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
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
            blue: CGFloat(blueSlider.value), alpha: 1
        )
    }
    
    private func setValueForSliders() {
        let ciColor = CIColor(color: mainViewBackground)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField.tag {
            case 0: redTextField.text = string(from: redSlider)
            case 1: greenTextField.text = string(from: greenSlider)
            case 2: blueTextField.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0: redLabelScore.text = string(from: redSlider)
            case 1: greenLabelScore.text = string(from: greenSlider)
            case 2: blueLabelScore.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let value = Float(text), value <= 1, value >= 0 {
            switch textField.tag {
            case 0:
                redSlider.setValue(value, animated: true)
                setValue(for: redLabelScore)
            case 1:
                greenSlider.setValue(value, animated: true)
                setValue(for: greenLabelScore)
            case 2:
                blueSlider.setValue(value, animated: true)
                setValue(for: blueLabelScore)
            default: break
            }
            
            mixColors()
            return
        }
        
        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
}
