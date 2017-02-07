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

@end

@implementation IRPagedScrollTabsController

- (void)viewDidLoad:(IRTabsViewController *)tabsViewController {
  IRTabsContainerView *tabsContainerView = tabsViewController.tabsContainerView;
  NSArray<UIViewController *> *viewControllers = tabsViewController.viewControllers;

  tabsContainerView.showsVerticalScrollIndicator = false;
  tabsContainerView.showsHorizontalScrollIndicator = false;
  tabsContainerView.bounces = false;
  tabsContainerView.pagingEnabled = true;

  UIView *lastView = nil;

  // remove subviews
  while (tabsContainerView.subviews.count > 0) {
    [tabsContainerView.subviews[0] removeFromSuperview];
  }

  // add pages
  for (NSUInteger i = 0; i < viewControllers.count;i++) {
    UIView* view = viewControllers[i].view;
    view.translatesAutoresizingMaskIntoConstraints = false;

    [tabsContainerView addSubview:view];

    [tabsContainerView addConstraint:[NSLayoutConstraint constraintWithItem:tabsContainerView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0f
                                                                   constant:0]];

    [tabsContainerView addConstraint:[NSLayoutConstraint constraintWithItem:tabsContainerView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0f
                                                                   constant:0]];

    [tabsContainerView addConstraint:[NSLayoutConstraint constraintWithItem:tabsContainerView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:0]];

    [tabsContainerView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:(lastView == nil ?
                                                                         tabsContainerView :
                                                                         lastView)
                                                                  attribute:(lastView == nil ?
                                                                      NSLayoutAttributeLeading :
                                                                      NSLayoutAttributeTrailing)
                                                                 multiplier:1.0f
                                                                   constant:0]];

    lastView = view;
  }

  if(lastView != nil) {
    [tabsContainerView addConstraint:[NSLayoutConstraint constraintWithItem:lastView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:tabsContainerView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:0]];
  }

  [tabsViewController.tabsView populateWithViewControllers:viewControllers];
  [tabsViewController.tabsView setTabsController:self];

  self.tabsContainerView = tabsContainerView;
}

- (void)tabSelected:(NSUInteger)tabIndex {
  [self.tabsContainerView setContentOffset:CGPointMake(self.tabsContainerView.bounds.size.width * tabIndex, 0)
                                  animated:true];
}

@end
