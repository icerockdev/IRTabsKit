//
//  IRTabsView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabsView.h"
#import "IRTabViewOwner.h"
#import "IRSelectedIndicatorViewOwner.h"
#import "IRTabsController.h"

@interface IRTabsView ()

@property(nonatomic) NSArray<UIView *> *tabViews;
@property(nonatomic, weak) UIView *selectedIndicatorView;
@property(nonatomic, weak) NSLayoutConstraint *selectedIndicatorHorizontalPositionConstraint;

@end

// FIXME: change to manual layout (unnecessary autolayout constraints hell)
@implementation IRTabsView

- (void)populateWithViewControllers:(NSArray<UIViewController *> *)viewControllers {
  UIView *lastView = nil;

  // remove subviews
  while (self.subviews.count > 0) {
    [self.subviews[0] removeFromSuperview];
  }

  NSMutableArray<UIView *> *tabViews = [NSMutableArray arrayWithCapacity:viewControllers.count];

  for (NSUInteger i = 0; i < viewControllers.count; i++) {
    UIView *view = [self createViewForTabWithViewController:viewControllers[i]];
    view.translatesAutoresizingMaskIntoConstraints = false;
    view.tag = i;

    UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tabPressed:)];
    [view addGestureRecognizer:tapGestureRecognizer];

    tabViews[i] = view;

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

    if (lastView != nil) {
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

  if (lastView != nil) {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:lastView
                                                     attribute:NSLayoutAttributeTrailingMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailingMargin
                                                    multiplier:1.0
                                                      constant:0]];
  }

  self.tabViews = [NSArray arrayWithArray:tabViews];

  if (self.selectedIndicatorView == nil) {
    if (self.selectedIndicatorNibFile != nil) {
      IRSelectedIndicatorViewOwner *viewOwner = [IRSelectedIndicatorViewOwner new];
      [[UINib nibWithNibName:self.selectedIndicatorNibFile
                      bundle:nil] instantiateWithOwner:viewOwner
                                               options:nil];
      viewOwner.view.translatesAutoresizingMaskIntoConstraints = false;

      self.selectedIndicatorView = viewOwner.view;
    } if(self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(createSelectedIndicatorView)]) {
      self.selectedIndicatorView = [self.delegate createSelectedIndicatorView];
    }
  }

  if (self.selectedIndicatorView != nil && lastView != nil) {
    [self addSubview:self.selectedIndicatorView];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:lastView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.selectedIndicatorView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:lastView
                                                     attribute:NSLayoutAttributeBottomMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.selectedIndicatorView
                                                     attribute:NSLayoutAttributeBottomMargin
                                                    multiplier:1.0
                                                      constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:lastView
                                                     attribute:NSLayoutAttributeTopMargin
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.selectedIndicatorView
                                                     attribute:NSLayoutAttributeTopMargin
                                                    multiplier:1.0
                                                      constant:0]];
  }

  [self setSelectedTab:self.selectedTab];
}

- (void)tabPressed:(UITapGestureRecognizer*)tapGestureRecognizer {
  [self.tabsController tabSelected:(NSUInteger) tapGestureRecognizer.view.tag];
}

- (UIView *)createViewForTabWithViewController:(UIViewController *)viewController {
  if (self.tabNibFile != nil) {
    IRTabViewOwner *viewOwner = [IRTabViewOwner new];
    [[UINib nibWithNibName:self.tabNibFile
                    bundle:nil] instantiateWithOwner:viewOwner
                                             options:nil];

    viewOwner.titleLabel.text = [self tabTitleWithViewController:viewController];

    return viewOwner.view;
  } else if (self.delegate != nil && [self.delegate respondsToSelector:@selector(createSelectedIndicatorView)]) {
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

- (NSLayoutConstraint*) indicatorHorizontalPositionConstraintWithPosition:(CGFloat)position {
  CGFloat tabWidthMultiplier = 2.0f / self.tabViews.count;
  CGFloat multiplier = tabWidthMultiplier * position + (tabWidthMultiplier / 2.0f);
  return [NSLayoutConstraint constraintWithItem:self.selectedIndicatorView
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeCenterX
                                     multiplier:multiplier
                                       constant:0];
}

- (void)setSelectedTab:(NSUInteger)selectedTab {
  _selectedTab = selectedTab;

  [self setSelectedIndicatorPosition:selectedTab];
}

- (void)setSelectedIndicatorPosition:(CGFloat)selectedIndicatorPosition {

  if(self.selectedIndicatorHorizontalPositionConstraint != nil) {
    [self removeConstraint:self.selectedIndicatorHorizontalPositionConstraint];
  }

  self.selectedIndicatorHorizontalPositionConstraint =
      [self indicatorHorizontalPositionConstraintWithPosition:selectedIndicatorPosition];

  [self addConstraint:self.selectedIndicatorHorizontalPositionConstraint];

  [self setNeedsLayout];
  [self layoutIfNeeded];
}

@end
