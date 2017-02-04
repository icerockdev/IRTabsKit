//
//  IRTabSegue.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabSegue.h"
#import "IRTabsViewController.h"

@implementation IRTabSegue

- (void)perform {
  if (![self.sourceViewController isKindOfClass:[IRTabsViewController class]]) {
    return;
  }

  IRTabsViewController *tabsViewController = (IRTabsViewController *) self.sourceViewController;

  [tabsViewController addTabViewController:self.destinationViewController];
}

@end
