//
//  IRBaseTabsDataSource.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 11.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRTabsDataSource.h"

IB_DESIGNABLE
@interface IRBaseTabsDataSource : NSObject<IRTabsDataSource>

@property IBInspectable NSString *selectedIndicatorNibFile;
@property IBInspectable NSString *tabNibFile;

- (NSString *)tabsController:(id <IRTabsController>)tabsController titleAtIndex:(NSUInteger)index;

@end