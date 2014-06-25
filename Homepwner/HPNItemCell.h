//
//  HPNItemCell.h
//  Homepwner
//
//  Created by Liam on 6/24/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPNItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (copy, nonatomic) void (^actionBlock)(void);

@end
