//
//  IRViewControllersTabsDataSource.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 11.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseTabsDataSource.h"


@interface IRViewControllersTabsDataSource : IRBaseTabsDataSource

@property (nonatomic) NSArray<UIViewController*>* viewControllers;

@end