/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusOrderApprovelViewController.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "UserDefaultStorage.h"
#import "OptionCustomOrderCell.h"

@interface GreatPlusOrderApprovelViewController ()

@end

@implementation GreatPlusOrderApprovelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mLabelForAppType.text = [NSString stringWithFormat:@"%@ app",[[UserDefaultStorage getUserDealerType] lowercaseString]];
    [self getOrderApprovalList];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
- (IBAction)mBackBtnTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma MARK for Getting Menu Item List

- (void) getOrderApprovalList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_ORDER_STATUS_INIT withDictionaryInfo:[JsonBuilder buildOrederApprovalJsonObject] andTagName:OrderApprovalServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            mOrderStatusContainer = [[NSMutableArray alloc] init];
            if (statusCode == StatusCode) {
                for (NSMutableDictionary *ldic in result[@"product"]) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                    [mOrderStatusContainer addObject:d];
                }
                if ([mOrderStatusContainer count] == 0) {
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:NoRecordAlert delegate:nil tag:0];
                } 
            } else {
                [MailClassViewController toastWithMessage:message AndObj:self.view];
            }
            [mTableForOrder reloadData];
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:@"Connection.!!!" message:OhnoAlert delegate:self tag:0];
    }
}


#pragma MARK For UI TABLE VIEW Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mOrderStatusContainer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuse = @"cell";
    
    OptionCustomOrderCell *cell = (OptionCustomOrderCell *)[tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OptionCustomOrderCell" owner:self options:nil] ;
        
        for(id currentObject in topLevelObjects) {
            
            if([currentObject isKindOfClass:[UITableViewCell class]]) {
                
                cell = (OptionCustomOrderCell *)currentObject;
                break;
            }
        }
        if ([mOrderStatusContainer count] > 0) {
            UIView *selectedView = [[UIView alloc] init];
            selectedView.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1.0f];
            cell.selectedBackgroundView =  selectedView;
            
            cell.mLblForOrderName.text = [NSString stringWithFormat:@"Order No: %@",mOrderStatusContainer[indexPath.row][@"order_number"]];
            cell.mLblForOrderDate.text = [NSString stringWithFormat:@"Date: %@",mOrderStatusContainer[indexPath.row][@"order_date"]];
            
            cell.mLblForDelearName.text = [NSString stringWithFormat:@"Delear Name: %@",mOrderStatusContainer[indexPath.row][@"dealer_name"]];
            
             cell.mLblForCustomerName.text = [NSString stringWithFormat:@"Customer Name:%@",mOrderStatusContainer[indexPath.row][@"customer_name"]];
        
            cell.mLblForOrderRemark.text = [NSString stringWithFormat:@"Item Name:%@",mOrderStatusContainer[indexPath.row][@"product_display_name"]];
            
            if ([[NSString stringWithFormat:@"%@",mOrderStatusContainer[indexPath.row][@"thick"]] isEqualToString:EmptyString]) {
                cell.mLblForOrderID.text = [NSString stringWithFormat:@"LxW : %@x%@",mOrderStatusContainer[indexPath.row][@"length"],mOrderStatusContainer[indexPath.row][@"breadth"]];
            } else {
                cell.mLblForOrderID.text = [NSString stringWithFormat:@"LxWxT : %@x%@x%@",mOrderStatusContainer[indexPath.row][@"length"],mOrderStatusContainer[indexPath.row][@"breadth"],mOrderStatusContainer[indexPath.row][@"thick"]];
            }
            
            cell.mLblForOrderQuantity.text = [NSString stringWithFormat:@"Qty: %@ %@",mOrderStatusContainer[indexPath.row][@"qty"],mOrderStatusContainer[indexPath.row][@"uom"]];
            
            cell.mBtnForReject.tag                             = indexPath.row;
            [cell.mBtnForReject addTarget:self action:@selector(mBtnForRejectBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            cell.mBtnForApproved.tag                             = indexPath.row;
            [cell.mBtnForApproved addTarget:self action:@selector(mBtnForApprovedBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    return cell;
    
    return nil;
}

- (void) mBtnForRejectBtnTapped :(UIButton *)sender {
    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Comming soon...!" delegate:nil tag:0];
}

- (void) mBtnForApprovedBtnTapped :(UIButton *)sender {
    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Comming soon...!" delegate:nil tag:0];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self getOrderApprovalList];
}

#pragma mark - TableViewdelegate&&TableViewdataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220.0f;
}

@end
