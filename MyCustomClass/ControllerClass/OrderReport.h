//
//  OrderReport.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 21/05/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSLDatePickerDialog.h"
#import "OrderReportCell.h"

@interface OrderReport : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *orderReportTable;

@property (weak, nonatomic) IBOutlet UIButton *fromDateButton;
@property (weak, nonatomic) IBOutlet UIButton *toDateButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDealerButton;
@property (weak, nonatomic) IBOutlet UIButton *selectStatusButton;

@property (weak, nonatomic) IBOutlet UIView *searchDealerView;
@property (weak, nonatomic) IBOutlet UILabel *shadowLbl;


//Action Outlets
- (IBAction)fromDate:(id)sender;
- (IBAction)toDate:(id)sender;
- (IBAction)selectDealer:(id)sender;
- (IBAction)selectStatus:(id)sender;
- (IBAction)go:(id)sender;
- (IBAction)back:(id)sender;

@end
