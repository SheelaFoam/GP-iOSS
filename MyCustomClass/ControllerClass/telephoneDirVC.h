//
//  telephoneDirVC.h
//  Sheela Foam
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface telephoneDirVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *telephonDirTable;
@property(strong,nonatomic)NSString*idStr;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchTxtField;
-(void)getLatestLoans;
- (IBAction)searchBtn:(id)sender;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
- (IBAction)profileBtn:(id)sender;

@end
