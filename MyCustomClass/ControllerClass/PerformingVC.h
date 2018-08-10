//
//  PerformingVC.h
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformingCell.h"

@interface PerformingVC : UIView<UITableViewDelegate,UITableViewDataSource>
- (IBAction)ytd:(id)sender;
//@property (weak, nonatomic) IBOutlet UITableView *PerformingTable;
- (IBAction)thisYrar:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *tpTargetLab;
@property (weak, nonatomic) IBOutlet UILabel *tpAchiveLab;
//@property (weak, nonatomic) IBOutlet UILabel *rcvAchiveLab;
@property (weak, nonatomic) IBOutlet UILabel *rcvAchiveLab;
@property (weak, nonatomic) IBOutlet UILabel *rcvTargetLab;
@property (weak, nonatomic) IBOutlet UILabel *tpHeading;
@property (weak, nonatomic) IBOutlet UILabel *rcvHeading;
@property (weak, nonatomic) IBOutlet UIButton *thisWeekBtn;
@property (weak, nonatomic) IBOutlet UIButton *ytdBtn;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;

@end
