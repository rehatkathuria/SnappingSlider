//
//  Created by Rehat Kathuria
//  www.kthr.co
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

public protocol SnappingSliderDelegate: class {
    
    func snappingSliderDidIncrementValue(_ slider:SnappingSlider)
    func snappingSliderDidDecrementValue(_ slider:SnappingSlider)
}

open class SnappingSlider: UIView {

    final public weak var delegate:SnappingSliderDelegate?
    final public var shouldContinueAlteringValueUntilGestureCancels:Bool = false
    final public var incrementAndDecrementLabelFont:UIFont = UIFont(name: "TrebuchetMS-Bold", size: 18.0)! { didSet { setNeedsLayout() } }
    final public var incrementAndDecrementLabelTextColor:UIColor = UIColor.white { didSet { setNeedsLayout() } }
    final public var incrementAndDecrementBackgroundColor:UIColor = UIColor(red:0.36, green:0.65, blue:0.65, alpha:1) { didSet { setNeedsLayout() } }
    final public var sliderColor:UIColor = UIColor(red:0.42, green:0.76, blue:0.74, alpha:1) { didSet { setNeedsLayout() } }
    final public var sliderTitleFont:UIFont = UIFont(name: "TrebuchetMS-Bold", size: 15.0)! { didSet { setNeedsLayout() } }
    final public var sliderTitleColor:UIColor = UIColor.white { didSet { setNeedsLayout() } }
    final public var sliderTitleText:String = "Slide Me" { didSet { setNeedsLayout() } }
    final public var sliderCornerRadius:CGFloat = 3.0 { didSet { setNeedsLayout() } }

    final fileprivate let sliderContainer = UIView(frame: CGRect.zero)
    final fileprivate let minusLabel = UILabel(frame: CGRect.zero)
    final fileprivate let plusLabel = UILabel(frame: CGRect.zero)
    final fileprivate let sliderView = UIView(frame: CGRect.zero)
    final fileprivate let sliderViewLabel = UILabel(frame: CGRect.zero)
    
    final fileprivate var isCurrentDraggingSlider = false
    final fileprivate var lastDelegateFireOffset = CGFloat(0)
    final fileprivate var touchesBeganPoint = CGPoint.zero
    final fileprivate var valueChangingTimer:Timer?
    
    final fileprivate let sliderPanGestureRecogniser = UIPanGestureRecognizer()
    final fileprivate let dynamicButtonAnimator = UIDynamicAnimator()
    final fileprivate var snappingBehavior:SliderSnappingBehavior?

    public init(frame:CGRect, title:String) {

        super.init(frame: frame)

        sliderTitleText = title
        setup()
        setNeedsLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        setup()
        setNeedsLayout()
    }
    
    fileprivate func setup() {
        
        sliderContainer.backgroundColor = backgroundColor
        
        minusLabel.text = "-"
        minusLabel.textAlignment = NSTextAlignment.center
        sliderContainer.addSubview(minusLabel)
        
        plusLabel.text = "+"
        plusLabel.textAlignment = NSTextAlignment.center
        sliderContainer.addSubview(plusLabel)
        
        sliderContainer.addSubview(sliderView)
        
        sliderViewLabel.isUserInteractionEnabled = false
        sliderViewLabel.textAlignment = NSTextAlignment.center
        sliderViewLabel.textColor = sliderTitleColor
        sliderView.addSubview(sliderViewLabel)
        
        sliderPanGestureRecogniser.addTarget(self, action: #selector(type(of: self).handleGesture(_:)))
        sliderView.addGestureRecognizer(sliderPanGestureRecogniser)
        
        sliderContainer.center = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        addSubview(sliderContainer)
        clipsToBounds = true
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        if snappingBehavior?.snappingPoint.x != center.x {
        
            snappingBehavior = SliderSnappingBehavior(item: sliderView, snapToPoint: CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5))
            lastDelegateFireOffset = sliderView.center.x
        }
        
        sliderContainer.frame = frame
        sliderContainer.center = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        sliderContainer.backgroundColor = incrementAndDecrementBackgroundColor

        minusLabel.frame = CGRect(x: 0.0, y: 0.0, width: bounds.size.width * 0.25, height: bounds.size.height)
        minusLabel.center = CGPoint(x: minusLabel.bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        minusLabel.backgroundColor = incrementAndDecrementBackgroundColor
        minusLabel.font = incrementAndDecrementLabelFont
        minusLabel.textColor = incrementAndDecrementLabelTextColor
        
        plusLabel.frame = CGRect(x: 0.0, y: 0.0, width: bounds.size.width * 0.25, height: bounds.size.height)
        plusLabel.center = CGPoint(x: bounds.size.width - plusLabel.bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        plusLabel.backgroundColor = incrementAndDecrementBackgroundColor
        plusLabel.font = incrementAndDecrementLabelFont
        plusLabel.textColor = incrementAndDecrementLabelTextColor
        
        sliderView.frame = CGRect(x: 0.0, y: 0.0, width: bounds.size.width * 0.5, height: bounds.size.height)
        sliderView.center = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        sliderView.backgroundColor = sliderColor
        
        sliderViewLabel.frame = CGRect(x: 0.0, y: 0.0, width: sliderView.bounds.size.width, height: sliderView.bounds.size.height)
        sliderViewLabel.center = CGPoint(x: sliderViewLabel.bounds.size.width * 0.5, y: sliderViewLabel.bounds.size.height * 0.5)
        sliderViewLabel.backgroundColor = sliderColor
        sliderViewLabel.font = sliderTitleFont
        sliderViewLabel.text = sliderTitleText
        
        layer.cornerRadius = sliderCornerRadius
    }
    
    // MARK: Gesture & Timer Handling
    
    @objc final func handleGesture(_ sender: UIGestureRecognizer) {

        guard let snapBehavior = snappingBehavior else { return }

        if sender as NSObject == sliderPanGestureRecogniser {
        
            switch sender.state {
             
            case .began:
                
                isCurrentDraggingSlider = true
                touchesBeganPoint = sliderPanGestureRecogniser.translation(in: sliderView)
                dynamicButtonAnimator.removeBehavior(snapBehavior)
                lastDelegateFireOffset = (bounds.size.width * 0.5) + ((touchesBeganPoint.x + touchesBeganPoint.x) * 0.40)
                
            case .changed:
                
                valueChangingTimer?.invalidate()
                
                let translationInView = sliderPanGestureRecogniser.translation(in: sliderView)
                let translatedCenterX:CGFloat = (bounds.size.width * 0.5) + ((touchesBeganPoint.x + translationInView.x) * 0.40)
                sliderView.center = CGPoint(x: translatedCenterX, y: sliderView.center.y);
                
                if (translatedCenterX < lastDelegateFireOffset) {
                    
                    if (fabs(lastDelegateFireOffset - translatedCenterX) >= (sliderView.bounds.size.width * 0.15)) {
                        
                        delegate?.snappingSliderDidDecrementValue(self)
                        lastDelegateFireOffset = translatedCenterX
                    }
                }
                else {
                    
                    if (fabs(lastDelegateFireOffset - translatedCenterX) >= (sliderView.bounds.size.width * 0.15)) {
                        
                        delegate?.snappingSliderDidIncrementValue(self)
                        lastDelegateFireOffset = translatedCenterX
                    }
                }
                
                if shouldContinueAlteringValueUntilGestureCancels {
                    
                    valueChangingTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: NSSelectorFromString("handleTimer:"), userInfo: nil, repeats: true)
                }
                
            case .ended:

                fallthrough
                
            case .failed:

                fallthrough

            case .cancelled:
                
                dynamicButtonAnimator.addBehavior(snapBehavior)
                isCurrentDraggingSlider = false
                lastDelegateFireOffset = center.x
                valueChangingTimer?.invalidate()
                
            case .possible:

                // Swift requires at least one statement per case
                _ = 0
            }
        }
    }
    
    final func handleTimer(_ sender: Timer) {
    
        if sliderView.frame.midX > self.bounds.midX {
            
            delegate?.snappingSliderDidIncrementValue(self)
        }
        else {
            
            delegate?.snappingSliderDidDecrementValue(self)
        }
    }

}

final class SliderSnappingBehavior: UIDynamicBehavior {
 
    let snappingPoint:CGPoint

    init(item: UIDynamicItem, snapToPoint point: CGPoint) {
    
        let dynamicItemBehavior:UIDynamicItemBehavior  = UIDynamicItemBehavior(items: [item])
        dynamicItemBehavior.allowsRotation = false
        
        let snapBehavior:UISnapBehavior = UISnapBehavior(item: item, snapTo: point)
        snapBehavior.damping = 0.25
        
        snappingPoint = point
        
        super.init()
        
        addChildBehavior(dynamicItemBehavior)
        addChildBehavior(snapBehavior)
    }

}
