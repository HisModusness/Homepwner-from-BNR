//
//  HPNDateChooserViewController.m
//  Homepwner
//
//  Created by Liam on 5/30/14.
//  Copyright (c) 2014 ACM. All rights reserved.
//

#import "HPNDateChooserViewController.h"
#import "HPNItem.h"

@interface HPNDateChooserViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)dateChanged:(id)sender;
@end

@implementation HPNDateChooserViewController
- (void)setItem:(HPNItem *)item {
    _item = item;
    self.navigationItem.title = @"Change Date";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    HPNItem *item = self.item;
    self.datePicker.date = item.dateCreated;
    [self dateChanged:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    HPNItem *item = self.item;
    item.dateCreated = self.datePicker.date;
}

- (IBAction)dateChanged:(id)sender {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:self.datePicker.date];
}
@end
