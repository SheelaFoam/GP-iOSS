//
//  mytaskCellTableViewCell.h
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mytaskCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *taskTitle;
@property (weak, nonatomic) IBOutlet UILabel *taskDesk;
@property (weak, nonatomic) IBOutlet UIButton *approveBtn;
@property (weak, nonatomic) IBOutlet UIButton *disApprove;
@property (weak, nonatomic) IBOutlet UILabel *approveLab;
@property (weak, nonatomic) IBOutlet UILabel *sapraterLab;
@property (weak, nonatomic) IBOutlet UILabel *pendingLab;

@end
