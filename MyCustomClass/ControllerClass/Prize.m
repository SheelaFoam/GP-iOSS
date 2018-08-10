//
//  Prize.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "Prize.h"

@interface Prize ()

@end

@implementation Prize

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
    
    [_prizeTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[PassbookModel sharedInstance].detail[@"PRIZE"] count] > 0) {
        return [[PassbookModel sharedInstance].detail[@"PRIZE"] count];
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PrizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrizeCell"];
    
    if (cell == nil) {
        cell = [[PrizeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PrizeCell"];
    }
    
    if ([[PassbookModel sharedInstance].detail[@"PRIZE"] count] > 0) {
        [cell.transDateLbl setText:[PassbookModel sharedInstance].detail[@"PRIZE"][indexPath.row][@"TRANSACTION_DATE"]];
        [cell.transDescLbl setText:[PassbookModel sharedInstance].detail[@"PRIZE"][indexPath.row][@"TRANSACTION_DESC"]];
        [cell.drLbl setText:[PassbookModel sharedInstance].detail[@"PRIZE"][indexPath.row][@"DEBIT"]];
        [cell.crLbl setText:[PassbookModel sharedInstance].detail[@"PRIZE"][indexPath.row][@"CREDIT"]];
        [cell.noDataLbl setAlpha:0.0];
        [cell.stackView setAlpha:1.0];
    } else {
        [cell.noDataLbl setAlpha:1.0];
        [cell.stackView setAlpha:0.0];
    }
    
    return cell;
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
