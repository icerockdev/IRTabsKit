//
//  IRTabsViewController.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IRTabsView;
@class IRTabsContainerView;

@protocol IRTabsController;
@protocol IRTabsDataSource;

@interface IRTabsViewController : UIViewController

@property (nonatomic, weak) IBOutlet IRTabsView* tabsView;
@property (nonatomic, weak) IBOutlet IRTabsContainerView* tabsContainerView;
@property (nonatomic, strong) IBOutlet id<IRTabsController> tabsController;
@property (nonatomic, strong) IBOutlet id<IRTabsDataSource> tabsDataSource;

@end
