//
//  IRTabSegue.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabSegue.h"
#import "IRTabsViewController.h"
#import "IRViewControllersTabsDataSource.h"

@implementation IRTabSegue

- (void)perform {
  if (![self.sourceViewController isKindOfClass:[IRTabsViewController class]]) {
    NSLog(@"can't perform IRTabSegue with sourceViewController not kind of IRTabsViewController class");
    return;
  }

  IRTabsViewController *tabsViewController = self.sourceViewController;
  if (![tabsViewController.tabsDataSource isKindOfClass:[IRViewControllersTabsDataSource class]]) {
    NSLog(@"can't perform IRTabSegue with tabsDataSource not kind of IRViewControllersTabsDataSource class");
    return;
  }

  IRViewControllersTabsDataSource *dataSource = (IRViewControllersTabsDataSource *) tabsViewController.tabsDataSource;

  NSMutableArray<UIViewController *> *updatedViewControllers =
      [NSMutableArray arrayWithArray:dataSource.viewControllers];
  [updatedViewControllers addObject:self.destinationViewController];

  dataSource.viewControllers = [NSArray arrayWithArray:updatedViewControllers];
}

@end
