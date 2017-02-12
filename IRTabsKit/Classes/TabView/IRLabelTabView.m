//
//  IRLabelTabView.m
//  IRTabsKit
//
//  Created by Михайлов Алексей on 12.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRLabelTabView.h"

@implementation IRLabelTabView

- (void)setTitle:(NSString *)title {
  [self.titleLabel setText:title];
}

- (void)setSelected:(BOOL)selected {
  [self.titleLabel setHighlighted:selected];
}

@end
