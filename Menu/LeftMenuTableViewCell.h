//
//  LeftMenuTableViewCell.h
//  LearningHouse
//
//  Created by Alok Singh on 7/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *menuImage;
@property (weak, nonatomic) IBOutlet UIImageView *dropDownImg;
@property (weak, nonatomic) IBOutlet UILabel *separaterLab;

@end
