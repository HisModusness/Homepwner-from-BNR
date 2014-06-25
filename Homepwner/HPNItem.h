//
//  ACMItem.h
//  RandomItems
//
//  Created by Liam Westby on 3/17/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPNItem : NSObject <NSCoding>

@property (nonatomic, strong) NSString *itemName, *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) UIImage *thumbnail;

// class method to make all your dreams come true
+ (instancetype)randomItem;

// designated for fun times
- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;
- (instancetype)initWithItemName:(NSString *)name;

// thumbnail enabler
- (void)setThumbnailFromImage:(UIImage *)image;

@end
