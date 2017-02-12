//
//  IRViewControllersTabsDataSource.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 11.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRViewControllersTabsDataSource.h"
#import "IRTabsViewController.h"

@implementation IRViewControllersTabsDataSource

- (NSUInteger)numberOfTabsInTabsController:(id <IRTabsController>)tabsController {
  return self.viewControllers.count;
}

- (UIView *)tabsController:(id <IRTabsController>)tabsController viewAtIndex:(NSUInteger)index {
  return self.viewControllers[index].view;
}

- (NSString *)tabsController:(id <IRTabsController>)tabsController titleAtIndex:(NSUInteger)index {
  return self.viewControllers[index].title;
}

- (void)tabsController:(id <IRTabsController>)tabsController
 viewWillAppendAtIndex:(NSUInteger)index
withTabsViewController:(IRTabsViewController *)tabsViewController {
  [tabsViewController addChildViewController:self.viewControllers[index]];
}

- (void)tabsController:(id <IRTabsController>)tabsController
  viewDidAppendAtIndex:(NSUInteger)index
withTabsViewController:(IRTabsViewController *)tabsViewController {
  [self.viewControllers[index] didMoveToParentViewController:tabsViewController];
}

- (void)tabsController:(id <IRTabsController>)tabsController
viewWillRemovedAtIndex:(NSUInteger)index
withTabsViewController:(IRTabsViewController *)tabsViewController {
  [self.viewControllers[index] willMoveToParentViewController:nil];
}

- (void)tabsController:(id <IRTabsController>)tabsController
 viewDidRemovedAtIndex:(NSUInteger)index
withTabsViewController:(IRTabsViewController *)tabsViewController {
  [self.viewControllers[index] removeFromParentViewController];
}

@end
