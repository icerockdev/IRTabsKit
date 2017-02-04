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
  if (self) {

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)setBounds:(CGRect)bounds {
  CGRect oldBounds = self.bounds;

  if ([self.delegate respondsToSelector:@selector(tabsContainerViewBoundsWillChangeFrom:to:)]) {
    [self.delegate tabsContainerViewBoundsWillChangeFrom:oldBounds to:bounds];
  }

  [super setBounds:bounds];

  if ([self.delegate respondsToSelector:@selector(tabsContainerViewBoundsDidChangeFrom:to:)]) {
    [self.delegate tabsContainerViewBoundsDidChangeFrom:oldBounds to:bounds];
  }
}

@end