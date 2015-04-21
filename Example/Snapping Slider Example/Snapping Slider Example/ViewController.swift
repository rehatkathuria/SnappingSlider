//
//  ViewController.swift
//  Snapping Slider Example
//
//  Created by Rehat Kathuria on 21/04/2015.
//  Copyright (c) 2015 Kathuria Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SnappingSliderDelegate {

    private let snappingSlider:SnappingSlider = SnappingSlider(frame: CGRectMake(0.0, 0.0, 10.0, 10.0), title: "Slide Me")

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        snappingSlider.delegate = self
        snappingSlider.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width * 0.5, 50.0)
        snappingSlider.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5)
        self.view.addSubview(snappingSlider)
    }
    
    func snappingSliderDidIncrementValue(snapSwitch: SnappingSlider) {
        
        println("Snapping slider be incrementing value, bro.")
    }
    
    func snappingSliderDidDecrementValue(snapSwitch: SnappingSlider) {
        
        println("Snapping slider be decrementing value, bro.")
    }
    
}
