//
//  ACMItem.m
//  RandomItems
//
//  Created by Liam Westby on 3/17/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import "HPNItem.h"

@implementation HPNItem

#pragma mark - Initializers
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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _itemName = [aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _key = [aDecoder decodeObjectForKey:@"key"];
        _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
        _thumbnail = [aDecoder decodeObjectForKey:@"thumbnail"];
    }
    return self;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    self = [super init];
    
    if (self) {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
        
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _key = key;
    }
    
    return self;
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}

- (void)setThumbnailFromImage:(UIImage *)image {
    CGSize origImageSize = image.size;
    
    // The thumbnail's rect
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    
    // Figure out the scaling ratio, wouldn't want to skew the image now would we hmmm????? no
    float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height);
    
    // Create transparent bitmap context with a scaling factor equal to that of the screen
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    // Create a path that is a rounded rectangle
    // UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:newRect];
    
    // Make all subsequent drawing clip to this mask
    [path addClip];
    
    // Center the image in the rect
    CGRect projectRect;
    projectRect.size.width = ratio *origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    // Draw the image
    [image drawInRect:projectRect];
    
    // Get the image and keep it as thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    // cleanup
    UIGraphicsEndImageContext();
}

#pragma mark - Utility Methods

- (NSString *)description {
    NSDateFormatter *dateCreatedFormatter = [[NSDateFormatter alloc] init];
    [dateCreatedFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateCreatedFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *retval = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@", self.itemName, self.serialNumber, self.valueInDollars, [dateCreatedFormatter stringFromDate:self.dateCreated]];
    return retval;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
}
@end
