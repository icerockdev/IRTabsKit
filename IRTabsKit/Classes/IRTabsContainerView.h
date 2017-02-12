//
//  IRTabsContainerView.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IRTabsContainerView : UIScrollView

@property(nonatomic, nullable) NSArray<UIView *> *tabContentViews;

@end
