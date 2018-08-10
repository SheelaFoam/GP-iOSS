//
//  mytaskCellTableViewCell.m
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "mytaskCellTableViewCell.h"

@implementation mytaskCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.approveLab.layer.cornerRadius = 3;
    self.approveLab.layer.cornerRadius = 10.0f;
    [self.approveLab setClipsToBounds:YES];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
