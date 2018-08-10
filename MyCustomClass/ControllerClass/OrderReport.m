//
//  OrderReport.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 21/05/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "OrderReport.h"

@interface OrderReport()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation OrderReport

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_fromDateButton setTitle:[self getOldDate] forState:UIControlStateNormal];
    [_toDateButton setTitle:[self getCurrentDate] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fromDate:(id)sender {
    
    [self openDatePicker:@"From Date" andbutton:_fromDateButton];
}

- (IBAction)toDate:(id)sender {
    
    [self openDatePicker:@"To Date" andbutton:_toDateButton];
}

- (IBAction)selectDealer:(id)sender {
    
}

- (IBAction)selectStatus:(id)sender {
    
}

- (IBAction)go:(id)sender {
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}

//Delegate and Datasource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"OrderReportCell";
    
    OrderReportCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[OrderReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row%2==0) {
        
        cell.orderNoLbl.backgroundColor = [UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:0.4];
        cell.productLbl.backgroundColor = [UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:0.4];
        cell.statusLbl.backgroundColor = [UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:0.4];
        cell.detailsLbl.backgroundColor = [UIColor colorWithRed:12.0/255.0 green:76.0/255.0 blue:164.0/255.0 alpha:0.4];
        
    } else {
        
        cell.orderNoLbl.backgroundColor = UIColor.whiteColor;
        cell.productLbl.backgroundColor = UIColor.whiteColor;
        cell.statusLbl.backgroundColor = UIColor.whiteColor;
        cell.detailsLbl.backgroundColor = UIColor.whiteColor;
    }
    
    return  cell;
}

//Custom Methods

- (void) openDatePicker: (NSString *) dateType andbutton: (UIButton *)dateButton {
    
    LSLDatePickerDialog *datePicker = [[LSLDatePickerDialog alloc] init];
    [datePicker showWithTitle:[NSString stringWithFormat:@"Please select %@", dateType] doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
        if(date) {
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd MMM YYYY"];
            NSString *dateString = [dateFormat stringFromDate:date];
            [dateButton setTitle:dateString forState:UIControlStateNormal];
        }
    }];
}

- (void) getAllOrder {
    
    
}

- (NSString *) getCurrentDate {
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMM YYYY"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    return dateString;
}

- (NSString *) getOldDate {
    
    NSDate *oldDate = [NSDate date];
    NSDate *fifteenDaysAgo = [oldDate dateByAddingTimeInterval:-15*24*60*60];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMM YYYY"];
    NSString *dateString = [dateFormat stringFromDate:fifteenDaysAgo];
    
    return dateString;
}

@end
