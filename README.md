
# PlayButton

![](https://img.shields.io/badge/version-1.0-brightgreen.svg)

Simple Dynamic Framework, that contains `UIButton` subclass: `PlayButton` and `UIView` subclass: `PlayButtonView` which at any time can be in 1 of these 4 states:

```swift
// MARK: - Animation States
  
extension  PlayButtonView {
	/// All possible states of the PlayButtonView.
	///
	/// At all time `PlayButtonView`s are in one of these states.
	///
	/// - play: displays a play symbol.
	/// - pause: displays a pause symbol.
	/// - loadPlay: displays a play symbol with a loding indication.
	/// - loadPause: displays a pause symbol with a loding indication.
	public enum State {

		/// displays a play symbol.
		case play
		  
		/// displays a pause symbol.
		case pause
		// displays a play symbol with a loding indication.
		case loadPlay
		  
		// displays a pause symbol with a loding indication.
		case loadPause
	}
}
```

Build using Swift 5, Xcode 10.2, supports iOS 10.0+

# Usage

You can use `PlayButton` and `PlayButtonView` from code by invoking their parent class initializers, or by settings `PlayButton` (for `UIButton`s) and `PlayButtonView` (for `UIView`s) classes to elements in storyboards.

Either of these have the following properties for customization:

```swift
// MARK: Configuration

/// The time it takes for the `PlayButtonView` to switch from one state to another.
///
/// Default value is: 0.7.
@IBInspectable public var stateSwitchDuration: TimeInterval = 0.7

/// The scale factor of the boundary symbol and load symbol during touch interaction.
///
/// Default value is: 1.4.
@IBInspectable public var  maxBoundaryScale: CGFloat = 1.4

/// The color used for the play symbol during no loading, no interaction.
///
/// Default color: `.black`.
@IBInspectable public var playRestColor: UIColor = .black

/// The color used for the play symbol during tap interaction.
///
/// Default color: `.black`.
@IBInspectable public var playTapColor: UIColor = .black

/// The color used for the play symbol during loading.
///
/// Default color: `.black`.
@IBInspectable public var playLoadColor: UIColor = .black

/// The color used for the pause symbol during no loading, no interaction.
///
/// Default color: `.black`.
@IBInspectable public var pauseRestColor: UIColor = .black

/// The color used for the pause symbol during tap interaction.
///
/// Default color: `.black`.
@IBInspectable public var pauseTapColor: UIColor = .black

/// The color used for the pause symbol during loading.
///
/// Default color: `.black`.
@IBInspectable public var pauseLoadColor: UIColor = .black

/// The color used for the boundary circle.
///
/// Default color: `.black`.
@IBInspectable public var boundaryRestColor: UIColor = .black

/// The color used for the loading indicator circle.
///
/// Default color: `.black`.
@IBInspectable public var loadRestColor: UIColor = .black
```

Available from storyboards too, in addition to using them from code.


# Installation

### Carthage Installation

1. In your `Cartfile` add `github "stoqn4opm/PlayButton"`
2. Link the build framework with the target in your XCode project

For detailed instructions check the official Carthage guides [here](https://github.com/Carthage/Carthage)

### Manual Installation

1. Download the project and build the shared target called `PlayButton`
2. Add the product in the list of "embed frameworks" list inside your project's target or create a work space with PlayButton and your project and link directly the product of PlayButton's target to your target "embed frameworks" list

# License

The framework is licensed under MIT license. For more information see file `LICENSE`

