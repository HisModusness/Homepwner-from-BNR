//
//  HPNItemCell.m
//  Homepwner
//
//  Created by Liam on 6/24/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import "HPNItemCell.h"

@implementation HPNItemCell
- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}
@end
