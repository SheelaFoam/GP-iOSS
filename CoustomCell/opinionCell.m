//
//  opinionCell.m
//  Sheela Foam
//
//  Created by Apple on 02/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "opinionCell.h"

@implementation opinionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.poolValue.backgroundColor= [UIColor colorWithRed:30.0/255.0f green:175.0/255.0f blue:180.0/255.0f alpha:1.0];
    
    self.view.layer.borderWidth = 1;
    self.view.layer.borderColor =   [[UIColor lightGrayColor]CGColor];
    
    

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
