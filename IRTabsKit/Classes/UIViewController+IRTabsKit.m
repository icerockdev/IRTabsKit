//
//  UIViewController+IRTabsKit.m
//  IRTabsKit
//
//  Created by Aleksey Mikhailov on 07/02/2017.
//
//

#import "UIViewController+IRTabsKit.h"
#import "IRTabsViewController.h"

@implementation UIViewController (IRTabsKit)

- (IRTabsViewController *)tabsViewController {
  UIViewController *currentViewController = self;

  do {
    if([currentViewController isKindOfClass:[IRTabsViewController class]]) {
      return (IRTabsViewController *) currentViewController;
    }
    currentViewController = currentViewController.parentViewController;
  }
  while(currentViewController != nil);

  return nil;
}

@end