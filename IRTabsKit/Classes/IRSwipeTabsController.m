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
#import "IRTabsDataSource.h"

double kDefaultTransitionDuration = 0.35;

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
  [super viewDidLoad:tabsViewController];

  IRTabsContainerView *tabsContainerView = tabsViewController.tabsContainerView;

  tabsContainerView.scrollEnabled = false;
  tabsContainerView.scrollsToTop = false;
  tabsContainerView.bounces = false;

  [self addSwipeGestureRecognizerWithDirection:UISwipeGestureRecognizerDirectionRight
                                        toView:tabsContainerView];
  [self addSwipeGestureRecognizerWithDirection:UISwipeGestureRecognizerDirectionLeft
                                        toView:tabsContainerView];

  [self reloadData];
}

- (void)reloadData {
  id <IRTabsDataSource> dataSource = self.tabsDataSource;

  if (dataSource != nil) {
    NSUInteger count = [dataSource numberOfTabsInTabsController:self];

    NSMutableArray *tabContentViews = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
      tabContentViews[i] = [dataSource tabsController:self viewAtIndex:i];
      [tabContentViews[i] setHidden:true];
    }

    self.tabsContainerView.tabContentViews = [NSArray arrayWithArray:tabContentViews];

    if (count > 0) {
      [self setSelectedTab:0];
    }
  }

  [super reloadData];
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
  NSUInteger currentIdx = self.selectedTab;

  if (currentIdx == NSNotFound) {
    // this may be in moment when transition between child controllers not done
    return;
  }

  id <IRTabsDataSource> dataSource = self.tabsDataSource;
  NSUInteger count = [dataSource numberOfTabsInTabsController:self];

  switch (swipeGestureRecognizer.direction) {
    case UISwipeGestureRecognizerDirectionRight: {
      NSUInteger newIdx;
      if (currentIdx == 0) {
        if (!self.infinite.boolValue) {
          break;
        }
        newIdx = count - 1;
      } else {
        newIdx = currentIdx - 1;
      }
      [self setSelectedTab:newIdx];
      break;
    }
    case UISwipeGestureRecognizerDirectionLeft: {
      NSUInteger newIdx = currentIdx + 1;
      if (newIdx == count) {
        if (!self.infinite.boolValue) {
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

- (void)setSelectedTab:(NSUInteger)selectedTab {
  NSUInteger oldSelectedTab = self.selectedTab;

  IRTabsViewController *tabsViewController = self.tabsViewController;
  IRTabsContainerView *containerView = self.tabsContainerView;
  IRTabsView *tabsView = self.tabsView;
  id <IRTabsDataSource> dataSource = self.tabsDataSource;

  if (oldSelectedTab != NSNotFound &&
      [dataSource respondsToSelector:@selector(tabsController:viewWillRemovedAtIndex:withTabsViewController:)]) {
    [dataSource tabsController:self
         viewDidRemovedAtIndex:oldSelectedTab
        withTabsViewController:tabsViewController];
  }
  if ([dataSource respondsToSelector:@selector(tabsController:viewWillAppendAtIndex:withTabsViewController:)]) {
    [dataSource tabsController:self
         viewWillAppendAtIndex:selectedTab
        withTabsViewController:tabsViewController];
  }

  UIView* tabContentView = containerView.tabContentViews[selectedTab];
  tabContentView.hidden = false;
  [containerView layoutIfNeeded];
  tabContentView.frame = containerView.bounds;

  if(oldSelectedTab != NSNotFound) {
    UIView* oldTabContentView = containerView.tabContentViews[oldSelectedTab];
    oldTabContentView.frame = containerView.bounds;
    tabContentView.alpha = 0.0f;

    [UIView animateWithDuration:[self.transitionDuration doubleValue]
                     animations:^{
                         [tabsView setSelectedIndicatorPosition:selectedTab];
                         [tabsView layoutIfNeeded];

                         tabContentView.alpha = 1.0f;
                         oldTabContentView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         oldTabContentView.hidden = true;

                         if ([dataSource respondsToSelector:@selector(tabsController:viewDidAppendAtIndex:withTabsViewController:)]) {
                           [dataSource tabsController:self
                                 viewDidAppendAtIndex:selectedTab
                               withTabsViewController:tabsViewController];
                         }
                         if ([dataSource respondsToSelector:@selector(tabsController:viewDidRemovedAtIndex:withTabsViewController:)]) {
                           [dataSource tabsController:self
                                viewDidRemovedAtIndex:oldSelectedTab
                               withTabsViewController:tabsViewController];
                         }

                         [super setSelectedTab:selectedTab];
                     }];
  } else {
    if ([dataSource respondsToSelector:@selector(tabsController:viewDidAppendAtIndex:withTabsViewController:)]) {
      [dataSource tabsController:self
            viewDidAppendAtIndex:selectedTab
          withTabsViewController:tabsViewController];
    }

    [super setSelectedTab:selectedTab];
  }
}

- (void)addSwipeGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection)direction
                                        toView:(UIView *)view {
  UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(swipeGesture:)];

  swipeGestureRecognizer.direction = direction;

  [view addGestureRecognizer:swipeGestureRecognizer];
}

@end
