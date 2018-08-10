//
//  LeftMenuViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 7/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuTableViewCell.h"
#import "myPerformenceDetail.h"
#import "SWRevealViewController.h"



@interface LeftMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@property (strong, nonatomic) IBOutlet UITableView *leftMenuTable;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@end
