//
//  myAppoinmentDetail.h
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myAppoinmentDetail : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myAppoinmentTable;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)profileBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;


@end
