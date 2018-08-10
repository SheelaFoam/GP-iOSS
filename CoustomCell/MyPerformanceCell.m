//
//  MyPerformanceCell.m
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "MyPerformanceCell.h"

@implementation MyPerformanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.slidercolour.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
