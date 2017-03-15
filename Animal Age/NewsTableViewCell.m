//
//  NewsTableViewCell.m
//  Mac Gurus iOS
//
//  Created by Jon on 9/18/16.
//  Copyright © 2016 jonbrown.org. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //self.imageView.frame = CGRectMake(0, 0, 10, 10);

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.imageView.bounds = CGRectMake(0,0,65,44);
    self.imageView.frame = CGRectMake(0,0,65,44);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.imageView.layer setCornerRadius:4.0f];
    [self.imageView.layer setMasksToBounds:YES];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (self.imageView.image) {
        //TODO: adjust the textLabel and detailTextLabel
        self.textLabel.frame = CGRectMake(75, 0, 250, 44);
    }
    
}
@end
