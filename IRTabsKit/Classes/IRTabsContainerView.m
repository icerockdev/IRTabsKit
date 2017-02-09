//
//  IRTabsContainerView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabsContainerView.h"

#define FOREACH_SCROLL_DELEGATES(code) if(self.scrollDelegates != nil) { \
  for(NSUInteger i = 0;i < self.scrollDelegates.count;i++) { \
    if([self.scrollDelegates[i] respondsToSelector:_cmd]) { \
      [self.scrollDelegates[i] code]; \
    } \
  } \
}

@interface IRTabsContainerView()<UIScrollViewDelegate>

@end

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
  [super setDelegate:self];
  
  self.scrollDelegates = [NSArray array];
  self.showsVerticalScrollIndicator = false;
  self.showsHorizontalScrollIndicator = false;
}

- (void)layoutSubviews {
  NSUInteger pagesCount = self.subviews.count;
  CGSize selfSize = self.bounds.size;
  CGSize newSize = CGSizeMake(selfSize.width * pagesCount, selfSize.height);
  CGSize oldSize = self.contentSize;
  CGPoint oldOffset = self.contentOffset;

  [self setContentSize:newSize];

  if(self.subviews.count != 0 && oldSize.width != 0 && newSize.width != oldSize.width) {
    NSUInteger page = (NSUInteger) ceil(oldOffset.x / (oldSize.width / self.subviews.count));
    [self setContentOffset:CGPointMake(selfSize.width * page, self.contentInset.top)];
  }

  for(NSUInteger i = 0;i < pagesCount;i++) {
    [self.subviews[i] setFrame:CGRectMake(selfSize.width * i, 0.0f, selfSize.width, selfSize.height)];
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  FOREACH_SCROLL_DELEGATES(scrollViewDidScroll:scrollView)
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
  FOREACH_SCROLL_DELEGATES(scrollViewDidZoom:scrollView)
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  FOREACH_SCROLL_DELEGATES(scrollViewWillBeginDragging:scrollView)
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
  FOREACH_SCROLL_DELEGATES(scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset)
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  FOREACH_SCROLL_DELEGATES(scrollViewDidEndDragging:scrollView willDecelerate:decelerate)
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
  FOREACH_SCROLL_DELEGATES(scrollViewWillBeginDecelerating:scrollView)
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  FOREACH_SCROLL_DELEGATES(scrollViewDidEndDecelerating:scrollView)
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  FOREACH_SCROLL_DELEGATES(scrollViewDidEndScrollingAnimation:scrollView)
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
  FOREACH_SCROLL_DELEGATES(scrollViewWillBeginZooming:scrollView withView:view)
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
  FOREACH_SCROLL_DELEGATES(scrollViewDidEndZooming:scrollView withView:view atScale:scale)
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
  FOREACH_SCROLL_DELEGATES(scrollViewDidScrollToTop:scrollView)
}

@end
