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

- (void)viewDidLoad:(IRTabsViewController *)tabsViewController;
- (void)tabSelected:(NSUInteger)tabIndex;

@end
