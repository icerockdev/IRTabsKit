//
//  IRTabsView.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IRTabsController;

@protocol IRTabsViewDelegate <NSObject>

- (UIView *)createTabViewWithViewController:(UIViewController *)viewController;

- (UIView *)createSelectedIndicatorView;

@end

IB_DESIGNABLE
@interface IRTabsView : UIView

@property IBInspectable NSString *selectedIndicatorNibFile;
@property IBInspectable NSString *tabNibFile;

@property(nonatomic, readonly) NSArray<UIView *> *tabViews;
@property(nonatomic) NSUInteger selectedTab;
@property(nonatomic) CGFloat selectedIndicatorPosition;
@property(weak) IBOutlet id <IRTabsViewDelegate> delegate;
@property(weak) id <IRTabsController> tabsController;

- (void)populateWithViewControllers:(NSArray<UIViewController *> *)viewControllers;

@end
