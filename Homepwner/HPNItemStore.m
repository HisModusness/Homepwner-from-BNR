//
//  HPNItemStore.m
//  Homepwner
//
//  Created by Liam Westby on 3/23/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import "HPNItemStore.h"
#import "HPNItem.h"

@interface HPNItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation HPNItemStore

+ (instancetype)sharedStore {
    static HPNItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use sharedStore" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (HPNItem *)createItem {
    HPNItem *item = [HPNItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

@end
