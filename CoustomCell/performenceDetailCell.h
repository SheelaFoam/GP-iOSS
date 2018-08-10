//
//  performenceDetailCell.h
//  Sheela Foam
//
//  Created by Apple on 25/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface performenceDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@property (weak, nonatomic) IBOutlet UILabel *keyLab;
@property (weak, nonatomic) IBOutlet UILabel *percentageLab;
@property (weak, nonatomic) IBOutlet UILabel *percentageColour;
@property (weak, nonatomic) IBOutlet UILabel *yearPerformence;
@end
