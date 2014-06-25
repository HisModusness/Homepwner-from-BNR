//
//  HPNImageStore.m
//  Homepwner
//
//  Created by Liam on 5/31/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import "HPNImageStore.h"
@interface HPNImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

- (NSString *)imagePathForKey:(NSString *)key;

@end


@implementation HPNImageStore

#pragma mark Singleton
+ (instancetype)sharedStore {
    static HPNImageStore *sharedStore = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}

- (instancetype)init {
    // kill yourself
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use the singleton, also kill yourself"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    return self;
}

- (NSString *)imagePathForKey:(NSString *)key {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}

- (void)clearCache:(NSNotification *)note {
    NSLog(@"Flushing %d images out of the cache", [self.dictionary count]);
    [self.dictionary removeAllObjects];
}

#pragma mark Public Methods
- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
    
    // Create full path for image
    NSString *imagePath = [self imagePathForKey:key];
    
    // Turn image into JPEG data
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    // Write out to path
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key {
    // If possible, get from memory
    UIImage *result = self.dictionary[key];
    
    if (!result) {
        // Cache miss
        NSString *imagePath = [self imagePathForKey:key];
        
        // Make UIImage from file
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        // If found, cache
        if (result) {
            self.dictionary[key] = result;
        }
        else {
            NSLog(@"Error, unable to find %@",[self imagePathForKey:key]);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    
    [self.dictionary removeObjectForKey:key];
    
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

@end
