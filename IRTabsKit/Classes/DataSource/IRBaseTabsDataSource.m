//
//  IRBaseTabsDataSource.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 11.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRBaseTabsDataSource.h"
#import "IRSimpleViewOwner.h"
#import "IRTabView.h"

@implementation IRBaseTabsDataSource

- (NSUInteger)numberOfTabsInTabsController:(id <IRTabsController>)tabsController {
  [self doesNotRecognizeSelector:_cmd];
  return 0;
}

- (UIView *)tabsController:(id <IRTabsController>)tabsController viewAtIndex:(NSUInteger)index {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (UIView *)tabsController:(id <IRTabsController>)tabsController tabViewAtIndex:(NSUInteger)index {
  NSString* title = [self tabsController:tabsController titleAtIndex:index];

  if (self.tabNibFile != nil) {
    IRSimpleViewOwner *viewOwner = [IRSimpleViewOwner new];
    [[UINib nibWithNibName:self.tabNibFile
                    bundle:nil] instantiateWithOwner:viewOwner
                                             options:nil];

    UIView* view = viewOwner.view;

    if(view == nil) {
      [[NSException exceptionWithName:NSInvalidArgumentException
                               reason:@"view owner in xib not have linked view outlet"
                             userInfo:nil] raise];
    }

    if([view isKindOfClass:[IRTabView class]]) {
      IRTabView* tabView = (IRTabView *)view;

      tabView.title = title;
    }

    return view;
  } else {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title
            forState:UIControlStateNormal];
    return button;
  }
}

- (UIView *)selectedTabIndicatorInTabsController:(id <IRTabsController>)tabsController {
  if (self.selectedIndicatorNibFile != nil) {
    IRSimpleViewOwner *viewOwner = [IRSimpleViewOwner new];
    [[UINib nibWithNibName:self.selectedIndicatorNibFile
                    bundle:nil] instantiateWithOwner:viewOwner
                                             options:nil];

    return viewOwner.view;
  }
  return nil;
}

- (NSString *)tabsController:(id <IRTabsController>)tabsController titleAtIndex:(NSUInteger)index {
  return [NSString stringWithFormat:@"TAB %d", index];
}

@end
