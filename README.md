# Twitter style opening transition

![][gif]

## Create a Launch Screen
Grab the Twitter logo which you can download from Twitter's [Brand Resources][brand-resources] page, add it to the asset library and using constraints centre it in the `LaunchScreen.storyboard`

Apple will instantly transition from this to the project start page.

![][png]

<a href="https://github.com/cmilhench/custom-transition-twitter/commit/16fe654" target="_blank">16fe654</a>

## Add Splash ViewController
A view to transition from—which matches the launch screen—is needed. Duplicate the launch screen in the `Main.storyboard` and ensure it's set as the storyboard entry point. 

Add a backing class and immediately present your main applications starting page in the `viewDidAppear`.

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "mainApplication")
    self.present(controller, animated: true, completion: nil)
}
```

**Note**: *Remember to add a `Storyboard ID` to be able to instantiate your applications starting page.*

<a href="https://github.com/cmilhench/custom-transition-twitter/commit/2d2cf65" target="_blank">2d2cf65</a>

## Implement custom transition

All of the custom transition code will be added to a single class that implements `UIViewControllerAnimatedTransitioning`.

```swift
class SplashTransition: NSObject, UIViewControllerTransitioningDelegate {
}
```

The transition class is wired up via a delegate.

```swift
override func viewDidAppear(_ animated: Bool) {
	//...
	controller.transitioningDelegate = transition
	self.present(controller, animated: true, completion: nil)
}
```

And will need to be a strong reference so that it's not immediately deallocated.

```swift
fileprivate var transition: SplashTransition?

override func viewDidLoad() {
    super.viewDidLoad()
    self.transition = SplashTransition()
}
```

Replicating the basic animation it is fairly easy, implemented as a CALayer mask on the destination view.

```swift
let start = UIBezierPath(ovalIn: frame).cgPath
let layer = CAShapeLayer()
layer.path = start;
layer.add(animation, forKey: "path")
toView.layer.mask = layer
```

With the animation simply increasing to a size larger than the destination view.

```swift
let finish = UIBezierPath.init(ovalIn: frame.insetBy(dx: -radius, dy: -radius)).cgPath
let animation = CAKeyframeAnimation.init(keyPath: "path")
animation.duration = 0.7
animation.timingFunctions = [CAMediaTimingFunction(name:.easeInEaseOut)]
animation.values = [start, finish];
animation.keyTimes = [0, 0.7]
```

<a href="https://github.com/cmilhench/custom-transition-twitter/commit/5594ebd" target="_blank">5594ebd</a>

## Update the custom transition Mask

Finally—for extra merit—change the `CAShapeLayer` to a simple `CALayer`, add the image and animate it's bounds

<a href="https://github.com/cmilhench/custom-transition-twitter/commit/a5d48a0" target="_blank">a5d48a0</a>

[gif]: loading.gif
[png]: loading.png
[mp4]: loading.mp4
[brand-resources]: https://about.twitter.com/en_gb/company/brand-resources.html