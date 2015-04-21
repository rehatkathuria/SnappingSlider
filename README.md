# SnappingSlider

A beautiful slider control for iOS.

<h3 align="center">
  <img src="http://i.imgur.com/D6IsT2r.gif" alt="Look at that beauty!" />
</h3>

## Installation
There are two ways to add the control to your project; you can add it as a submodule if you're using GIT as a versioning system or you can install it through CocoaPods. Examples of both are outlined below.

`git submodule add https://github.com/rehatkathuria/SnappingSlider`

`pod "SnappingSlider"`

## Usage
It's simple, really. In essence, all you need to do is instantiate a slider with a title and conform to the delegate offered.

```swift
let slider = SnappingSlider(frame: CGRectMake(0.0, 0.0, 10.0, 10.0), title: "Slide Me")
slider.delegate = self

myAwesomeViewController.view.addSubView = slider


...


func snappingSliderDidIncrementValue(snapSwitch: SnappingSlider) {

}

func snappingSliderDidDecrementValue(snapSwitch: SnappingSlider) {

}
```

## Author
This control has been open-sourced by [Rehat Kathuria](http://kthr.co). You can follow him on twitter, [here](http://twitter.com/rehatkat), and hire him for freelance projects, [here](mailto:rehat@kathuria.co).
    
## License & Other Boring Stuff
Licensed under MIT. If you use the control somewhere, [do let me know](http://twitter.com/rehatkat). I'd love to see it out in the wild.
