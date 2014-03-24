//
//  ACMItem.m
//  RandomItems
//
//  Created by Liam Westby on 3/17/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import "HPNItem.h"

@implementation HPNItem
+ (instancetype)randomItem {
    NSArray *randomAdjectiveList = @[@"Elven", @"Iron", @"Orcish", @"Dragon"];
    NSArray *randomNounList = @[@"Longsword", @"Shortsword", @"Bow", @"Dagger", @"Warhammer"];
    NSArray *randomEnchantmentList = @[@"of Frost", @"of Flames", @"of Sparks", @"of Draining", @"of Trapping"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    NSInteger enchantmentIndex = arc4random() % [randomEnchantmentList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@ %@",
                             [randomAdjectiveList objectAtIndex:adjectiveIndex],
                             [randomNounList objectAtIndex:nounIndex],
                             [randomEnchantmentList objectAtIndex:enchantmentIndex]];
    
    int randomValue = arc4random() % 1000;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    
    HPNItem *newItem = [[self alloc]initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    self = [super init];
    
    if (self) {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
    }
    
    return self;
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}

- (void)setItemName:(NSString *)str {
    _itemName = str;
}

- (NSString *)itemName {
    return _itemName;
}

- (void)setSerialNumber:(NSString *)str {
    _serialNumber = str;
}

- (NSString *)serialNumber {
    return _serialNumber;
}

- (void)setValueInDollars:(int)dollars {
    _valueInDollars = dollars;
}

- (int)valueInDollars {
    return _valueInDollars;
}

- (NSDate *)dateCreated {
    return _dateCreated;
}

- (NSString *)description {
    NSDateFormatter *dateCreatedFormatter = [[NSDateFormatter alloc] init];
    [dateCreatedFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateCreatedFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *retval = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@", self.itemName, self.serialNumber, self.valueInDollars, [dateCreatedFormatter stringFromDate:self.dateCreated]];
    return retval;
}
@end
