//
//  ViewController.swift
//  SnappingSliderDemo
//
//  Created by Valentin Radu on 27/12/2017.
//  Copyright © 2017 Valentin Radu. All rights reserved.
//

import UIKit
import SnappingSlider

class ViewController: UIViewController, SnappingSliderDelegate {

    @IBOutlet var snappingSlider: SnappingSlider!
    var value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snappingSlider.delegate = self
        snappingSlider.sliderTitleText = String(value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func snappingSliderDidIncrementValue(_ slider:SnappingSlider) {
        value += 1
        snappingSlider.sliderTitleText = String(value)
    }
    
    func snappingSliderDidDecrementValue(_ slider:SnappingSlider) {
        value -= 1
        snappingSlider.sliderTitleText = String(value)
    }
}

