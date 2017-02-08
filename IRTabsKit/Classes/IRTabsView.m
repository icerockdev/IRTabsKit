//
//  IRTabsView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabsView.h"
#import "IRTabViewOwner.h"
#import "IRSelectedIndicatorViewOwner.h"
#import "IRTabsController.h"

@interface IRTabsView ()

@property(nonatomic, weak) UIView *selectedIndicatorView;

@end

@implementation IRTabsView

- (void)populateWithViewControllers:(NSArray<UIViewController *> *)viewControllers {
  // remove subviews
  while (self.subviews.count > 0) {
    [self.subviews[0] removeFromSuperview];
  }

  NSMutableArray<UIView *> *tabViews = [NSMutableArray arrayWithCapacity:viewControllers.count];

  for (NSUInteger i = 0; i < viewControllers.count; i++) {
    UIView *view = [self createViewForTabWithViewController:viewControllers[i]];
    view.tag = i;

    UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tabPressed:)];
    [view addGestureRecognizer:tapGestureRecognizer];

    tabViews[i] = view;

    [self addSubview:view];
  }

  _tabViews = [NSArray arrayWithArray:tabViews];

  if (self.selectedIndicatorView == nil) {
    if (self.selectedIndicatorNibFile != nil) {
      IRSelectedIndicatorViewOwner *viewOwner = [IRSelectedIndicatorViewOwner new];
      [[UINib nibWithNibName:self.selectedIndicatorNibFile
                      bundle:nil] instantiateWithOwner:viewOwner
                                               options:nil];

      self.selectedIndicatorView = viewOwner.view;
    } if(self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(createSelectedIndicatorView)]) {
      self.selectedIndicatorView = [self.delegate createSelectedIndicatorView];
    }
  }

  if (self.selectedIndicatorView != nil) {
    [self addSubview:self.selectedIndicatorView];
  }
}

- (void)tabPressed:(UITapGestureRecognizer*)tapGestureRecognizer {
  [self.tabsController tabSelected:(NSUInteger) tapGestureRecognizer.view.tag];
}

- (UIView *)createViewForTabWithViewController:(UIViewController *)viewController {
  if (self.tabNibFile != nil) {
    IRTabViewOwner *viewOwner = [IRTabViewOwner new];
    [[UINib nibWithNibName:self.tabNibFile
                    bundle:nil] instantiateWithOwner:viewOwner
                                             options:nil];

    viewOwner.titleLabel.text = [self tabTitleWithViewController:viewController];

    return viewOwner.view;
  } else if (self.delegate != nil && [self.delegate respondsToSelector:@selector(createSelectedIndicatorView)]) {
    UIView *view = [self.delegate createTabViewWithViewController:viewController];
    return view;
  } else {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:[self tabTitleWithViewController:viewController]
            forState:UIControlStateNormal];
    return button;
  }
}

- (NSString *)tabTitleWithViewController:(UIViewController *)viewController {
  return viewController.title;
}

- (void)setSelectedTab:(NSUInteger)selectedTab {
  [self setSelectedIndicatorPosition:selectedTab];
}

- (NSUInteger)selectedTab {
  return (NSUInteger) ceil(self.selectedIndicatorPosition);
}

- (void)setSelectedIndicatorPosition:(CGFloat)selectedIndicatorPosition {
  _selectedIndicatorPosition = selectedIndicatorPosition;

  [self setNeedsLayout];
}

- (void)layoutSubviews {
  NSArray<UIView*>* tabViews = self.tabViews;
  CGSize selfSize = self.bounds.size;
  CGSize tabSize = CGSizeMake(selfSize.width / tabViews.count, selfSize.height);

  for(NSUInteger i = 0;i < tabViews.count;i++) {
    UIView* tabView = tabViews[i];

    [tabView setFrame:CGRectMake(tabSize.width * i, 0,
        tabSize.width, tabSize.height)];
  }

  [self.selectedIndicatorView setFrame:CGRectMake(tabSize.width * self.selectedIndicatorPosition, 0,
      tabSize.width, tabSize.height)];
}

@end
