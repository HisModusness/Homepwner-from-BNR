//
//  ACMItem.h
//  RandomItems
//
//  Created by Liam Westby on 3/17/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPNItem : NSObject {
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
}

// class method to make all your dreams come true
+ (instancetype)randomItem;

// designated for fun times
- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;
- (instancetype)initWithItemName:(NSString *)name;

- (void)setItemName:(NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars:(int)dollars;
- (int)valueInDollars;

- (NSDate *)dateCreated;

@end
