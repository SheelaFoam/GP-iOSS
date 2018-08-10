//
//  CashAmount.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "CashAmount.h"

@interface CashAmount ()

@end

@implementation CashAmount

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initialSetup];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[PassbookModel sharedInstance].detail[@"CASH AMOUNT"] count] > 0) {
        return [[PassbookModel sharedInstance].detail[@"CASH AMOUNT"] count];
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CashAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CashAmountCell"];
    
    if (cell == nil) {
        cell = [[CashAmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CashAmountCell"];
    }
    
    if ([[PassbookModel sharedInstance].detail[@"CASH AMOUNT"] count] > 0) {
        [cell.transDateLbl setText:[PassbookModel sharedInstance].detail[@"CASH AMOUNT"][indexPath.row][@"TRANSACTION_DATE"]];
        [cell.transDescLbl setText:[PassbookModel sharedInstance].detail[@"CASH AMOUNT"][indexPath.row][@"TRANSACTION_DESC"]];
        [cell.drLbl setText:[PassbookModel sharedInstance].detail[@"CASH AMOUNT"][indexPath.row][@"DEBIT"]];
        [cell.crLbl setText:[PassbookModel sharedInstance].detail[@"CASH AMOUNT"][indexPath.row][@"CREDIT"]];
        [cell.noDataLbl setAlpha:0.0];
        [cell.stackView setAlpha:1.0];
    } else {
        [cell.noDataLbl setAlpha:1.0];
        [cell.stackView setAlpha:0.0];
    }
    
    return cell;
}

- (void) initialSetup {
    
    if ([[PassbookModel sharedInstance].summary[@"CASH AMOUNT"] count] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_openingLbl setText:[PassbookModel sharedInstance].summary[@"CASH AMOUNT"][@"OPENING"]];
            [_closingLbl setText:[PassbookModel sharedInstance].summary[@"CASH AMOUNT"][@"CLOSING"]];
            [_creditLbl setText:[PassbookModel sharedInstance].summary[@"CASH AMOUNT"][@"CR"]];
            [_debitLbl setText:[PassbookModel sharedInstance].summary[@"CASH AMOUNT"][@"DR"]];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_openingLbl setText:@"0"];
            [_closingLbl setText:@"0"];
            [_creditLbl setText:@"0"];
            [_debitLbl setText:@"0"];
        });
    }
    
    [_cashAmountTable reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
