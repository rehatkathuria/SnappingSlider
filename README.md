# SnappingSlider
A beautiful slider control for iOS built purely upon Swift.

![Look at that beauty!](http://i.imgur.com/D6IsT2r.gif)

# Usage
It's so simple, a self learning machine could spend a few months cycling and becoming more intelligent before using this control. In essence, all you need to do is instantiate a slider with a title and conform to the delegate offered.


`let slider = SnappingSlider(frame: CGRectMake(0.0, 0.0, 10.0, 10.0), title: "Slide Me")`

`slider.delegate = self`

`myAwesomeViewController.view.addSubView = slider`

    func snappingSliderDidIncrementValue(snapSwitch: SnappingSlider) {
    
    }
    
    func snappingSliderDidDecrementValue(snapSwitch: SnappingSlider) {
    
    }
    
# License & Other Boring Stuff
Feel free to use it as you'd like. Credit is appreciated, but not required. If you use the control somewhere, [do let me know](http://twitter.com/itskathuria). I'd love to see it out in the wild.
