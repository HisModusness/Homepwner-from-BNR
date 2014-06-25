//
//  HPNItemStore.m
//  Homepwner
//
//  Created by Liam Westby on 3/23/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import "HPNImageStore.h"
#import "HPNItemStore.h"
#import "HPNItem.h"

@interface HPNItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation HPNItemStore

+ (instancetype)sharedStore {
    static HPNItemStore *sharedStore = nil;
    
    // threadsafe for CLOSE TO THE METAL SPEED
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use sharedStore" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If no array exists, create a new one
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (HPNItem *)createItem {
    HPNItem *item = [[HPNItem alloc] init];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(HPNItem *)item {
    // Have to delete image of item, as well
    NSString *key = item.key;
    [[HPNImageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    HPNItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

@end
