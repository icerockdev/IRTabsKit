//
//  IRButtonTabView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 12.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRButtonTabView.h"

@implementation IRButtonTabView

- (void)setTitle:(NSString *)title {
  [self.titleButton setTitle:title forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
  [self.titleButton setSelected:selected];
}

@end