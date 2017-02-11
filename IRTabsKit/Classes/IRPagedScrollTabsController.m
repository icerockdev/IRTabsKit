//
//  IRPagedScrollTabsController.m
//  IRTabsKit
//
//  Created by Aleksey Mikhailov on 07/02/2017.
//
//

#import "IRPagedScrollTabsController.h"
#import "IRTabsContainerView.h"
#import "IRTabsViewController.h"
#import "IRTabsView.h"

@interface IRPagedScrollTabsController()

@property (nonatomic, weak) IRTabsContainerView *tabsContainerView;
@property (nonatomic, weak) IRTabsView *tabsView;

@end

@implementation IRPagedScrollTabsController

- (void)viewDidLoad:(IRTabsViewController *)tabsViewController {
  IRTabsContainerView *tabsContainerView = tabsViewController.tabsContainerView;
  NSArray<UIViewController *> *viewControllers = tabsViewController.viewControllers;

  tabsContainerView.bounces = false;
  tabsContainerView.pagingEnabled = true;
  tabsContainerView.canCancelContentTouches = false;

  [tabsContainerView addObserver:self
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew
                         context:nil];

  // remove subviews
  while (tabsContainerView.subviews.count > 0) {
    [tabsContainerView.subviews[0] removeFromSuperview];
  }

  // add pages
  for (NSUInteger i = 0; i < viewControllers.count;i++) {
    UIViewController *viewController = viewControllers[i];
    UIView* view = viewController.view;

    [tabsViewController addChildViewController:viewController];

    [tabsContainerView addSubview:view];

    [viewController didMoveToParentViewController:tabsViewController];
  }

  [tabsViewController.tabsView populateWithViewControllers:viewControllers];
  [tabsViewController.tabsView setTabsController:self];

  self.tabsContainerView = tabsContainerView;
  self.tabsView = tabsViewController.tabsView;
}

- (void) dealloc {
  [self.tabsContainerView removeObserver:self
                              forKeyPath:@"contentOffset"
                                 context:nil];
}

- (NSUInteger)selectedTab {
  return (NSUInteger)ceil(self.tabsContainerView.contentOffset.x / self.tabsContainerView.bounds.size.width);
}

- (void)setSelectedTab:(NSUInteger)selectedTab {
  [self.tabsContainerView setContentOffset:CGPointMake(self.tabsContainerView.bounds.size.width * selectedTab,
                                                       self.tabsContainerView.contentInset.top)
                                  animated:true];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
  CGSize size = self.tabsContainerView.bounds.size;

  [self.tabsView setSelectedIndicatorPosition:(offset.x / size.width)];
}

@end
