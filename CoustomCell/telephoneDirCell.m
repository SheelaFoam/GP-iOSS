//
//  telephoneDirCell.m
//  Sheela Foam
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "telephoneDirCell.h"

@implementation telephoneDirCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.Image.layer.cornerRadius = self.Image.frame.size.height /2;
    self.Image.layer.masksToBounds = YES;
    self.Image.layer.borderWidth =1;
    self.Image.layer.borderColor=[[UIColor colorWithRed:12.0/255.0
                                                  green:76.0/255.0
                                                   blue:164.0/255.0
                                                  alpha:1.0]CGColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
