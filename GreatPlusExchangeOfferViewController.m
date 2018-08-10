/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusExchangeOfferViewController.h"
#import "GreatPlusSharedHeader.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "UserDefaultStorage.h"
#import "ScannerViewController.h"
#import "HomeViewController.h"
#import "historyModel.h"
#import "SerialNoCell.h"
#import "SuggestionsCell.h"
#import "GuaranteeLog.h"
#import "GCard.h"
#import "Passbook.h"

@interface GreatPlusExchangeOfferViewController()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
    NSMutableDictionary *responseObj;
    
    NSMutableArray *serialNosArray;
    NSMutableArray *selectedSerialNos;
    NSMutableArray *dropDownArray;
    NSMutableArray *salesRepArray;
    NSMutableArray *suggestionsArray;
    
    UITapGestureRecognizer *tap;
    
    NSInteger countID;
    
    BOOL twoSelected;
}

@end

@implementation GreatPlusExchangeOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    txtFieldInvoiceDate.text=@"";
    checkValue = false;
    _strtitle = @"G CARD REGISTRATION";
    mLblForNavTitle.text = _strtitle;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Value"];
    [UserDefaultStorage setBarCodeData:@""];
//    mScrollView.contentSize = ([self isRetina4]) ? CGSizeMake(0,700.0f) : CGSizeMake(0,600.0f);
    mViewForInfo.frame = CGRectMake(mViewForInfo.frame.origin.x, mViewForInfo.frame.origin.y, mViewForInfo.frame.size.width, 90.0f);
    [self loadCornerRadious];
    [self getExchangeInfoData];
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [txtFieldInvoiceDate setInputView:datePicker];
    
    [mNoExchngBtn layer].borderWidth = 1.0;
    [mNoExchngBtn layer].borderColor = UIColor.blackColor.CGColor;
    [mNoExchngBtn layer].masksToBounds = false;
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    responseObj = [[NSMutableDictionary alloc] init];
    serialNosArray = [[NSMutableArray alloc] init];
    selectedSerialNos = [[NSMutableArray alloc] init];
    salesRepArray = [[NSMutableArray alloc] init];
    suggestionsArray = [[NSMutableArray alloc] init];
    
    self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    self.shadowLbl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.popupView layer].cornerRadius = 7.5;
    self.shadowLbl.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowLbl.layer.shadowRadius = 5.0;
    self.shadowLbl.layer.shadowOpacity = 1.0;
    self.shadowLbl.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.shadowLbl.layer.masksToBounds = false;
    
    [_suggestionsTable setAlpha:0.0];
    
    [self getSalesRepData:[historyModel sharedhistoryModel].uid completionHandler:^{
        NSLog(@"%@", salesRepArray);
    }];
    [_suggestionsTable layer].borderWidth = 1.0;
    [_suggestionsTable layer].borderColor = UIColor.blackColor.CGColor;
}

-(void)dismissKeyboard {
    [bundleNumberField resignFirstResponder];
    [mTextForSerialNo1 resignFirstResponder];
    [mTextForSerialNo2 resignFirstResponder];
    [salesRepTxtField resignFirstResponder];
}

-(void) dateTextField:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)txtFieldInvoiceDate.inputView;
//    [picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
//    [dateFormat setDateFormat:@"yyyy-dd-MM"];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    txtFieldInvoiceDate.text = [NSString stringWithFormat:@"%@",dateString];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Value"] isEqualToString:@"Scan1"]) {
        mTextForSerialNo1.text = [UserDefaultStorage getBarCodeData];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Value"] isEqualToString:@"Scan2"]) {
        mTextForSerialNo2.text = [UserDefaultStorage getBarCodeData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma MARK for Getting Exchange Information List

- (void) getExchangeInfoData {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_EX_INFO_INIT withDictionaryInfo:[JsonBuilder buildExInfoJsonObject:[UserDefaultStorage getUserDealerID]] andTagName:ExInfoServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                mLblForEOCBInfo.text  = [NSString stringWithFormat:@"%@",([MailClassViewController checkNull:[result objectForKey:op_eocbKey]]) ? [result objectForKey:op_eocbKey] : NATitle];
                mLblForSmileInfo.text = [NSString stringWithFormat:@"%@",([MailClassViewController checkNull:[result objectForKey:op_smileKey]]) ? [result objectForKey:op_smileKey] : NATitle];
                mLblFormattressPointsInfo.text = [NSString stringWithFormat:@"%@",([MailClassViewController checkNull:[result objectForKey:op_returned_mattressKey]]) ? [result objectForKey:op_returned_mattressKey] : NATitle];
            } else {
                [MailClassViewController toastWithMessage:message AndObj:self.view];
            }
        }];
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:self tag:0];
    }
}

-(BOOL) isRetina4 {
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return ([UIScreen mainScreen].scale == RETINA_SCALE && screenHeight == RETINA_4_HEIGHT);
}

-(void)scrollToPositionUP:(BOOL)isUP withTxtField:(UITextField *)textField {
    
    if ([self isRetina4]) {
        isUP ? ({
            
            CGPoint point;
            CGRect rect = [textField bounds];
            rect        = [textField convertRect:rect toView:mScrollView];
            point       = rect.origin;
            if (point.y > 200) {
                point.x = 0;
                point.y -=100;
                [mScrollView setContentOffset:point animated:YES];
            }}) : [mScrollView setContentOffset:offSet animated:YES];
    } else {
        isUP ? ({
            
            CGPoint point;
            CGRect rect = [textField bounds];
            rect        = [textField convertRect:rect toView:mScrollView];
            point       = rect.origin;
            if (point.y > 160) {
                point.x = 0;
                point.y -=100;
                
                [mScrollView setContentOffset:point animated:YES];
            }}) : [mScrollView setContentOffset:offSet animated:YES];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    mScrollView.contentSize = ([self isRetina4]) ? CGSizeMake(0,700.0f) : CGSizeMake(0,600.0f);
    selectedField = textField;
    if (textField == mTextForSerialNo1) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForSerialNo2) {
        [self scrollToPositionUP:YES withTxtField:selectedField];
    } else if (textField == mTextForConsumerNo) {
        
        [self scrollToPositionUP:YES withTxtField:selectedField];
    }
    return YES;
}

#pragma mark - TEXTFIELD DELEGATE

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == mTextForSerialNo1) {
        
        [mTextForSerialNo2 becomeFirstResponder];
    } else if (textField == mTextForSerialNo2) {
        
        if ([MailClassViewController validatePassword:mTextForSerialNo1.text andNewPassword:mTextForSerialNo2.text]) {
            [mTextForSerialNo2 resignFirstResponder];
            [mTextForSerialNo2 setText:EmptyString];
            [MailClassViewController toastWithMessage:DiffPass AndObj:self.view];
        } else {
            [mTextForConsumerNo becomeFirstResponder];
        }
    } else if (textField == mTextForConsumerNo) {
        [self downScroll];
    } else if (textField == customerNameField) {
        [self downScroll];
    } else if (textField = txtFieldInvoiceNumber) {
        [self downScroll];
    }
    return YES;
}

-(void)downScroll {
    mScrollView.contentSize = ([self isRetina4]) ? CGSizeMake(0,700.0f) : CGSizeMake(0,700.0f);
    [mScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [mScrollView setScrollEnabled:YES];
    [mTextForConsumerNo resignFirstResponder];
}


- (IBAction)getBundleTapped:(id)sender {
    
//    [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_GET_SERIAL_NUMBERS_FROM_BUNDLE withDictionaryInfo:[JsonBuilder buildBundleNumberJSONWith:bundleNumberField.text] andTagName:SerialNumberFromBundle andCompletionHandler:^(id result, int statusCode, NSString *message) {
//        [activityIndicator hideView];
//        if (statusCode == StatusCode) {
//
//            NSLog(@"%@",[result objectForKey:@"op_message"]);
//
//            if(([result objectForKey:@"op_serial1"] == [NSNull null]) || ([result objectForKey:@"op_serial2"] == [NSNull null]))
//            {
//                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Sorry! serial number is not linked with bundle number" delegate:nil tag:0];
//            }
//            else
//            {
//                mTextForSerialNo1.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"op_serial1"]];
//                mTextForSerialNo2.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"op_serial2"]];
//            }
//
//
//        } else {
//            [MailClassViewController toastWithMessage:message AndObj:self.view];
//        }
//    }];
    if (![bundleNumberField.text isEqualToString:@""]) {
        
        [self getBundleData:[historyModel sharedhistoryModel].uid withBundleNumber:bundleNumberField.text completionHandler:^{
            if ([responseObj objectForKey:@"status"]) {
//                serialNosArray = [[responseObj objectForKey:@"user"] objectForKey:@"serial_number"];
                for (int i = 0; i < [[[responseObj objectForKey:@"user"] objectForKey:@"serial_number"] count]; i++) {
                    if (![serialNosArray containsObject:[[responseObj objectForKey:@"user"] objectForKey:@"serial_number"][i]]){
                        NSString *temp = [[responseObj objectForKey:@"user"] objectForKey:@"serial_number"][i];
                        if (![temp isKindOfClass:[NSNull class]]) {
                            [serialNosArray addObject:[[responseObj objectForKey:@"user"] objectForKey:@"serial_number"][i]];
                        }
                    }
                }
                
                if (serialNosArray.count == 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [bundleNumberField resignFirstResponder];
                        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Sorry! No serial numbers are linked with this bundle number." delegate:nil tag:0];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [bundleNumberField resignFirstResponder];
                        [tap setEnabled:false];
                        [_serialNosTable reloadData];
                        [self openPopupPunchInView:_popupView shadowLabel:_shadowLbl];
                    });
                }
            } else {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Sorry! No serial numbers are linked with this bundle number." delegate:nil tag:0];
            }
        }];
    } else {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please enter bundle number." delegate:nil tag:0];
    }
}

-(void) getBundleData: (NSString *)uid withBundleNumber: (NSString *)bundleNo completionHandler: (void (^)(void)) completion {
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"eee4167f-6759-3e2f-b040-583c94764e44" };
    NSDictionary *parameters = @{ @"p_user_id": [NSString stringWithFormat:@"%@", uid],
                                  @"p_bundle_number": [NSString stringWithFormat:@"%@", bundleNo] };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greatplus.com/warranty_log_api/bundle_user.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        responseObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                        completion();
                                                    }
                                                }];
    [dataTask resume];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _serialNosTable) {
        return serialNosArray.count;
    } else {
        return suggestionsArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _serialNosTable) {
        return 40;
    } else {
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _serialNosTable) {
        
        SerialNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SerialNoCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        if (cell == nil) {
            cell = [[SerialNoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SerialNoCell"];
        }
        if (serialNosArray.count != 0) {
            [cell.serialNoLbl setText:serialNosArray[indexPath.row]];
        }
        
        return cell;
    } else {
        
        SuggestionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestionsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        if (cell == nil) {
            cell = [[SuggestionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SuggestionsCell"];
        }
        
        [cell.textLabel setText:suggestionsArray[indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _serialNosTable) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            if(countID <2) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                countID++;
                [selectedSerialNos addObject:serialNosArray[indexPath.row]];
            } else {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"You can only select maximum of two serial numbers only." delegate:nil tag:0];
            }
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            countID--;
            [selectedSerialNos removeLastObject];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }  else {
        
        salesRepTxtField.text = suggestionsArray[indexPath.row];
        [_suggestionsTable setAlpha:0.0];
        [tap setEnabled:true];
        [suggestionsArray removeAllObjects];
    }
}

-(void)getSalesRepData: (NSString *)uid completionHandler: (void (^)(void)) completion {
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"16af2c99-f980-6925-9f96-88a1c31d76ad" };
    NSDictionary *parameters = @{ @"p_user_id": [NSString stringWithFormat:@"%@", uid] };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greatplus.com/warranty_log_api/prc_sale_rep_info.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        NSArray *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                        for (int i=0; i<temp.count; i++) {
                                                            [salesRepArray addObject:temp[i][@"SALES_REP_NAME"]];
                                                        }
                                                        completion();
                                                    }
                                                }];
    [dataTask resume];
}

- (IBAction)submitSerialNos:(id)sender {
    
    if (selectedSerialNos.count > 0) {
        [self closePopupPunchInView:_popupView shadowLabel:_shadowLbl];
        [tap setEnabled:true];
        if (selectedSerialNos.count == 1) {
            [mTextForSerialNo1 setText:selectedSerialNos[0]];
        } else if (selectedSerialNos.count == 2 ) {
            [mTextForSerialNo1 setText:selectedSerialNos[0]];
            [mTextForSerialNo2 setText:selectedSerialNos[1]];
        }
    } else {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please select atleast one serial number." delegate:nil tag:0];
    }
}


- (IBAction)goToGuaranteeLog:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = (GuaranteeLog *)[storyboard instantiateViewControllerWithIdentifier:@"GuaranteeLog"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:true completion:nil];
}


-(void) closePopupPunchInView: (UIView *) view shadowLabel: (UILabel *) label {
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        }];
    }];
}

-(void) openPopupPunchInView: (UIView *) view shadowLabel: (UILabel *) label {
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                view.transform = CGAffineTransformIdentity;
                label.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

- (IBAction)gCard:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DealerStoryboard" bundle:nil];
    UIViewController *controller = (GCard *)[storyboard instantiateViewControllerWithIdentifier:@"GCard"];
    [self presentViewController:controller animated:true completion:nil];
}

- (IBAction)passbook:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DealerStoryboard" bundle:nil];
    UIViewController *controller = (Passbook *)[storyboard instantiateViewControllerWithIdentifier:@"Passbook"];
    [self presentViewController:controller animated:true completion:nil];
}

- (IBAction)mBackBtnTapped:(UIButton *)sender {
//    HomeViewController*HomeViewControllerVC=[[HomeViewController alloc]init];
//    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
//
//    HomeViewControllerVC.menuString=@"Left";

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mCheckBtnTapped:(UIButton *)sender {
    [self goDownKeyboard];
    if (checkBoxSelected) {
        checkValue = false;
        checkBoxSelected = false;
        [mNoExchngBtn setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    } else {
        checkValue = true;
        checkBoxSelected = true;
        [mNoExchngBtn setImage:[UIImage imageNamed:@"check_0.png"] forState:UIControlStateNormal];
    }
//    if (sender.selected) {
//        [mNoExchngBtn setSelected:NO];
////        checkValue = @"0";
//        checkValue = true;
//    } else {
//        [mNoExchngBtn setSelected:YES];
////        checkValue = @"1";
//        checkValue = false;
//    }
}

- (IBAction)mTermsBtnTapped:(UIButton *)sender {
    [self goDownKeyboard];
    if (sender.selected) {
        [mTermsBtn setSelected:NO];
    } else {
        [mTermsBtn setSelected:YES];
    }
}

- (void) goDownKeyboard {
    [mTextForSerialNo1 resignFirstResponder];
    [mTextForSerialNo2 resignFirstResponder];
    [mTextForConsumerNo resignFirstResponder];
}

#pragma Mark for Checking The All Input data is filled

- (NSString *)validateSignUpForm {
    NSString *errorMessage = GoodTitle;
    if (!(mTextForConsumerNo.text.length >= 1)){
        errorMessage = EmptyConsumer;
    } else if ([MailClassViewController validatePassword:mTextForSerialNo1.text andNewPassword:mTextForSerialNo2.text]){
        errorMessage = DiffPass;
    }
    return errorMessage;
}

- (IBAction)mSendBtnTapped:(UIButton *)sender {
    [self downScroll];
    [self goDownKeyboard];
    if ([[self validateSignUpForm] isEqualToString:GoodTitle]) {
            if ([mTextForConsumerNo.text length] == 10) {
                if (([mTextForSerialNo1.text length] > 0 || [mTextForSerialNo2.text length] == 0) || ([mTextForSerialNo2.text length] > 0 || [mTextForSerialNo1.text length] == 0)) {
                    [self sendExchangeInfoDataToServer];
                } else {
                    [MailClassViewController toastWithMessage:SerialNoSelection AndObj:self.view];
                }
            } else {
                [MailClassViewController toastWithMessage:MobileNumberLength AndObj:self.view];
            }
    } else {
        [MailClassViewController toastWithMessage:[self validateSignUpForm] AndObj:self.view];
    }
}

#pragma MARK for Sending Exchange Information to Server

- (void) sendExchangeInfoDataToServer {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        
        [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_EX_INFO_SBMT_INIT withDictionaryInfo:[JsonBuilder buildExInfoSendDataJsonObject:[UserDefaultStorage getUserDealerID] withSerialNo1:mTextForSerialNo1.text withSerialNo2:mTextForSerialNo2.text withEcob:checkValue andCustomerMobileno:mTextForConsumerNo.text withCustomerName:customerNameField.text withCustomerEmail:customerEmailField.text withInvoiceNo:txtFieldInvoiceNumber.text andInvoiceDate:txtFieldInvoiceDate.text withDealerMobileNo:[historyModel sharedhistoryModel].mobileNo anddealerUID:[historyModel sharedhistoryModel].uid withSalesRepName:salesRepTxtField.text] andTagName:ExInfoSumitServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
            [activityIndicator hideView];
            if (statusCode == StatusCode) {
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[NSString stringWithFormat:@"%@",[result objectForKey:op_messageKey]] delegate:nil tag:0];
//                [self showAlert:[NSString stringWithFormat:@"%@",[result objectForKey:@"op_message"]]];
//                [self resetTextField];
            } else {
                [MailClassViewController toastWithMessage:message AndObj:self.view];
            }
        }];
    } else {
        [activityIndicator hideView];
        [self sendDataInServerWhenThereIsNoNetwork];
        [MailClassViewController toastWithMessage:OflineAlert AndObj:self.view];
    }
}

#pragma MARK for Sending Data In Ofline Mode

- (void) sendDataInServerWhenThereIsNoNetwork {
    if ([[MailClassViewController sharedInstance] showSMSPicker]) {
//        if ([checkValue isEqualToString:@"0"]) {
        if (!checkValue) {
            [MailClassViewController sharedInstance].mStringForText = [NSString stringWithFormat:@"{%@,%@,%@,%@}",@"NE",mTextForSerialNo1.text,mTextForSerialNo2.text,mTextForConsumerNo.text];
        } else {
            [MailClassViewController sharedInstance].mStringForText = [NSString stringWithFormat:@"{%@,%@,%@}",mTextForSerialNo1.text,mTextForSerialNo2.text,mTextForConsumerNo.text];
        }
        
        UINavigationController *nav =[[MailClassViewController sharedInstance] showSMSComposerSheet];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self getExchangeInfoData];
}

#pragma MARK for Notification

-(void)showAlert :(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:EmptyString message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert setTag:0];
    [alert show];
    [self performSelector:@selector(test22:) withObject:alert afterDelay:3.00];
}

-(void)test22:(UIAlertView *) x {
    [x dismissWithClickedButtonIndex:-1 animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    if (textField == mTextForConsumerNo) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int length = (int)[currentString length];
        
        if (length > 10) {
            
            return NO;
        }
        return [string isEqualToString:filtered];
    } else if (textField == salesRepTxtField) {
        
        NSString *searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        [suggestionsArray removeAllObjects];
        for(NSString *strName in salesRepArray) {
            if([[strName lowercaseString] hasPrefix:[searchText lowercaseString]]) {
                    [suggestionsArray addObject:strName];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tap setEnabled:false];
                    [_suggestionsTable reloadData];
                    CGRect frame = _suggestionsTable.frame;
                    frame.size.height = _suggestionsTable.contentSize.height;
                    _suggestionsTable.frame = frame;
                    [_suggestionsTable setAlpha:1.0];
                });
            } else {
                [_suggestionsTable setAlpha:0.0];
            }
        }
        return true;
    }
//    if ((textField == mTextForSerialNo1) || (textField == mTextForSerialNo2)) {
//        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:EmptyString];
//        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        int length = (int)[currentString length];
//        
//        if (length > 50) {
//            return NO;
//        }
//        return [string isEqualToString:filtered];
//    }
    return YES;
}

- (IBAction)mScan1BtnTapped:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Scan1" forKey:@"Value"];
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:MainKey bundle:nil];
        ScannerViewController *loginViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        [self.navigationController pushViewController:loginViewController animated:YES];
    } else {
        [MailClassViewController toastWithMessage:@"Your device does not have cemera." AndObj:self.view];
    }
}

- (IBAction)mScan2BtnTapped:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Scan2" forKey:@"Value"];
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:MainKey bundle:nil];
        ScannerViewController *loginViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        [self.navigationController pushViewController:loginViewController animated:YES];
    } else {
        [MailClassViewController toastWithMessage:@"Your device does not have cemera." AndObj:self.view];
    }
}

- (IBAction)unregisterTapped:(id)sender {
}

- (void) resetTextField {
    mTextForSerialNo1.text  = EmptyString;
    mTextForSerialNo2.text  = EmptyString;
    mTextForConsumerNo.text = EmptyString;
    [mTermsBtn setSelected:NO];
    [mNoExchngBtn setSelected:NO];
    checkValue              = false;
    checkBoxSelected        = false;
}

#pragma MARK for Corner Radious for Button and UI TextField

-(void) loadCornerRadious {
    
    mView1.layer.borderWidth                    = 1.0;
    mView1.layer.cornerRadius                   = 2.0;
    mView1.layer.borderColor                    = BlueColour.CGColor;
    mView1.layer.masksToBounds                  = YES;
    
    mView2.layer.borderWidth                    = 1.0;
    mView2.layer.cornerRadius                   = 2.0;
    mView2.layer.borderColor                    = BlueColour.CGColor;
    mView2.layer.masksToBounds                  = YES;
    
    mView3.layer.borderWidth                    = 1.0;
    mView3.layer.cornerRadius                   = 2.0;
    mView3.layer.borderColor                    = BlueColour.CGColor;
    mView3.layer.masksToBounds                  = YES;
    
    mViewForInfo.layer.borderWidth              = 2.0;
    mViewForInfo.layer.cornerRadius             = 2.0;
    mViewForInfo.layer.borderColor              = [UIColor lightGrayColor].CGColor;
    mViewForInfo.layer.masksToBounds            = YES;
}

@end
