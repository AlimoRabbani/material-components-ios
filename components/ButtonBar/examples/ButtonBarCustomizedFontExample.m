/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MaterialButtonBar.h"

@interface ButtonBarCustomizedFontExample : UIViewController
@end

@implementation ButtonBarCustomizedFontExample

- (void)viewDidLoad {
  [super viewDidLoad];

  MDCButtonBar *buttonBar = [[MDCButtonBar alloc] init];

  // MDCButtonBar ignores the style of UIBarButtonItem.
  UIBarButtonItemStyle ignored = UIBarButtonItemStyleDone;

  UIBarButtonItem *actionItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Disable"
                                       style:ignored
                                      target:self
                                      action:@selector(didTapActionButton:)];
  UIBarButtonItem *secondActionItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Customization"
                                       style:ignored
                                      target:self
                                      action:@selector(didTapActionButton:)];

  NSArray *items = @[ actionItem, secondActionItem ];

  // Set the title text attributes before assigning to buttonBar.items
  // because of https://github.com/material-components/material-components-ios/issues/277
  for (UIBarButtonItem *item in items) {
    [item setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor greenColor] }
                        forState:UIControlStateNormal];
  }

  buttonBar.items = items;

  // MDCButtonBar's sizeThatFits gives a "best-fit" size of the provided items.
  CGSize size = [buttonBar sizeThatFits:self.view.bounds.size];
  CGFloat x = (self.view.bounds.size.width - size.width) / 2;
  CGFloat y = self.view.bounds.size.height / 2 - size.height;
  buttonBar.frame = CGRectMake(x, y, size.width, size.height);
  buttonBar.autoresizingMask =
      (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
       UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  [self.view addSubview:buttonBar];

  // Ensure that the controller's view isn't transparent.
  self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
}

#pragma mark - User actions

- (void)didTapActionButton:(id)sender {
  NSLog(@"Did tap action item: %@", sender);

  // Disable CUstomization
  [[MDCButtonBarButton appearance] setTitleFont:nil forState:UIControlStateNormal];
}

@end

@implementation ButtonBarCustomizedFontExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Button Bar", @"Button Bar (Customized)" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (NSString *)catalogDescription {
  return @"A Button Bar with a customized font.";
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

@end

#pragma mark - Typical application code (not Material-specific)

@implementation ButtonBarCustomizedFontExample (GeneralApplicationLogic)

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Button Bar";

    UIFont *customFont = [UIFont fontWithName:@"American Typewriter" size:10.0f];
    NSAssert(customFont, @"Unable to instantiate font");
    [[MDCButtonBarButton appearance] setTitleFont:customFont forState:UIControlStateNormal];
  }
  return self;
}

@end
