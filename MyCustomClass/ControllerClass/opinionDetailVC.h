//
//  opinionDetailVC.h
//  Sheela Foam
//
//  Created by Apple on 02/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebServiceHelper.h"


@interface opinionDetailVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *boarderView;

@property (weak, nonatomic) IBOutlet UITableView *opinionTable;
@property (weak, nonatomic) IBOutlet UILabel *titleDetal;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)profileBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *footerVew;

@end
