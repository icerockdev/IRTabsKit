//
//  IRViewsTabsDataSource.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 11.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRViewsTabsDataSource.h"

@implementation IRViewsTabsDataSource

- (NSUInteger)numberOfTabsInTabsController:(id <IRTabsController>)tabsController {
  return self.views.count;
}

- (UIView *)tabsController:(id <IRTabsController>)tabsController viewAtIndex:(NSUInteger)index {
  return self.views[index];
}

- (NSString *)tabsController:(id <IRTabsController>)tabsController titleAtIndex:(NSUInteger)index {
  return self.views[index].accessibilityLabel;
}

@end
