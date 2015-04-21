//
//  ViewController.swift
//  Snapping Slider Example
//
//  Created by Rehat Kathuria on 21/04/2015.
//  Copyright (c) 2015 Kathuria Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SnappingSliderDelegate {

    private var numberOfCupsOfTeaIHaveDrankSoFar:Int = 0
    private let bladderFillLabel:UILabel = UILabel(frame: CGRectZero)
    private let snappingSlider:SnappingSlider = SnappingSlider(frame: CGRectMake(0.0, 0.0, 10.0, 10.0), title: "Slide Me")

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bladderFillLabel.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width * 0.5, 80.0)
        bladderFillLabel.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 - bladderFillLabel.bounds.size.height * 0.75)
        bladderFillLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 25.0)
        bladderFillLabel.textColor = UIColor.lightGrayColor()
        bladderFillLabel.textAlignment = NSTextAlignment.Center
        bladderFillLabel.text = "\(numberOfCupsOfTeaIHaveDrankSoFar)"
        self.view.addSubview(bladderFillLabel)
        
        snappingSlider.delegate = self
        snappingSlider.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width * 0.5, 50.0)
        snappingSlider.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5)
        self.view.addSubview(snappingSlider)
    }
    
    func snappingSliderDidIncrementValue(snapSwitch: SnappingSlider) {

        numberOfCupsOfTeaIHaveDrankSoFar++
        bladderFillLabel.text = "\(numberOfCupsOfTeaIHaveDrankSoFar)"
    }
    
    func snappingSliderDidDecrementValue(snapSwitch: SnappingSlider) {
        
        numberOfCupsOfTeaIHaveDrankSoFar = max(0, numberOfCupsOfTeaIHaveDrankSoFar - 1)
        bladderFillLabel.text = "\(numberOfCupsOfTeaIHaveDrankSoFar)"
    }
    
}
