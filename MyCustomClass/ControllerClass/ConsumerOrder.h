//
//  ConsumerOrder.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDropDownMenu.h"
#import <math.h>
#import "POAcvityView.h"
#import "CityView.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedHeader.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "historyModel.h"
#import "UserDefaultStorage.h"
#import "GCardRegistration.h"

@interface ConsumerOrder : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *quantityLbl;
@property (weak, nonatomic) IBOutlet UITextField *mobileNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *consumerNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *productNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *breadthTextField;
@property (weak, nonatomic) IBOutlet UITextField *thickTextField;
@property (weak, nonatomic) IBOutlet UITextField *advanceTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *shadowLbl;
@property (weak, nonatomic) IBOutlet UIView *submitView;
@end
