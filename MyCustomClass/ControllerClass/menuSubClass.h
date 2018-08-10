//
//  menuSubClass.h
//  Sheela Foam
//
//  Created by Apple on 29/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuSubClass : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UITableView *detailTable;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)profileBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *noDataLab;

@end
