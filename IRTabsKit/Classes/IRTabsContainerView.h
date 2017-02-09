//
//  IRTabsContainerView.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IRTabsContainerView : UIScrollView

@property(nullable,nonatomic,weak) id<UIScrollViewDelegate> delegate UNAVAILABLE_ATTRIBUTE;
@property IBOutletCollection(NSObject<UIScrollViewDelegate>) NSArray<NSObject<UIScrollViewDelegate>*>* scrollDelegates;

@end
