//
//  IRTabsContainerView.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IRTabsContainerViewDelegate <NSObject>

@optional
- (void)tabsContainerViewBoundsWillChangeFrom:(CGRect)fromBounds to:(CGRect)toBounds;

- (void)tabsContainerViewBoundsDidChangeFrom:(CGRect)fromBounds to:(CGRect)toBounds;

@end

@interface IRTabsContainerView : UIScrollView

@property(nonatomic, weak) id <IRTabsContainerViewDelegate> tabsContainerDelegate;

@end
