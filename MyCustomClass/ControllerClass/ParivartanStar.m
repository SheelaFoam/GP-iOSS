//
//  ParivartanStar.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "ParivartanStar.h"

@interface ParivartanStar ()

@end

@implementation ParivartanStar

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
    if ([[PassbookModel sharedInstance].detail[@"PARIVATAN STAR"] count] > 0) {
        return [[PassbookModel sharedInstance].detail[@"PARIVATAN STAR"] count];
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ParivartanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParivartanCell"];
    
    if (cell == nil) {
        cell = [[ParivartanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ParivartanCell"];
    }
    
    if ([[PassbookModel sharedInstance].detail[@"PARIVATAN STAR"] count]) {
        [cell.transDateLbl setText:[PassbookModel sharedInstance].detail[@"PARIVATAN STAR"][indexPath.row][@"TRANSACTION_DATE"]];
        [cell.transDescLbl setText:[PassbookModel sharedInstance].detail[@"PARIVATAN STAR"][indexPath.row][@"TRANSACTION_DESC"]];
        [cell.drLbl setText:[PassbookModel sharedInstance].detail[@"PARIVATAN STAR"][indexPath.row][@"DEBIT"]];
        [cell.crLbl setText:[PassbookModel sharedInstance].detail[@"PARIVATAN STAR"][indexPath.row][@"CREDIT"]];
        [cell.noDataLbl setAlpha:0.0];
        [cell.stackView setAlpha:1.0];
    } else {
        [cell.noDataLbl setAlpha:1.0];
        [cell.stackView setAlpha:0.0];
    }
    
    return cell;   
}

- (void) initialSetup {
    
    if ([[PassbookModel sharedInstance].summary[@"PARIVATAN STAR"] count] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_openingLbl setText:[PassbookModel sharedInstance].summary[@"PARIVATAN STAR"][@"OPENING"]];
            [_closingLbl setText:[PassbookModel sharedInstance].summary[@"PARIVATAN STAR"][@"CLOSING"]];
            [_creditLbl setText:[PassbookModel sharedInstance].summary[@"PARIVATAN STAR"][@"CR"]];
            [_debitLbl setText:[PassbookModel sharedInstance].summary[@"PARIVATAN STAR"][@"DR"]];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_openingLbl setText:@"0"];
            [_closingLbl setText:@"0"];
            [_creditLbl setText:@"0"];
            [_debitLbl setText:@"0"];
        });
    }
    
    [_parivartanTable reloadData];
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
