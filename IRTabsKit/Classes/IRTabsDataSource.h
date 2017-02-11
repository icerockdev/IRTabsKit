//
//  IRTabsDataSource.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 11.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IRTabsController;
@class IRTabsViewController;

@protocol IRTabsDataSource <NSObject>

- (NSUInteger)numberOfTabsInTabsController:(id <IRTabsController>)tabsController;

- (UIView *)tabsController:(id <IRTabsController>)tabsController viewAtIndex:(NSUInteger)index;

- (UIView *)tabsController:(id <IRTabsController>)tabsController tabViewAtIndex:(NSUInteger)index;

- (UIView *)selectedTabIndicatorInTabsController:(id <IRTabsController>)tabsController;

@optional

- (void)tabsController:(id <IRTabsController>)tabsController
 viewWillAppendAtIndex:(NSUInteger)index
withTabsViewController:(IRTabsViewController *)tabsViewController;

- (void)tabsController:(id <IRTabsController>)tabsController
  viewDidAppendAtIndex:(NSUInteger)index
withTabsViewController:(IRTabsViewController *)tabsViewController;

- (void)tabsController:(id <IRTabsController>)tabsController
viewWillRemovedAtIndex:(NSUInteger)index
withTabsViewController:(IRTabsViewController *)tabsViewController;

- (void)tabsController:(id <IRTabsController>)tabsController
 viewDidRemovedAtIndex:(NSUInteger)index
withTabsViewController:(IRTabsViewController *)tabsViewController;

@end