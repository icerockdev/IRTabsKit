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
- Add data source object (realization of protocol `IRTabsDataSource`), predefined data sources:
  - `IRViewControllersTabsDataSource` - use it if you want `UIViewController` in tabs content:
    - For fill data source in storyboard use `IRTabSegue` from `IRTabsViewController` to tabs view controllers, with identifiers `IRTab0`, `IRTab1`, etc;
    - For tab name used `title` property of `UIViewController`.
  - `IRViewsTabsDataSource` - use it if you want `UIView` in tabs:
    - For fill data source in storyboard use `views` outlet collection of data source;
    - For tab name used `accesebilityLabel` of tab view.
- Link outlet `dataSource` of `IRTabsViewController` to data source object.

### Without storyboard

- Create `IRTabsViewController`;
- Add subview `IRTabsContainerView` & link to `tabsContainerView` outlet;
- Optionally add subview `IRTabsView` & link to `tabsView` outlet;
- Add data source object (realization of protocol `IRTabsDataSource`), predefined data sources:
  - `IRViewControllersTabsDataSource` - use it if you want `UIViewController` in tabs content:
    - For fill data source in code use `viewControllers` property of data source;
    - For tab name used `title` property of `UIViewController`.
  - `IRViewsTabsDataSource` - use it if you want `UIView` in tabs:
    - For fill data source in code use `views` property of data source;
    - For tab name used `accesebilityLabel` of tab view.
- Link outlet `dataSource` of `IRTabsViewController` to data source object.

## Customization

### Change transition style

`IRTabsController` implementation realize transitions of tabs. Now added 2 implementations:
- `IRSwipeTabsController` (default) - moving between tabs by swipe left/right gesture, with fade in/out animation;
- `IRPagedScrollTabsController` - moving between tabs by scroll them like `UIPageViewController` or Android's `ViewPager`.
For use non default controller set it to `tabsController` outlet of `IRTabsViewController`.

### Change tabs view

Default tab view it's UIButton. 
For change tabs buttons you can use Nib file - set name of nib file in `tabNibFile` field of `IRTabsDataSource` (owner in Nib should be `IRSimpleViewOwner` and should have `view` outlet linked).
If root view of tab view be `IRTabView` subclass then properties `title` & `selected` will be automatic set. 


### Change tabs selection indicator view

Default selection indicator is off. You can add it by:
- Nib file - set name of nib file in `selectedIndicatorNibFile` field of `IRTabsView` (owner in Nib should be `IRSimpleViewOwner` and should have `view` outlet linked);

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
