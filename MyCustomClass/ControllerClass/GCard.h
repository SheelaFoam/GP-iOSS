//
//  GCard.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 07/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "historyModel.h"
#import "GCardCell.h"
#import "SVProgressHUD.h"
#import "MailClassViewController.h"
#import "SearchCell.h"
#import "AppDelegate.h"

@interface GCard : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *gCardTable;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@property (weak, nonatomic) IBOutlet UITextField *fromDateTextfield;
@property (weak, nonatomic) IBOutlet UITextField *toDateTextfield;
@property (weak, nonatomic) IBOutlet UITextField *salesRepTextfield;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchTableHeight;

@end
