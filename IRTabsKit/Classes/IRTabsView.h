//
//  IRTabsView.h
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IRTabsViewDelegate

- (UIView *)createTabViewWithViewController:(UIViewController *)viewController;

@end

@protocol IRTabViewProtocol

@property IBOutlet UILabel *titleLabel;

@end

IB_DESIGNABLE
@interface IRTabsView : UIView

@property IBInspectable NSString *tabNibFile;

@property NSUInteger selectedTab;
@property IBOutlet id <IRTabsViewDelegate> delegate;

- (void)populateWithViewControllers:(NSArray<UIViewController *> *)viewControllers;

@end
