//
//  ViewController.swift
//  RGB
//
//  Created by Roman on 28.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
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
    }

    private func setupView() {
        viewRGB.layer.cornerRadius = viewRGB.frame.height / 5

    }
    
    private func mixColors() {
        viewRGB.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSLider.value), alpha: 1)
    }
    
    // MARK: IBActions
    @IBAction func redSliderAction() {
        redLabelScore.text = (round(redSlider.value * 100) / 100).formatted()
        mixColors()
    }
    @IBAction func greenSliderAction() {
        greenLabelScore.text = (round(greenSlider.value * 100) / 100).formatted()
        mixColors()
    }
    @IBAction func blueSliderAction() {
        blueLabelScore.text = (round(blueSLider.value * 100) / 100).formatted()
        mixColors()
    }
    
}

