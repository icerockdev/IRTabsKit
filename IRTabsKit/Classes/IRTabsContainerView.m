//
//  IRTabsContainerView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabsContainerView.h"

@implementation IRTabsContainerView

- (instancetype)init {
  self = [super init];
  if(self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  self.showsVerticalScrollIndicator = false;
  self.showsHorizontalScrollIndicator = false;
}

- (void)dealloc {
  self.tabContentViews = nil;
}

- (void)layoutSubviews {
  NSUInteger pagesCount = 0;
  for(NSUInteger i = 0;i < self.tabContentViews.count;i++) {
    if(self.tabContentViews[i].hidden) {
      continue;
    }
    pagesCount++;
  }

  CGSize selfSize = self.bounds.size;
  CGSize newSize = CGSizeMake(selfSize.width * pagesCount, selfSize.height);
  CGSize oldSize = self.contentSize;
  CGPoint oldOffset = self.contentOffset;

  [self setContentSize:newSize];

  if(pagesCount != 0 && oldSize.width != 0 && newSize.width != oldSize.width) {
    NSUInteger page = (NSUInteger) ceil(oldOffset.x / (oldSize.width / pagesCount));
    [self setContentOffset:CGPointMake(selfSize.width * page, self.contentInset.top)];
  }

  NSInteger pageIdx = 0;
  for(NSUInteger i = 0;i < self.tabContentViews.count;i++) {
    UIView* view = self.tabContentViews[i];
    if(view.hidden) {
      continue;
    }
    [view setFrame:CGRectMake(selfSize.width * pageIdx, 0.0f, selfSize.width, selfSize.height)];
    pageIdx++;
  }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
  [super setContentInset:UIEdgeInsetsZero];
}

- (void)setTabContentViews:(NSArray<UIView *> *)tabContentViews {
  if(_tabContentViews != nil) {
    for(NSUInteger i = 0;i < _tabContentViews.count;i++) {
      UIView* view = _tabContentViews[i];
      [view removeObserver:self
                forKeyPath:@"hidden"
                   context:nil];
      [view removeFromSuperview];
    }
  }
  if(tabContentViews != nil) {
    for(NSUInteger i = 0;i < tabContentViews.count;i++) {
      UIView* view = tabContentViews[i];
      [view addObserver:self
             forKeyPath:@"hidden"
                options:NSKeyValueObservingOptionNew
                context:nil];
      if(!view.hidden) {
        [self addSubview:view];
      }
    }
  }
  _tabContentViews = tabContentViews;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  if([object isKindOfClass:[UIView class]]) {
    UIView* view = (UIView*)object;
    if(view.hidden) {
      [view removeFromSuperview];
    } else {
      // not sort by page number for now
      [self addSubview:view];
    }
  }
}

@end
