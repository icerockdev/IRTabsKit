//
//  IRTabsView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabsView.h"

@implementation IRTabsView

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

  [self.selectedTabIndicatorView setFrame:CGRectMake(tabSize.width * self.selectedIndicatorPosition, 0,
      tabSize.width, tabSize.height)];
}

- (void)setTabViews:(NSArray<UIView *> *)tabViews {
  if(_tabViews != nil) {
    for(NSUInteger i = 0;i < _tabViews.count;i++) {
      [_tabViews[i] removeFromSuperview];
    }
  }
  if(tabViews != nil) {
    for(NSUInteger i = 0;i < tabViews.count;i++) {
      [self addSubview:tabViews[i]];
    }
  }

  _tabViews = tabViews;
}

- (void)setSelectedTabIndicatorView:(UIView *)selectedTabIndicatorView {
  [_selectedTabIndicatorView removeFromSuperview];
  [self addSubview:selectedTabIndicatorView];

  _selectedTabIndicatorView = selectedTabIndicatorView;
}
@end
