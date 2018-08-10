//
//  comapanyPerformenceVC.h
//  Sheela Foam
//
//  Created by Apple on 03/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface comapanyPerformenceVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *footerView;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *performenceTable;
- (IBAction)thisWeek:(id)sender;
- (IBAction)ytdAction:(id)sender;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UIView *boarderView;

- (IBAction)profileBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *tpHeading;
@property (weak, nonatomic) IBOutlet UIButton *ytdBtn;
@property (weak, nonatomic) IBOutlet UILabel *rcvHeading;
@property (weak, nonatomic) IBOutlet UIButton *thisWeek;
@property (weak, nonatomic) IBOutlet UILabel *value1;
@property (weak, nonatomic) IBOutlet UILabel *value2;
@property (weak, nonatomic) IBOutlet UILabel *value3;
@property (weak, nonatomic) IBOutlet UILabel *value4;





@end
