//
//  IRSwipeTabsController.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRTabsController.h"
#import "IRBaseTabsController.h"

IB_DESIGNABLE
@interface IRSwipeTabsController : IRBaseTabsController

@property IBInspectable NSNumber *transitionDuration;
@property IBInspectable NSNumber *infinite;

@end
