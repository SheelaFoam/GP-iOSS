//
//  MyApponment.h
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyApponment : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *appoinmentDetail;
@property (weak, nonatomic) IBOutlet UILabel *appoinmentTime;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *monthLab;
@property (weak, nonatomic) IBOutlet UIImageView *sepraterLab;
@end
