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
#import "IRTabsDataSource.h"

@interface IRPagedScrollTabsController () {
  IRTabsContainerView *_tabsContainerView;
}

@end

@implementation IRPagedScrollTabsController

- (void)viewDidLoad:(IRTabsViewController *)tabsViewController {
  [super viewDidLoad:tabsViewController];

  self.tabsContainerView.bounces = false;
  self.tabsContainerView.pagingEnabled = true;
  self.tabsContainerView.canCancelContentTouches = false;

  [self.tabsContainerView addObserver:self
                           forKeyPath:@"contentOffset"
                              options:NSKeyValueObservingOptionNew
                              context:nil];

  _tabsContainerView = self.tabsContainerView;

  [self reloadData];
}

- (void)dealloc {
  [_tabsContainerView removeObserver:self
                             forKeyPath:@"contentOffset"];
}

- (void)reloadData {
  IRTabsViewController *tabsViewController = self.tabsViewController;
  IRTabsContainerView *containerView = tabsViewController.tabsContainerView;
  id <IRTabsDataSource> dataSource = self.tabsDataSource;

  // remove subviews
  containerView.tabContentViews = nil;

  if (dataSource != nil) {
    NSUInteger count = [dataSource numberOfTabsInTabsController:self];

    NSMutableArray *tabContentViews = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
      if ([dataSource respondsToSelector:@selector(tabsController:viewWillAppendAtIndex:withTabsViewController:)]) {
        [dataSource tabsController:self
             viewWillAppendAtIndex:i
            withTabsViewController:tabsViewController];
      }

      tabContentViews[i] = [dataSource tabsController:self viewAtIndex:i];

      if ([dataSource respondsToSelector:@selector(tabsController:viewDidAppendAtIndex:withTabsViewController:)]) {
        [dataSource tabsController:self
              viewDidAppendAtIndex:i
            withTabsViewController:tabsViewController];
      }
    }

    containerView.tabContentViews = [NSArray arrayWithArray:tabContentViews];
  }

  [super reloadData];
}

- (NSUInteger)selectedTab {
  return (NSUInteger) ceil(self.tabsContainerView.contentOffset.x / self.tabsContainerView.bounds.size.width);
}

- (void)setSelectedTab:(NSUInteger)selectedTab {
  [self.tabsContainerView setContentOffset:CGPointMake(
          self.tabsContainerView.bounds.size.width * selectedTab,
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
