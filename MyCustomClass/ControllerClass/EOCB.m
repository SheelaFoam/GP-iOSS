//
//  EOCB.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "EOCB.h"

@interface EOCB()

@end

@implementation EOCB

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([[PassbookModel sharedInstance].detail[@"EOCB"] count] > 0) {
        return [[PassbookModel sharedInstance].detail[@"EOCB"] count];
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EOCBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EOCBCell"];
    
    if (cell == nil) {

        cell = [[EOCBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EOCBCell"];
    }
    
    if ([[PassbookModel sharedInstance].detail[@"EOCB"] count] > 0) {
        [cell.transDateLbl setText:[PassbookModel sharedInstance].detail[@"EOCB"][indexPath.row][@"TRANSACTION_DATE"]];
        [cell.transDescLbl setText:[PassbookModel sharedInstance].detail[@"EOCB"][indexPath.row][@"TRANSACTION_DESC"]];
        [cell.drLbl setText:[PassbookModel sharedInstance].detail[@"EOCB"][indexPath.row][@"DEBIT"]];
        [cell.crLbl setText:[PassbookModel sharedInstance].detail[@"EOCB"][indexPath.row][@"CREDIT"]];
        [cell.noDataLbl setAlpha:0.0];
        [cell.stackView setAlpha:1.0];
    } else {
        [cell.stackView setAlpha:0.0];
        [cell.noDataLbl setAlpha:1.0];
    }
    
    return cell;
}

- (void) initialSetup {
    
    
    if ([[PassbookModel sharedInstance].summary[@"EOCB"] count] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_openingLbl setText:[PassbookModel sharedInstance].summary[@"EOCB"][@"OPENING"]];
            [_closingLbl setText:[PassbookModel sharedInstance].summary[@"EOCB"][@"CLOSING"]];
            [_creditLbl setText:[PassbookModel sharedInstance].summary[@"EOCB"][@"CR"]];
            [_debitLbl setText:[PassbookModel sharedInstance].summary[@"EOCB"][@"DR"]];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_openingLbl setText:@"0"];
            [_closingLbl setText:@"0"];
            [_creditLbl setText:@"0"];
            [_debitLbl setText:@"0"];
        });
    }
    
    [_eocbTable reloadData];
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
