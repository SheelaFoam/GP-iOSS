//
//  myPerformenceDetail.h
//  Sheela Foam
//
//  Created by Apple on 25/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "performenceDetailCell.h"
@interface myPerformenceDetail : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *boarderView;
@property (weak, nonatomic) IBOutlet UILabel *sapraterLab;
@property (weak, nonatomic) IBOutlet UITableView *performenceTable;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
- (IBAction)logout:(id)sender;
- (IBAction)profileBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *sectionHeader;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property BOOL homeView;

@property (weak, nonatomic) IBOutlet UILabel *KPILab;
@property (weak, nonatomic) IBOutlet UILabel *KPIvalueLab;
@property (weak, nonatomic) IBOutlet UILabel *KPIpercentLab;
@property (weak, nonatomic) IBOutlet UILabel *kpiColourLab;

@property (weak, nonatomic) IBOutlet UILabel *weightlab;


@end
