//
//  HPNDetailViewController.h
//  Homepwner
//
//  Created by Liam on 5/30/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HPNItem;
@interface HPNDetailViewController : UIViewController <UITextFieldDelegate>

- (instancetype)initForNewItem:(BOOL)isNew;

@property (nonatomic, strong) HPNItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);
@end
