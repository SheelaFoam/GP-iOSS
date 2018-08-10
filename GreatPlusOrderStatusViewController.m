/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusOrderStatusViewController.h"
#import "OptionCustomCell.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "UserDefaultStorage.h"
#import "GreatPlusPlaceOrderViewController.h"
#import "HomeViewController.h"

@interface GreatPlusOrderStatusViewController ()

@end

@implementation GreatPlusOrderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mLabelForAppType.text = [NSString stringWithFormat:@"%@ app",[[UserDefaultStorage getUserDealerType] lowercaseString]];
    [self loadCornerRadious];
    statusCodeForOrder        = EmptyString;
    mTextForTo.text           = [self findCurrentDate];
    mTextForFrom.text         = [self find15DaysAgoDate];
    [self getOrderList];
    [self loadOrderStatusArray];
    // Do any additional setup after loading the view.
}

- (NSString *) find15DaysAgoDate {
    NSDate *now = [NSDate date];
    NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:-15*24*60*60];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    return [dateFormatter stringFromDate:sevenDaysAgo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (NSString *)findCurrentDate {
    NSDate *todayDate = [NSDate date]; // get today date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"]; //Here we can set the format which we need
    return [dateFormatter stringFromDate:todayDate];// here convert date in
}

#pragma MARK for Getting Menu Item List

- (void) getOrderList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_ORDER_STATUS_APPROVAL_INIT withDictionaryInfo:[JsonBuilder buildOrederViewJsonObject:mTextForFrom.text withToDate:mTextForTo.text andStatus:statusCodeForOrder] andTagName:OrderViewStatusServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            mOrderStatusContainer = [[NSMutableArray alloc] init];
            if (statusCode == StatusCode) {
                for (NSMutableDictionary *ldic in result[productKey]) {
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
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:self tag:NetworkAlertTag];
    }
}

- (IBAction)mBackBtnTapped:(UIButton *)sender {
    
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//
//    HomeViewControllerVC.menuString=@"Left";

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mCustomBtnTapped:(UIButton *)sender {
    NSLog(@"%d",(int)sender.tag);
     [self removePicker];
    switch (sender.tag) {
        case 0: {
            [[NSUserDefaults standardUserDefaults] setValue:FromDateTitle forKey:DateKey];
            [self datePickerPopUP:mTextForFrom.text];
        }
            break;
        case 1: {
            [[NSUserDefaults standardUserDefaults] setValue:ToDate forKey:DateKey];
            [self datePickerPopUP:mTextForTo.text];
        }
            break;
        case 2: {
            [[NSUserDefaults standardUserDefaults] setObject:SelectOrderTitle forKey:titleKey];
            [self customPopUP];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)mGoBtnTapped:(UIButton *)sender {
    [self removePicker];
    [self getOrderList];
}

#pragma MARK For UI TABLE VIEW Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mOrderStatusContainer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuse = cellIdentifier;
    
    OptionCustomCell *cell = (OptionCustomCell *)[tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:OptionCustomCellCtrl owner:self options:nil] ;
        
        for(id currentObject in topLevelObjects) {
            
            if([currentObject isKindOfClass:[UITableViewCell class]]) {
                
                cell = (OptionCustomCell *)currentObject;
                break;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([mOrderStatusContainer count] > 0) {
           
            cell.mLblForType.text      = mOrderStatusContainer[indexPath.row][product_display_nameKey];
            
            cell.mLblForDelearName.text = [NSString stringWithFormat:@"Delear Name: %@",mOrderStatusContainer[indexPath.row][dealer_nameKey]];
            
            cell.mLblForOrderName.text = [NSString stringWithFormat:@"Order No: %@",mOrderStatusContainer[indexPath.row][order_numberKey]];
            cell.mLblForOrderDate.text = [NSString stringWithFormat:@"Date: %@",mOrderStatusContainer[indexPath.row][order_dateKey]];
            
            cell.mLblForOrderRemark.text = [NSString stringWithFormat:@"Remark: %@",mOrderStatusContainer[indexPath.row][remarkKey]];
            if ([[NSString stringWithFormat:@"%@",mOrderStatusContainer[indexPath.row][thickKey]] isEqualToString:EmptyString]) {
                cell.mLblForOrderID.text = [NSString stringWithFormat:@"LxW : %@x%@",mOrderStatusContainer[indexPath.row][lengthKey],mOrderStatusContainer[indexPath.row][breadthKey]];
            } else {
                cell.mLblForOrderID.text = [NSString stringWithFormat:@"LxWxT : %@x%@x%@",mOrderStatusContainer[indexPath.row][lengthKey],mOrderStatusContainer[indexPath.row][breadthKey],mOrderStatusContainer[indexPath.row][thickKey]];
            }
            
            cell.mLblForOrderQuantity.text = [NSString stringWithFormat:@"Qty: %@ %@",mOrderStatusContainer[indexPath.row][qtyKey],mOrderStatusContainer[indexPath.row][uomKey]];
            
            cell.mLblForOrderStatus.text = [self getStatus:[[NSString stringWithFormat:@"%@",mOrderStatusContainer[indexPath.row][statusKey]] intValue]];
//            if ([[UserDefaultStorage getUserDealerType] isEqualToString:@"DISTRIBUTOR"]) {
//                cell.mBtnForEdit.hidden                          = NO;
//                cell.mBtnForDelete.hidden                        = NO;
//                cell.mBtnForEdit.tag                             = indexPath.row;
//                [cell.mBtnForEdit addTarget:self action:@selector(mBtnForEditBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
//                cell.mBtnForDelete.tag                           = indexPath.row;
//                [cell.mBtnForDelete addTarget:self action:@selector(mBtnForDeleteBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
//            }
        }
    }
    return cell;
    
    return nil;
}

- (void) mBtnForEditBtnTapped :(UIButton *)sender {
    UIStoryboard *mainStoryBoard                           = [UIStoryboard storyboardWithName:MainKey bundle:nil];
    GreatPlusPlaceOrderViewController *loginViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:GreatPlusPlaceOrderViewControllerCtrl];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void) mBtnForDeleteBtnTapped :(UIButton *)sender {
    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Comming soon...!" delegate:nil tag:0];
}

#pragma mark - TableViewdelegate&&TableViewdataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 226.0f;
}

#pragma Mark DatePicker Delegate Method

- (void) datePickerPopUP :(NSString *)str {
    if(datePicker == nil) {
        
        NSArray* nibViews = [[NSBundle mainBundle]loadNibNamed:FCDOBDatePickerCtrl owner:self options:nil];
        datePicker           = (FCDOBDatePicker *)[nibViews lastObject];
        datePicker.delegate = self;
        [datePicker setFrame:CGRectMake(0.0f, (self.view.frame.size.height - 268.0f)/2, self.view.frame.size.width, 268.0f)];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:nil];
    [UIView setAnimationDuration:0.50];
    [self.view addSubview:datePicker];
     [[NSNotificationCenter defaultCenter ] postNotificationName:someThingSelectedInDetailDOBTitle object:str];
    [UIView commitAnimations];
    
}

- (void)onDOBDatePickerCancel:(id)sender {
    
    [datePicker removeFromSuperview];
    datePicker = nil;
}

- (void)onDOBDatePickerDone:(id)sender selectedDate:(NSString *)str{
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:DateKey] isEqualToString:FromDateTitle]) {
        mTextForFrom.text = str;
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:DateKey] isEqualToString:ToDate]) {
        mTextForTo.text = str;
    }
    [datePicker removeFromSuperview];
    datePicker = nil;
}

# pragma Category Picker Delegates

- (void) customPopUP {
    
    if(customPicker == nil) {
        
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:CityViewCtrl owner:self options:nil];
        customPicker           = (CityView *) [nibViews lastObject];
        customPicker.delegate = self;
        
        [customPicker setFrame:CGRectMake(0.0f, (self.view.frame.size.height - 268.0f)/2, self.view.frame.size.width, 268.0f)];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:nil];
    [UIView setAnimationDuration:0.50];
    [self.view addSubview:customPicker];
    [UIView commitAnimations];
    
}

- (void)onCityTableCancel:(id)sender {
    [customPicker removeFromSuperview];
    customPicker = nil;
}

- (void)onCityDone:(id)sender selectedClentFocus:(NSArray *)str {
    if (str == nil || str.count == 0) {
    } else {
        if(str.count > 0){
            mTextForStatus.text = [[str objectAtIndex:0] objectForKey:NameKey];
            statusCodeForOrder  = [[str objectAtIndex:0] objectForKey:statusCodeKey];
        }
    }
    [customPicker removeFromSuperview];
    customPicker = nil;
}

- (void) removePicker {
    [self onCityTableCancel:nil];
    [self onDOBDatePickerCancel:nil];
}

#pragma MARK for Corner Radious for Button and UI TextField

-(void) loadCornerRadious {
    
    mViewForFrom.layer.borderWidth          = 1.0;
    mViewForFrom.layer.cornerRadius         = 2.0;
    mViewForFrom.layer.borderColor          = GBlueColour.CGColor;
    mViewForFrom.layer.masksToBounds        = YES;
    
    mViewForTo.layer.borderWidth            = 1.0;
    mViewForTo.layer.cornerRadius           = 2.0;
    mViewForTo.layer.borderColor            = GBlueColour.CGColor;
    mViewForTo.layer.masksToBounds          = YES;
    
    mViewForStatus.layer.borderWidth        = 1.0;
    mViewForStatus.layer.cornerRadius       = 2.0;
    mViewForStatus.layer.borderColor        = GBlueColour.CGColor;
    mViewForStatus.layer.masksToBounds      = YES;
}

- (NSString *)getStatus :(int)statusValue {
    NSString *statusMessage = nil;
    /*if (statusValue == 0) {
        statusMessage = @"Pending";
    } else */if (statusValue == 1) {
        statusMessage = ApprovedTitle;
    } else if (statusValue == 2) {
        statusMessage = RejectedTitle;
    } else if (statusValue == 3) {
        statusMessage = DispatchedTitle;
    }
    return statusMessage;
}

- (void)loadOrderStatusArray {
    NSMutableArray *tempArray  = [[NSMutableArray alloc] init];
     NSMutableDictionary *lDic  = [NSMutableDictionary dictionaryWithObjectsAndKeys:AllOrderTitle,NameKey, @"",statusCodeKey, NOTitle,SELECTEDKey, nil];
     NSMutableDictionary *lDic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:ApprovedTitle,NameKey, @"1",statusCodeKey, NOTitle,SELECTEDKey, nil];
     NSMutableDictionary *lDic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:RejectedTitle,NameKey, @"2",statusCodeKey, NOTitle,SELECTEDKey, nil];
     NSMutableDictionary *lDic4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:DispatchedTitle,NameKey, @"3",statusCodeKey, NOTitle,SELECTEDKey, nil];
    [tempArray addObject:lDic];
    [tempArray addObject:lDic2];
    [tempArray addObject:lDic3];
    [tempArray addObject:lDic4];
    [MailClassViewController sharedInstance].mOrderStatusArray = tempArray;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self getOrderList];
}

@end
