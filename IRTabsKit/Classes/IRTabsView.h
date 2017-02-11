//
//  IRTabsView.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IRTabsController;

@interface IRTabsView : UIView

@property(nonatomic) CGFloat selectedIndicatorPosition;

@property(nonatomic, nullable) NSArray<UIView *> *tabViews;
@property(nonatomic, nullable) UIView *selectedTabIndicatorView;

@end
