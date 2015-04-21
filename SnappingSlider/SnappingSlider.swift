//
//  let bp = BeautifulOpenSourceProject(name: "SnappingSlider")
//  let handsomeAuthor = Author(name: "Rehat Kathuria", portfolioURL: "http://kthr.co")
//

import UIKit

protocol SnappingSliderDelegate: class {
    
    func snappingSliderDidIncrementValue(slider:SnappingSlider)
    func snappingSliderDidDecrementValue(slider:SnappingSlider)
}

class SnappingSlider: UIView {

    // Dem Exposed Variables
    final weak var delegate:SnappingSliderDelegate?

    final var incrementAndDecrementLabelFont:UIFont
    final var incrementAndDecrementLabelTextColor:UIColor
    final var incrementAndDecrementBackgroundColor:UIColor
    
    final var sliderColor:UIColor
    final var sliderTitleFont:UIFont
    final var sliderTitleColor:UIColor
    final var sliderTitleText:String
    
    final var sliderCornerRadius:CGFloat
    
    // Dem Private Variables
    final private let sliderContainer:UIView = UIView(frame: CGRectZero)
    final private let minusLabel:UILabel = UILabel(frame: CGRectZero)
    final private let plusLabel:UILabel = UILabel(frame: CGRectZero)
    final private let sliderView:UIView = UIView(frame: CGRectZero)
    final private let sliderViewLabel:UILabel = UILabel(frame: CGRectZero)
    
    final private var isCurrentDraggingSlider:Bool = false
    final private var lastDelegateFireOffset:CGFloat = 0
    final private var touchesBeganPoint:CGPoint = CGPointZero
    
    final private let sliderPanGestureRecogniser:UIPanGestureRecognizer = UIPanGestureRecognizer()
    final private let dynamicButtonAnimator:UIDynamicAnimator = UIDynamicAnimator()
    final private var snappingBehavior:SliderSnappingBehavior?
    
    final private let defaultIncrementAndDecrementLabelsBackgroundColor:UIColor = UIColor(red:0.36, green:0.65, blue:0.65, alpha:1)
    final private let defaultIncrementAndDecrementLabelsFont:UIFont = UIFont(name: "TrebuchetMS-Bold", size: 18.0)!
    final private let defaultIncrementAndDecrementLabelsTextColor:UIColor = UIColor.whiteColor()

    final private let defaultSliderColor:UIColor = UIColor(red:0.42, green:0.76, blue:0.74, alpha:1)
    final private let defaultSliderTitleFont:UIFont = UIFont(name: "TrebuchetMS-Bold", size: 15.0)!
    final private let defaultSliderTitleColor:UIColor = UIColor.whiteColor()
    final private let defaultsliderTitleText:String = "Slide Me"

    final private let defaultCornerRadius:CGFloat = 3.0
    
    
    // MARK: Init & View Lifecycle

    init(frame:CGRect, title:String) {
        
        incrementAndDecrementLabelFont = defaultIncrementAndDecrementLabelsFont
        incrementAndDecrementBackgroundColor = defaultIncrementAndDecrementLabelsBackgroundColor
        incrementAndDecrementLabelTextColor = defaultIncrementAndDecrementLabelsTextColor
        
        sliderColor = defaultSliderColor
        sliderTitleFont = defaultSliderTitleFont
        sliderTitleColor = defaultSliderTitleColor
        sliderTitleText = title
        
        sliderCornerRadius = defaultCornerRadius
        
        super.init(frame: frame)
        
        self.backgroundColor = backgroundColor
        sliderContainer.backgroundColor = backgroundColor
        
        minusLabel.frame = CGRectMake(0.0, 0.0, frame.size.width * 0.25, frame.size.height)
        minusLabel.center = CGPointMake(minusLabel.bounds.size.width * 0.5, frame.size.height * 0.5)
        minusLabel.text = "-"
        minusLabel.textColor = incrementAndDecrementLabelTextColor
        minusLabel.font = incrementAndDecrementLabelFont
        minusLabel.textAlignment = NSTextAlignment.Center
        sliderContainer.addSubview(minusLabel)
        
        plusLabel.frame = CGRectMake(0.0, 0.0, frame.size.width * 0.25, frame.size.height)
        plusLabel.center = CGPointMake(frame.size.width - plusLabel.bounds.size.width * 0.5, frame.size.height * 0.5)
        plusLabel.text = "+"
        plusLabel.textColor = incrementAndDecrementLabelTextColor
        plusLabel.font = incrementAndDecrementLabelFont
        plusLabel.textAlignment = NSTextAlignment.Center
        sliderContainer.addSubview(plusLabel)
        
        sliderView.frame = CGRectMake(0.0, 0.0, frame.size.width * 0.5, frame.size.height)
        sliderView.center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5)
        sliderContainer.addSubview(sliderView)
        
        sliderViewLabel.frame = CGRectMake(0.0, 0.0, sliderView.bounds.size.width, sliderView.bounds.size.height)
        sliderViewLabel.center = CGPointMake(sliderViewLabel.bounds.size.width * 0.5, sliderViewLabel.bounds.size.height * 0.5)
        sliderViewLabel.userInteractionEnabled = false
        sliderViewLabel.backgroundColor = sliderColor
        sliderViewLabel.font = sliderTitleFont
        sliderViewLabel.text = sliderTitleText
        sliderViewLabel.textAlignment = NSTextAlignment.Center
        sliderViewLabel.textColor = sliderTitleColor
        sliderView.addSubview(sliderViewLabel)
        
        sliderPanGestureRecogniser.addTarget(self, action: NSSelectorFromString("handleGesture:"))
        sliderView.addGestureRecognizer(sliderPanGestureRecogniser)

        sliderContainer.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
        self.addSubview(sliderContainer)
        self.clipsToBounds = true
    }
    
    required init(coder aDecoder: NSCoder) {

        incrementAndDecrementLabelFont = defaultIncrementAndDecrementLabelsFont
        incrementAndDecrementBackgroundColor = defaultIncrementAndDecrementLabelsBackgroundColor
        incrementAndDecrementLabelTextColor = UIColor.darkTextColor()
        
        sliderColor = defaultSliderColor
        sliderTitleFont = defaultSliderTitleFont
        sliderTitleColor = defaultSliderTitleColor
        sliderTitleText = defaultsliderTitleText
        
        sliderCornerRadius = defaultCornerRadius

        super.init(coder: aDecoder)
        
        self.backgroundColor = backgroundColor
        sliderContainer.backgroundColor = backgroundColor
        
        minusLabel.frame = CGRectMake(0.0, 0.0, frame.size.width * 0.25, frame.size.height)
        minusLabel.center = CGPointMake(minusLabel.bounds.size.width * 0.5, frame.size.height * 0.5)
        minusLabel.text = "-"
        minusLabel.textColor = incrementAndDecrementLabelTextColor
        minusLabel.font = incrementAndDecrementLabelFont
        minusLabel.textAlignment = NSTextAlignment.Center
        sliderContainer.addSubview(minusLabel)
        
        plusLabel.frame = CGRectMake(0.0, 0.0, frame.size.width * 0.25, frame.size.height)
        plusLabel.center = CGPointMake(frame.size.width - plusLabel.bounds.size.width * 0.5, frame.size.height * 0.5)
        plusLabel.text = "+"
        plusLabel.textColor = incrementAndDecrementLabelTextColor
        plusLabel.font = incrementAndDecrementLabelFont
        plusLabel.textAlignment = NSTextAlignment.Center
        sliderContainer.addSubview(plusLabel)
        
        sliderView.frame = CGRectMake(0.0, 0.0, frame.size.width * 0.5, frame.size.height)
        sliderView.center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5)
        sliderContainer.addSubview(sliderView)
        
        sliderViewLabel.frame = CGRectMake(0.0, 0.0, sliderView.bounds.size.width, sliderView.bounds.size.height)
        sliderViewLabel.center = CGPointMake(sliderViewLabel.bounds.size.width * 0.5, sliderViewLabel.bounds.size.height * 0.5)
        sliderViewLabel.userInteractionEnabled = false
        sliderViewLabel.backgroundColor = sliderColor
        sliderViewLabel.font = sliderTitleFont
        sliderViewLabel.text = sliderTitleText
        sliderViewLabel.textAlignment = NSTextAlignment.Center
        sliderViewLabel.textColor = sliderTitleColor
        sliderView.addSubview(sliderViewLabel)
        
        sliderPanGestureRecogniser.addTarget(self, action: NSSelectorFromString("handleGesture:"))
        sliderView.addGestureRecognizer(sliderPanGestureRecogniser)
        
        sliderContainer.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
        self.addSubview(sliderContainer)
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if snappingBehavior?.snappingPoint.x != self.center.x {
        
            snappingBehavior = SliderSnappingBehavior(item: sliderView, snapToPoint: CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5))
            lastDelegateFireOffset = sliderView.center.x
        }
        
        sliderContainer.frame = self.frame
        sliderContainer.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
        sliderContainer.backgroundColor = incrementAndDecrementBackgroundColor
        
        minusLabel.frame = CGRectMake(0.0, 0.0, self.bounds.size.width * 0.25, self.bounds.size.height)
        minusLabel.center = CGPointMake(minusLabel.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
        minusLabel.backgroundColor = incrementAndDecrementBackgroundColor
        minusLabel.font = incrementAndDecrementLabelFont
        minusLabel.textColor = incrementAndDecrementLabelTextColor
        
        plusLabel.frame = CGRectMake(0.0, 0.0, self.bounds.size.width * 0.25, self.bounds.size.height)
        plusLabel.center = CGPointMake(self.bounds.size.width - plusLabel.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
        plusLabel.backgroundColor = incrementAndDecrementBackgroundColor
        plusLabel.font = incrementAndDecrementLabelFont
        plusLabel.textColor = incrementAndDecrementLabelTextColor
        
        sliderView.frame = CGRectMake(0.0, 0.0, self.bounds.size.width * 0.5, self.bounds.size.height)
        sliderView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
        sliderView.backgroundColor = sliderColor
        
        sliderViewLabel.frame = CGRectMake(0.0, 0.0, sliderView.bounds.size.width, sliderView.bounds.size.height)
        sliderViewLabel.center = CGPointMake(sliderViewLabel.bounds.size.width * 0.5, sliderViewLabel.bounds.size.height * 0.5)
        sliderViewLabel.backgroundColor = sliderColor
        sliderViewLabel.font = defaultSliderTitleFont
        sliderViewLabel.text = sliderTitleText
        
        self.layer.cornerRadius = sliderCornerRadius
    }
    
    // MARK: Gesture Handling
    
    final func handleGesture(sender: UIGestureRecognizer) {

        if sender as NSObject == sliderPanGestureRecogniser {
        
            switch (sender.state) {
             
            case .Began:
                
                isCurrentDraggingSlider = true
                touchesBeganPoint = sliderPanGestureRecogniser.translationInView(sliderView)
                dynamicButtonAnimator.removeBehavior(snappingBehavior)
                
            case .Changed:
                
                let translationInView = sliderPanGestureRecogniser.translationInView(sliderView)
                let translatedCenterX:CGFloat = (self.bounds.size.width * 0.5) + ((touchesBeganPoint.x + translationInView.x) * 0.40)
                sliderView.center = CGPointMake(translatedCenterX, sliderView.center.y);
                
                if (translatedCenterX < lastDelegateFireOffset) {
                    
                    if (fabs(self.lastDelegateFireOffset - translatedCenterX) >= (sliderView.bounds.size.width * 0.15)) {
                        
                        self.delegate?.snappingSliderDidDecrementValue(self)
                        lastDelegateFireOffset = translatedCenterX
                    }
                }
                else {
                    
                    if (fabs(lastDelegateFireOffset - translatedCenterX) >= (sliderView.bounds.size.width * 0.15)) {
                        
                        self.delegate?.snappingSliderDidIncrementValue(self)
                        lastDelegateFireOffset = translatedCenterX
                    }
                }
                
            case .Ended:
                
                self.dynamicButtonAnimator.addBehavior(snappingBehavior)
                isCurrentDraggingSlider = false
                lastDelegateFireOffset = self.center.x
                
            case .Failed:
                
                self.dynamicButtonAnimator.addBehavior(snappingBehavior)
                isCurrentDraggingSlider = false
                lastDelegateFireOffset = self.center.x
                
            case .Possible:
                
                println("")
                
            case .Cancelled:
                
                self.dynamicButtonAnimator.addBehavior(snappingBehavior)
                isCurrentDraggingSlider = false
                lastDelegateFireOffset = self.center.x
            }
        }
        
    }
    
}

final class SliderSnappingBehavior: UIDynamicBehavior {
 
    let snappingPoint:CGPoint
    init(item: UIDynamicItem, snapToPoint point: CGPoint) {
    
        let dynamicItemBehavior:UIDynamicItemBehavior  = UIDynamicItemBehavior(items: [item])
        dynamicItemBehavior.allowsRotation = false
        
        let snapBehavior:UISnapBehavior = UISnapBehavior(item: item, snapToPoint: point)
        snapBehavior.damping = 0.25
        
        snappingPoint = point
        
        super.init()
        
        self.addChildBehavior(dynamicItemBehavior)
        self.addChildBehavior(snapBehavior)
    }
}