# IRTabsKit

[![CI Status](http://img.shields.io/travis/Alex009/IRTabsKit.svg?style=flat)](https://travis-ci.org/Alex009/IRTabsKit)
[![Version](https://img.shields.io/cocoapods/v/IRTabsKit.svg?style=flat)](http://cocoapods.org/pods/IRTabsKit)
[![License](https://img.shields.io/cocoapods/l/IRTabsKit.svg?style=flat)](http://cocoapods.org/pods/IRTabsKit)
[![Platform](https://img.shields.io/cocoapods/p/IRTabsKit.svg?style=flat)](http://cocoapods.org/pods/IRTabsKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

### With storyboard

- Add view controller to storyboard;
- Set class `IRTabsViewController` - it's host controller for tabs;
- In this controller add view `IRTabsContainerView` - it's container for tabs view controllers;
- Optionally add view `IRTabsView` - it's view for tabs buttons & selection indicator;
- Link outlets of `IRTabsViewController` to container & tabs view;
- Add tabs view controllers to storyboard;
- Add segue `IRTabSegue` from `IRTabsViewController` to tabs view controllers, with identifiers `IRTab0`, `IRTab1`, etc.

### Without storyboard

- Create `IRTabsViewController`;
- Add subview `IRTabsContainerView` & link to `tabsContainerView` outlet;
- Optionally add subview `IRTabsView` & link to `tabsView` outlet;
- Create tabs view controllers and set as array to `viewControllers` property of `IRTabsViewController`.

## Customization

### Change transition style

`IRTabsController` implementation realize transitions of tabs. Now added 2 implementations:
- `IRSwipeTabsController` (default) - moving between tabs by swipe left/right gesture, with fade in/out animation;
- `IRPagedScrollTabsController` - moving between tabs by scroll them like `UIPageViewController` or Android's `ViewPager`.
For use non default controller set it to `tabsController` outlet of `IRTabsViewController`.

### Change tabs view

Default tab view it's UIButton. For change tabs buttons you can use:
- Nib file - set name of nib file in `tabNibFile` field of `IRTabsView` (owner in Nib should be `IRTabViewOwner` and should have `view`, `titleLabel` outlets linked);
- Protocol `IRTabsViewDelegate` implementation - method `createTabViewWithViewController`. Set object in `delegate` field of `IRTabsView`.

### Change tabs selection indicator view

Default selection indicator is off. You can add it by:
- Nib file - set name of nib file in `selectedIndicatorNibFile` field of `IRTabsView` (owner in Nib should be `IRSelectedIndicatorViewOwner` and should have `view` outlet linked);
- Protocol `IRTabsViewDelegate` implementation - method `createSelectedIndicatorView`. Set object in `delegate` field of `IRTabsView`.

## Other

For simple access to `IRTabsViewController` you can use `UIViewController(IRTabsKit)` category's property `tabsViewController`.

## Installation

IRTabsKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "IRTabsKit"
```

## Author

Aleksey Mikhailov, Aleksey.Mikhailov@icerockdev.com

## License

IRTabsKit is available under the MIT license. See the LICENSE file for more info.
