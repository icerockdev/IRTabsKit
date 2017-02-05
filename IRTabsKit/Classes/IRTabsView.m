//
//  IRTabsView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabsView.h"
#import "IRTabViewOwner.h"

@implementation IRTabsView

- (void)populateWithViewControllers:(NSArray<UIViewController *> *)viewControllers {
  UIView *lastView = nil;

  // remove subviews
  while(self.subviews.count > 0) {
    [self.subviews[0] removeFromSuperview];
  }

  for (NSUInteger i = 0; i < viewControllers.count; i++) {
    UIView *view = [self createViewForTabWithViewController:viewControllers[i]];
    view.translatesAutoresizingMaskIntoConstraints = false;

    [self addSubview:view];

    // constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeTopMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTopMargin
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeBottomMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottomMargin
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeLeadingMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:(lastView == nil ? self : lastView)
                                                     attribute:(lastView == nil ?
                                                         NSLayoutAttributeLeadingMargin :
                                                         NSLayoutAttributeTrailingMargin)
                                                    multiplier:1.0
                                                      constant:0]];

    if(lastView != nil) {
      [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:lastView
                                                       attribute:NSLayoutAttributeWidth
                                                      multiplier:1.0
                                                        constant:0]];
    }

    lastView = view;
  }

  if(lastView != nil) {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lastView
                                                     attribute:NSLayoutAttributeTrailingMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailingMargin
                                                    multiplier:1.0
                                                      constant:0]];
  }
}

- (UIView *)createViewForTabWithViewController:(UIViewController *)viewController {
  if (self.tabNibFile != nil) {
    IRTabViewOwner *viewOwner = [IRTabViewOwner new];
    [[UINib nibWithNibName:self.tabNibFile
                    bundle:nil] instantiateWithOwner:viewOwner
                                             options:nil];

    viewOwner.titleLabel.text = [self tabTitleWithViewController:viewController];

    return viewOwner.view;
  } else if (self.delegate != nil) {
    UIView *view = [self.delegate createTabViewWithViewController:viewController];
    return view;
  } else {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:[self tabTitleWithViewController:viewController]
            forState:UIControlStateNormal];
    return button;
  }
}

- (NSString *)tabTitleWithViewController:(UIViewController *)viewController {
  return viewController.title;
}

@end
