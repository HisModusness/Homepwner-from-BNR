//
//  HPNItemStore.h
//  Homepwner
//
//  Created by Liam Westby on 3/23/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HPNItem;

@interface HPNItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (HPNItem *)createItem;
- (void)removeItem:(HPNItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;
@end
