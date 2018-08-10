//
//  ComplaintInfo.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 15/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "ComplaintInfo.h"
#import "InfoCell.h"
#import "SVProgressHUD.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedHeader.h"
#import <CFNetwork/CFNetwork.h>

@interface ComplaintInfo()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
    NSMutableArray *tableDataSource;
    UITextField *field;
}

@end

@implementation ComplaintInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************ TableView DataSource/Delegate Methods ************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    
    if (cell == nil) {
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoCell"];
    }
    
    [cell.tileView layer].cornerRadius = 5.0;
    [cell.tileView layer].shadowColor = UIColor.blackColor.CGColor;
    [cell.tileView layer].shadowRadius = 1.0;
    [cell.tileView layer].shadowOpacity = 1.0;
    [cell.tileView layer].shadowOffset = CGSizeMake(0.0, 0.5);
    
    [cell.complaintIDLbl setText:tableDataSource[indexPath.row][@"compID"]];
    [cell.compDateLbl setText:tableDataSource[indexPath.row][@"compDate"]];
    [cell.cityLbl setText:tableDataSource[indexPath.row][@"city"]];
    [cell.nameLbl setText:tableDataSource[indexPath.row][@"name"]];
    [cell.mobileLbl setText:tableDataSource[indexPath.row][@"mobile"]];
    [cell.addressLbl setText:tableDataSource[indexPath.row][@"address"]];
    [cell.productLbl setText:tableDataSource[indexPath.row][@"product"]];
    [cell.billDateLbl setText:tableDataSource[indexPath.row][@"bill"]];
    [cell.dealerLbl setText:tableDataSource[indexPath.row][@"dealer"]];
    [cell.problemLbl setText:tableDataSource[indexPath.row][@"problem"]];
    [cell.pendingLbl setText:tableDataSource[indexPath.row][@"pending"]];
    
    return  cell;
}

//************ Textfield Delegate Methods ************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    field = textField;
    [textField resignFirstResponder];
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    field = textField;
    return true;
}

- (IBAction)search:(id)sender {
    
    [tableDataSource removeAllObjects];
    NSString *searchStr = [field.text lowercaseString];
    
    if ([searchStr isEqualToString:@""]) {
        
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please enter text to search." delegate:nil tag:0];
    } else {
        for (int i = 0; i < _response.count; i++) {
            
            NSString *tempStr1 = [_response[i][@"compID"] lowercaseString];
            NSString *tempStr2 = [_response[i][@"compDate"] lowercaseString];
            NSString *tempStr3 = [_response[i][@"city"] lowercaseString];
            NSString *tempStr4 = [_response[i][@"name"] lowercaseString];
            NSString *tempStr5 = [_response[i][@"mobile"] lowercaseString];
            NSString *tempStr6 = [_response[i][@"address"] lowercaseString];
            NSString *tempStr7 = [_response[i][@"product"] lowercaseString];
            NSString *tempStr8 = [_response[i][@"bill"] lowercaseString];
            NSString *tempStr9 = [_response[i][@"dealer"] lowercaseString];
            NSString *tempStr10 = [_response[i][@"problem"] lowercaseString];
            NSString *tempStr11 = [_response[i][@"pending"] lowercaseString];
            
            if (field == _complaintIDTextField) {
                if ([tempStr1 containsString:searchStr]) {
                    [tableDataSource addObject:_response[i]];
                    break;
                }
            } else if (field == _customerMobileTextField) {
                if ([tempStr5 containsString:searchStr]) {
                    [tableDataSource addObject:_response[i]];
                }
            } else {
                if ([tempStr1 containsString:searchStr] || [tempStr2 containsString:searchStr] || [tempStr3 containsString:searchStr] || [tempStr4 containsString:searchStr] || [tempStr5 containsString:searchStr] || [tempStr6 containsString:searchStr] || [tempStr7 containsString:searchStr] || [tempStr8 containsString:searchStr] || [tempStr9 containsString:searchStr] || [tempStr10 containsString:searchStr] || [tempStr11 containsString:searchStr]) {
                    [tableDataSource addObject:_response[i]];
                }
            }
        }
        if (tableDataSource.count == 0) {
            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"No data found." delegate:nil tag:0];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_complaintInfoTable reloadData];
        });
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//************ Custom Methods ************

-(void) initialSetup {
    tableDataSource = [[NSMutableArray alloc] init];
    [tableDataSource addObject:_response[_index]];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
