//
//  UIViewController+IRTabsKit.h
//  IRTabsKit
//
//  Created by Aleksey Mikhailov on 07/02/2017.
//
//

#import <Foundation/Foundation.h>

@class IRTabsViewController;

@interface UIViewController (IRTabsKit)

@property (nonatomic, readonly) IRTabsViewController* tabsViewController;

@end