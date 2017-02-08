//
//  IRTabsController.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRTabsViewController;

@protocol IRTabsController <NSObject>

@property (nonatomic) NSUInteger selectedTab;

- (void)viewDidLoad:(IRTabsViewController *)tabsViewController;

@end
