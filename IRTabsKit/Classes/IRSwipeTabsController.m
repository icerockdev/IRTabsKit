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

@end

@implementation IRSwipeTabsController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.transitionDuration = @(kDefaultTransitionDuration);
    self.infinite = @(false);
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

- (void)swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
  NSUInteger currentIdx = self.selectedTab;

  if (currentIdx == NSNotFound) {
    // this may be in moment when transition between child controllers not done
    return;
  }
  
  NSArray<UIViewController *> *viewControllers = self.tabsViewController.viewControllers;
  switch (swipeGestureRecognizer.direction) {
    case UISwipeGestureRecognizerDirectionRight: {
      NSUInteger newIdx;
      if (currentIdx == 0) {
        if(!self.infinite.boolValue) {
          break;
        }
        newIdx = viewControllers.count - 1;
      } else {
        newIdx = currentIdx - 1;
      }
      [self setSelectedTab:newIdx];
      break;
    }
    case UISwipeGestureRecognizerDirectionLeft: {
      NSUInteger newIdx = currentIdx + 1;
      if (newIdx == viewControllers.count) {
        if(!self.infinite.boolValue) {
          break;
        }
        newIdx = 0;
      }
      [self setSelectedTab:newIdx];
      break;
    }
    default:
      break;
  }
}

- (NSUInteger)selectedTab {
  NSArray<UIViewController *> *viewControllers = self.tabsViewController.viewControllers;
  return [viewControllers indexOfObject:self.currentTabViewController];
}

- (void)setSelectedTab:(NSUInteger)selectedTab {
  UIViewController *pageViewController = self.tabsViewController.viewControllers[selectedTab];

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
                                                 [self.tabsViewController.tabsView setSelectedTab:selectedTab];
                                                 [self.tabsViewController.tabsView layoutIfNeeded];
                                             }
                                             completion:^(BOOL finished) {
                                                 [self.currentTabViewController removeFromParentViewController];
                                                 [pageViewController didMoveToParentViewController:self.tabsViewController];

                                                 self.currentTabViewController = pageViewController;
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
