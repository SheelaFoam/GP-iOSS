//
//  Pager.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EOCB.h"
#import "CAPSPageMenu.h"
#import "historyModel.h"
#import "PassbookModel.h"
#import "SVProgressHUD.h"
#import "UserDefaultStorage.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"

@interface Passbook : UIViewController

@property (nonatomic) CAPSPageMenu *pagemenu;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (weak, nonatomic) IBOutlet UITextField *fromDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *toDateTextField;

@property (weak, nonatomic) IBOutlet UILabel *fromDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *toDateLbl;

@property (weak, nonatomic) IBOutlet UIView *datesView;
@property (weak, nonatomic) IBOutlet UILabel *shadowLbl;
@end
