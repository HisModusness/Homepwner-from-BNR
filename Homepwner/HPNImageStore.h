//
//  HPNImageStore.h
//  Homepwner
//
//  Created by Liam on 5/31/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPNImageStore : NSObject
+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;
@end
