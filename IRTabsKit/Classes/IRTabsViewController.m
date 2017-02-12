//
//  IRTabsViewController.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabsViewController.h"
#import "IRTabsController.h"
#import "IRSwipeTabsController.h"
#import "IRTabsDataSource.h"

@implementation IRTabsViewController

/**
 * preparations with Interface Builder approarch:
 * 1. load all tab view controllers to viewControllers array
 * 2. set default tabs controller if not setted
 */
- (void)awakeFromNib {
  [super awakeFromNib];

  for (NSInteger idx = 0;; idx++) {
    @try {
      [self performSegueWithIdentifier:[NSString stringWithFormat:@"IRTab%d", idx]
                                sender:nil];
    }
    @catch (NSException *exception) {
      break;
    }
  }

  if (self.tabsController == nil) {
    self.tabsController = [[IRSwipeTabsController alloc] init];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.tabsController viewDidLoad:self];
}

@end
