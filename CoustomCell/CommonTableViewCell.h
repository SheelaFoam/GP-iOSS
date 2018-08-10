//
//  CommonTableViewCell.h
//  Sheela Foam
//
//  Created by Apple on 18/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *sepraterLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@end
