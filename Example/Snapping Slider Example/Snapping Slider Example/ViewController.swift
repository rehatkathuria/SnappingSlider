//
//  ViewController.swift
//  Snapping Slider Example
//
//  Created by Rehat Kathuria on 21/04/2015.
//  Copyright (c) 2015 Kathuria Ltd. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, SnappingSliderDelegate {

    fileprivate var numberOfCupsOfTeaIHaveDrankSoFar:Int = 0
    fileprivate let bladderFillLabel:UILabel = UILabel(frame: CGRect.zero)
    fileprivate let snappingSlider:SnappingSlider = SnappingSlider(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0), title: "Slide Me")

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bladderFillLabel.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width * 0.5, height: 80.0)
        bladderFillLabel.center = CGPoint(x: self.view.bounds.size.width * 0.5, y: self.view.bounds.size.height * 0.5 - bladderFillLabel.bounds.size.height * 0.75)
        bladderFillLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 25.0)
        bladderFillLabel.textColor = UIColor.lightGray
        bladderFillLabel.textAlignment = NSTextAlignment.center
        bladderFillLabel.text = "\(numberOfCupsOfTeaIHaveDrankSoFar)"
        self.view.addSubview(bladderFillLabel)
        
        snappingSlider.delegate = self
        snappingSlider.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width * 0.5, height: 50.0)
        snappingSlider.center = CGPoint(x: self.view.bounds.size.width * 0.5, y: self.view.bounds.size.height * 0.5)
        self.view.addSubview(snappingSlider)
    }
    
    func snappingSliderDidIncrementValue(_ snapSwitch: SnappingSlider) {

        numberOfCupsOfTeaIHaveDrankSoFar += 1
        bladderFillLabel.text = "\(numberOfCupsOfTeaIHaveDrankSoFar)"
    }
    
    func snappingSliderDidDecrementValue(_ snapSwitch: SnappingSlider) {
        
        numberOfCupsOfTeaIHaveDrankSoFar = max(0, numberOfCupsOfTeaIHaveDrankSoFar - 1)
        bladderFillLabel.text = "\(numberOfCupsOfTeaIHaveDrankSoFar)"
    }
    
}
