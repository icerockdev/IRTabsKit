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

@interface IRPagedScrollTabsController() <UIScrollViewDelegate>

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
  tabsContainerView.delegate = self;

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

- (void)tabSelected:(NSUInteger)tabIndex {
  [self.tabsContainerView setContentOffset:CGPointMake(self.tabsContainerView.bounds.size.width * tabIndex,
          self.tabsContainerView.contentInset.top)
                                  animated:true];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGPoint offset = scrollView.contentOffset;
  CGSize size = scrollView.bounds.size;

  [self.tabsView setSelectedIndicatorPosition:(offset.x / size.width)];
}

@end
