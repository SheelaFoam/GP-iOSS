//
//  approveTaskVC.h
//  Sheela Foam
//
//  Created by Apple on 14/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface approveTaskVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *taskApproveTable;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(id)sender;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)profileBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;

@end
