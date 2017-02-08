//
//  IRTabsContainerView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 04.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRTabsContainerView.h"

@implementation IRTabsContainerView

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
  self.showsVerticalScrollIndicator = false;
  self.showsHorizontalScrollIndicator = false;

  return [super awakeAfterUsingCoder:aDecoder];
}

- (void)awakeFromNib {
  self.showsVerticalScrollIndicator = false;
  self.showsHorizontalScrollIndicator = false;

  [super awakeFromNib];
}

- (void)layoutSubviews {
  NSUInteger pagesCount = self.subviews.count;
  CGSize selfSize = self.bounds.size;
  CGSize newSize = CGSizeMake(selfSize.width * pagesCount, selfSize.height);
  CGSize oldSize = self.contentSize;
  CGPoint oldOffset = self.contentOffset;

  [self setContentSize:newSize];

  if(newSize.width != oldSize.width) {
    NSUInteger page = (NSUInteger) ceil(oldOffset.x / (oldSize.width / self.subviews.count));
    [self setContentOffset:CGPointMake(selfSize.width * page, self.contentInset.top)];
  }

  for(NSUInteger i = 0;i < pagesCount;i++) {
    [self.subviews[i] setFrame:CGRectMake(selfSize.width * i, 0.0f, selfSize.width, selfSize.height)];
  }
}

@end
