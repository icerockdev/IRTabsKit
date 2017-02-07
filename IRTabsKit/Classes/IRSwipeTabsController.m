//
//  IRSwipeTabsController.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRSwipeTabsController.h"
#import "IRTabsViewController.h"
#import "IRTabsContainerView.h"
#import "IRTabsView.h"

double kDefaultTransitionDuration = 0.35;

@interface IRSwipeTabsController ()

@property(weak) IRTabsViewController *tabsViewController;
@property UIViewController *currentTabViewController;
@property bool transitionInProgress;

@end

@implementation IRSwipeTabsController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.transitionDuration = @(kDefaultTransitionDuration);
  }
  return self;
}

- (void)viewDidLoad:(IRTabsViewController *)tabsViewController {
  self.tabsViewController = tabsViewController;

  IRTabsContainerView *tabsContainerView = tabsViewController.tabsContainerView;

  tabsContainerView.scrollEnabled = false;
  tabsContainerView.scrollsToTop = false;
  tabsContainerView.bounces = false;

  [self addSwipeGestureRecognizerWithDirection:UISwipeGestureRecognizerDirectionRight
                                        toView:tabsContainerView];
  [self addSwipeGestureRecognizerWithDirection:UISwipeGestureRecognizerDirectionLeft
                                        toView:tabsContainerView];

  if (tabsViewController.viewControllers.count > 0) {
    UIViewController *pageViewController = tabsViewController.viewControllers[0];

    [tabsViewController addChildViewController:pageViewController];

    UIView *pageView = pageViewController.view;
    pageView.frame = tabsContainerView.bounds;

    [tabsContainerView addSubview:pageView];

    [pageViewController didMoveToParentViewController:tabsViewController];

    self.currentTabViewController = pageViewController;
  }

  IRTabsView *tabsView = tabsViewController.tabsView;

  [tabsView populateWithViewControllers:tabsViewController.viewControllers];
  [tabsView setTabsController:self];
}

- (void)tabSelected:(NSUInteger)tabIndex {
  [self setCurrentTab:tabIndex];
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
  NSArray<UIViewController *> *viewControllers = self.tabsViewController.viewControllers;

  if (viewControllers.count == 0) {
    return;
  }

  NSUInteger currentIdx = [viewControllers indexOfObject:self.currentTabViewController];

  if (currentIdx == NSNotFound) {
    // this may be in moment when transition between child controllers not done
    return;
  }

  switch (swipeGestureRecognizer.direction) {
    case UISwipeGestureRecognizerDirectionRight: {
      NSUInteger newIdx;
      if (currentIdx == 0) {
        newIdx = viewControllers.count - 1;
      } else {
        newIdx = currentIdx - 1;
      }
      [self setCurrentTab:newIdx];
      break;
    }
    case UISwipeGestureRecognizerDirectionLeft: {
      NSUInteger newIdx = currentIdx + 1;
      if (newIdx == viewControllers.count) {
        newIdx = 0;
      }
      [self setCurrentTab:newIdx];
      break;
    }
    default:
      break;
  }
}

- (void)setCurrentTab:(NSUInteger)tabIdx {
  if(self.transitionInProgress) {
    return;
  }

  self.transitionInProgress = true;

  UIViewController *pageViewController = self.tabsViewController.viewControllers[tabIdx];

  [self.currentTabViewController willMoveToParentViewController:nil];
  [self.tabsViewController addChildViewController:pageViewController];

  UIView *tabsContainerView = self.tabsViewController.tabsContainerView;
  UIView *pageView = pageViewController.view;
  pageView.frame = tabsContainerView.bounds;

  [self.tabsViewController transitionFromViewController:self.currentTabViewController
                                       toViewController:pageViewController
                                               duration:[self.transitionDuration doubleValue]
                                                options:UIViewAnimationOptionTransitionCrossDissolve
                                             animations:^() {
                                                 [self.tabsViewController.tabsView setSelectedTab:tabIdx];
                                             }
                                             completion:^(BOOL finished) {
                                                 [self.currentTabViewController removeFromParentViewController];
                                                 [pageViewController didMoveToParentViewController:self.tabsViewController];

                                                 self.currentTabViewController = pageViewController;

                                                 self.transitionInProgress = false;
                                             }];
}

- (void)addSwipeGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection)direction
                                        toView:(UIView *)view {
  UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(swipeGesture:)];

  swipeGestureRecognizer.direction = direction;

  [view addGestureRecognizer:swipeGestureRecognizer];
}

@end
