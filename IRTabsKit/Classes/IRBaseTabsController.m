//
//  IRBaseTabsController.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 11.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRBaseTabsController.h"
#import "IRTabsView.h"
#import "IRTabsDataSource.h"
#import "IRTabsContainerView.h"
#import "IRTabsViewController.h"

@implementation IRBaseTabsController

- (instancetype)init {
  self = [super init];
  if(self) {
    _selectedTab = NSNotFound;
  }
  return self;
}

- (void)viewDidLoad:(IRTabsViewController *)tabsViewController {
  _tabsViewController = tabsViewController;
}

- (void)reloadData {
  IRTabsView *tabsView = self.tabsView;
  id <IRTabsDataSource> dataSource = self.tabsDataSource;

  if(tabsView != nil) {
    tabsView.tabViews = nil;
    tabsView.selectedTabIndicatorView = nil;
  }

  if (dataSource != nil) {
    NSUInteger count = [dataSource numberOfTabsInTabsController:self];

    if(tabsView != nil) {
      NSMutableArray *tabViews = [NSMutableArray arrayWithCapacity:count];
      for (NSUInteger i = 0; i < count; i++) {
        UIView* view = [dataSource tabsController:self tabViewAtIndex:i];

        view.tag = i;

        UITapGestureRecognizer *tapGestureRecognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(tabPressed:)];
        [view addGestureRecognizer:tapGestureRecognizer];

        tabViews[i] = view;
      }

      tabsView.tabViews = [NSArray arrayWithArray:tabViews];
      tabsView.selectedTabIndicatorView = [dataSource selectedTabIndicatorInTabsController:self];
    }
  }
}

- (IRTabsContainerView *)tabsContainerView {
  return self.tabsViewController.tabsContainerView;
}

- (IRTabsView *)tabsView {
  return self.tabsViewController.tabsView;
}

- (id <IRTabsDataSource>)tabsDataSource {
  return self.tabsViewController.tabsDataSource;
}

- (void)tabPressed:(UITapGestureRecognizer*)tapGestureRecognizer {
  self.selectedTab = (NSUInteger) tapGestureRecognizer.view.tag;
}

@end
