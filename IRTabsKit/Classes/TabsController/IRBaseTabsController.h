//
//  IRBaseTabsController.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 11.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRTabsController.h"

@class IRTabsContainerView;
@class IRTabsView;

@interface IRBaseTabsController : NSObject <IRTabsController>

@property(nonatomic, readwrite) NSUInteger selectedTab;

@property(readonly, nonatomic, weak) IRTabsViewController *tabsViewController;
@property(readonly, nonatomic) IRTabsView *tabsView;
@property(readonly, nonatomic) IRTabsContainerView *tabsContainerView;
@property(readonly, nonatomic) id <IRTabsDataSource> tabsDataSource;

@end