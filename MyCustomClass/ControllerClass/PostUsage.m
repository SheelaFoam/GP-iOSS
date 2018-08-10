//
//  PostUsage.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 12/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "PostUsage.h"
#import "historyModel.h"
#import "UserDefaultStorage.h"
#import "SVProgressHUD.h"
#import "MailClassViewController.h"
#import "POAcvityView.h"
#import "CityView.h"
#import "GreatPlusSharedHeader.h"
#import "GreatPlusSharedPostRequestManager.h"
#import "JsonBuilder.h"
#import "ScannerViewController.h"

@interface PostUsage() <UIPickerViewDataSource, UIPickerViewDelegate, CityTableDelegate, UITextFieldDelegate, ScanNumberDelegate>{
    
    NSMutableArray *pickerArray;
    NSString *selectedOption;
    
    NSMutableArray *dealerNameList;
    NSMutableArray *dealerIDList;
    NSMutableArray *dealerZone;
    NSMutableArray *dealerCategory;
    NSMutableArray *dealerState;
    NSMutableArray *dealerCity;
    
    NSMutableArray *stateList;
    NSMutableArray *stateZoneList;
    
    NSMutableArray *cityList;
    
    NSMutableArray *complaintType;
    NSMutableArray *complaintCode;
    
    CityView *customPicker;
    POAcvityView *activityIndicator;
    
    NSInteger selectedIndex;
    NSInteger selectedDealerIndex;
    
    NSString *subProduct;
    
    UITapGestureRecognizer *tap;
}

@end

@implementation PostUsage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dealerNameList = [[NSMutableArray alloc] init];
    dealerIDList = [[NSMutableArray alloc] init];
    dealerZone = [[NSMutableArray alloc] init];
    dealerCategory = [[NSMutableArray alloc] init];
    dealerCity = [[NSMutableArray alloc] init];
    
    stateList = [[NSMutableArray alloc] init];
    stateZoneList = [[NSMutableArray alloc] init];
    
    complaintType = [[NSMutableArray alloc] init];
    complaintCode = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initialSetup];
    [SVProgressHUD show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [_snoTextField resignFirstResponder];
        [_bundleNoTextField resignFirstResponder];
        [_invoiceNoTextField resignFirstResponder];
        [_lengthTextField resignFirstResponder];
        [_widthTextField resignFirstResponder];
        [_thickTextField resignFirstResponder];
        [_serialNoTextField resignFirstResponder];
        [_purchasedTextField resignFirstResponder];
        [_pinCodeTextField resignFirstResponder];
        [_existingTextField resignFirstResponder];
        [_purchasedTextField resignFirstResponder];
        [_customerNameTextField resignFirstResponder];
        [_customerMobileTextField resignFirstResponder];
        [_customerAddressTextField resignFirstResponder];
    }
}

//************ TextField Delegate methods ************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _pinCodeTextField) {
        if (_pinCodeTextField.text.length < 6) {
            return true;
        } else {
            return false;
        }
    } else if (textField == _customerMobileTextField) {
        if (_customerMobileTextField.text.length < 10) {
            return true;
        } else {
            return false;
        }
    } else {
        return true;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _purchaseDateTextField) {
        [tap setEnabled:true];
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _purchaseDateTextField) {
        [tap setEnabled:false];
    }
}

//************ Picker Data Source/Delegate methods ************

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerArray.count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *titleLabel = (UILabel *)view;
    
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        [titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    [titleLabel setText:[pickerArray objectAtIndex:row]];
    
    return titleLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerArray.count > 0) {
        selectedIndex = row;
        selectedOption = pickerArray[row];
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

- (IBAction)dealerList:(id)sender {
    
    [self showAlert:dealerNameList withTitle:@"Select Dealer" andStyle:UIAlertControllerStyleAlert withButtonName:_dealerNameButton completionHandler:^(NSString *selection, NSInteger index) {
        
        selectedDealerIndex = index;
        selectedOption = @"";
    }];
}

- (IBAction)productName:(id)sender {
    
    if ([[MailClassViewController sharedInstance].mProductListArray count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:SelectProductListTitle forKey:titleKey];
        [self customPopUP];
    } else {
        [self getProductList];
    }
}

- (IBAction)state:(id)sender {
    [self showAlert:stateList withTitle:@"Select State" andStyle:UIAlertControllerStyleAlert withButtonName:_stateButton completionHandler:^(NSString *selection, NSInteger index) {
        [SVProgressHUD show];
        [self getCityList:selection];
    }];
}

- (IBAction)city:(id)sender {
    if (cityList.count < 1) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:NoRecordAlertFor delegate:nil tag:0];
    } else {
        [self showAlert:cityList withTitle:@"Select City" andStyle:UIAlertControllerStyleAlert withButtonName:_cityButton completionHandler:nil];
    }
}

- (IBAction)complaintType:(id)sender {
    [self showAlert:complaintType withTitle:@"Select Complaint Type" andStyle:UIAlertControllerStyleAlert withButtonName:_complaintTypeButton completionHandler:nil];
}

- (IBAction)search:(id)sender {
    
    if (!(_snoTextField.text.length > 0)) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Serial No. cannot be empty." delegate:nil tag:0];
    } else if (!(_bundleNoTextField.text.length > 0)) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Bundle No. cannot be empty." delegate:nil tag:0];
    } else {
        [self searchProduct:_snoTextField.text witBundleNo:_bundleNoTextField.text];
    }
}

- (IBAction)scan:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Scan1" forKey:@"Value"];
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:MainKey bundle:nil];
        ScannerViewController *loginViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        [self.navigationController pushViewController:loginViewController animated:YES];
        [loginViewController setDelegate:self];
    } else {
        [MailClassViewController toastWithMessage:@"Your device does not have cemera." AndObj:self.view];
    }
}

- (IBAction)submit:(id)sender {
    
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        if ([[self validateSubmitData] isEqualToString:GoodTitle] ) {
            
            [self submitComplaint:[self trimmedString:_cityButton.titleLabel.text] andState:[self trimmedString:_stateButton.titleLabel.text] withPin:_pinCodeTextField.text andDealerName:[self trimmedString:_dealerNameButton.titleLabel.text] withComplaintType:[self trimmedString:_complaintTypeButton.titleLabel.text] andSubProduct:subProduct withSerialNo:_serialNoTextField.text andMRP:_existingTextField.text withPurchaseDate:_purchaseDateTextField.text andProduct:[self trimmedString:_productNameButton.titleLabel.text] withLength:_lengthTextField.text andBreadth:_widthTextField.text withThick:_thickTextField.text andCustomerName:_customerNameTextField.text withCustomerMobile:_customerMobileTextField.text andCustomerAddress:_customerAddressTextField.text withCustomerEmail:_customerEmailTextField.text];
        } else {
            [activityIndicator hideView];
            [MailClassViewController toastWithMessage:[self validateSubmitData] AndObj:self.view];
        }
        
    } else {
        
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:nil tag:NetworkAlertTag];
    }
}

//************ Scanner Delegate Methods ************

- (void)sendScannedNumber:(NSString *)number {
    [self searchProduct:number witBundleNo:@""];
}

//************ Custom Methods ************

- (void) initialSetup {
    
    if ([[historyModel sharedhistoryModel].opUserType isEqualToString:@"DEALER"]) {
        
        [_dealerNameButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_dealerNameButton setTitle:[NSString stringWithFormat:@"  %@", [historyModel sharedhistoryModel].displayname] forState:UIControlStateNormal];
        [dealerNameList addObject:[historyModel sharedhistoryModel].displayname];
        [self getComplaintType:^{
            [self getStateList];
        }];
        
    } else {
        
        [self dealerNameList:[historyModel sharedhistoryModel].uid andDealerID:[UserDefaultStorage getDealerID] completionHandler:^{
            [self getComplaintType:^{
                [self getStateList];
            }];
        }];
    }
    
    [self applyButtonBorder:_dealerNameButton andWidth:1.0];
    [self applyButtonBorder:_productNameButton andWidth:1.0];
    [self applyButtonBorder:_stateButton andWidth:1.0];
    [self applyButtonBorder:_cityButton andWidth:1.0];
    [self applyButtonBorder:_complaintTypeButton andWidth:1.0];
    
    [self applyTextFieldBorder:_snoTextField andWidth:1.0];
    [self applyTextFieldBorder:_bundleNoTextField andWidth:1.0];
    [self applyTextFieldBorder:_invoiceNoTextField andWidth:1.0];
    [self applyTextFieldBorder:_lengthTextField andWidth:1.0];
    [self applyTextFieldBorder:_widthTextField andWidth:1.0];
    [self applyTextFieldBorder:_thickTextField andWidth:1.0];
    [self applyTextFieldBorder:_serialNoTextField andWidth:1.0];
    [self applyTextFieldBorder:_purchaseDateTextField andWidth:1.0];
    [self applyTextFieldBorder:_pinCodeTextField andWidth:1.0];
    [self applyTextFieldBorder:_existingTextField andWidth:1.0];
    [self applyTextFieldBorder:_purchasedTextField andWidth:1.0];
    [self applyTextFieldBorder:_customerNameTextField andWidth:1.0];
    [self applyTextFieldBorder:_customerMobileTextField andWidth:1.0];
    [self applyTextFieldBorder:_customerAddressTextField andWidth:1.0];
    
    UIDatePicker *dobPicker = [[UIDatePicker alloc]init];
    [dobPicker setDate:[NSDate date]];
    dobPicker.datePickerMode = UIDatePickerModeDate;
    [dobPicker addTarget:self action:@selector(purchaseDateTextField:) forControlEvents:UIControlEventValueChanged];
    [_purchaseDateTextField setInputView:dobPicker];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setEnabled:false];
}

-(void)dismissKeyboard {
    [_purchaseDateTextField resignFirstResponder];
}

-(NSString *)trimmedString: (NSString *)string {
    
    return [string stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(void) applyButtonBorder: (UIButton *)button andWidth: (int) width {
    
    [[button layer] setBorderColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor];
    [[button layer] setBorderWidth:width];
    [[button layer] setCornerRadius:5.0];
}

-(void) applyTextFieldBorder: (UITextField *)textfield andWidth: (int) width {
    
    [[textfield layer] setBorderColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor];
    [[textfield layer] setBorderWidth:width];
    [[textfield layer] setCornerRadius:5.0];
}

-(void) showAlert: (NSArray *)dataSourceArray withTitle: (NSString *)title andStyle: (UIAlertControllerStyle)style withButtonName: (UIButton *)button completionHandler: (nullable void (^)(NSString *selection, NSInteger index)) completion {
    
    selectedOption = @"";
    pickerArray = [[NSMutableArray alloc] init];
    pickerArray = [NSMutableArray arrayWithArray:dataSourceArray];
    
    UIAlertController *alert = [[UIAlertController alloc] init];
    alert = [UIAlertController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n" preferredStyle:style];
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(alert.view.bounds.size.width*0.025, alert.view.bounds.size.height*0.075, 250, 140)];
    
    [alert.view addSubview:picker];
    [picker setDataSource:self];
    [picker setDelegate:self];
    
    UIAlertAction *okay = [[UIAlertAction alloc] init];
    okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([selectedOption isEqualToString:@""]) {
            if (pickerArray.count > 0) {
                selectedOption = pickerArray[0];
            }
        }
        if (![selectedOption isEqualToString:@""]) {
            [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"  %@", selectedOption] forState:UIControlStateNormal];
        }
        if (completion) {
            completion(selectedOption, selectedIndex);
        }
    }];
    UIAlertAction *cancel = [[UIAlertAction alloc] init];
    cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okay];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:true completion:nil];
}

-(void) purchaseDateTextField:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)_purchaseDateTextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _purchaseDateTextField.text = [NSString stringWithFormat:@"  %@",dateString];
}

- (void)onCityDone:(id)sender selectedClentFocus:(NSArray *)str {
    [_productNameButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_productNameButton setTitle:[NSString stringWithFormat:@"  %@", [[str objectAtIndex:0] valueForKey:@"product_display_name"]] forState:UIControlStateNormal];
    subProduct = [[str objectAtIndex:0] valueForKey:@"sub_product"];
    [customPicker removeFromSuperview];
    customPicker = nil;
}

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

- (void) removePicker {
    [self onCityTableCancel:nil];
}

- (void)onCityTableCancel:(id)sender {
    [customPicker removeFromSuperview];
    customPicker = nil;
}

-(NSString *) validateSubmitData {
    
    NSString *errorMessage = GoodTitle;
    if ([_dealerNameButton.titleLabel.text isEqualToString:@"  Dealer List"]) {
        errorMessage = @"Dealer Name cannot be empty.";
    } else if ([_productNameButton.titleLabel.text isEqualToString:@"  Product"]) {
        errorMessage = @"Product cannot be empty.";
    } else if (!(_lengthTextField.text.length >= 1)) {
        errorMessage = EmptyLTxtFldMsg;
    } else if (!(_widthTextField.text.length >= 1)) {
        errorMessage = EmptyWTxtFldMsg;
    } else if (!(_thickTextField.text.length >= 1)) {
        errorMessage = EmptyQuantityTxtFldMsg;
    } else if (!(_purchasedTextField.text.length >= 1)) {
        errorMessage = @"Purchase Date cannot be empty";
    } else if ([_stateButton.titleLabel.text isEqualToString:@"  State"]) {
        errorMessage = @"State cannot be empty.";
    } else if ([_cityButton.titleLabel.text isEqualToString:@"  City"]) {
        errorMessage = @"City cannot be empty.";
    } else if (!(_existingTextField.text.length >= 1)) {
        errorMessage = @"Existing field cannot be empty.";
    } else if (_purchasedTextField.text.length >= 1) {
        errorMessage = @"Purchased field cannot be empty.";
    } else if ([_complaintTypeButton.titleLabel.text isEqualToString:@"  Complaint Type"]) {
        errorMessage = @"Complaint Type cannot be empty.";
    } else if (!(_customerNameTextField.text.length >= 1)) {
        errorMessage = @"Customer Name cannot be empty.";
    } else if (!(_customerMobileTextField.text.length >= 1)) {
        errorMessage = @"Customer Mobile cannot be empty.";
    } else if (!(_customerEmailTextField.text.length >= 1)) {
        errorMessage = @"Customer email cannot be empty.";
    } else if (!(_customerAddressTextField.text.length >= 1)) {
        errorMessage = @"Customer Address cannot be empty.";
    }
    
    return errorMessage;
}

//************ API Methods ************

-(void) dealerNameList: (NSString *)uid andDealerID: (NSString *)dealerID completionHandler: (void (^)(void)) completion {
    
    NSDictionary *headers = @{ @"content-type": @"application/json"};
    NSDictionary *parameters = @{ @"method": @"complaint_dealers",
                                  @"user_id": uid,
                                  @"dealer_id": dealerID};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://greatplus.com/service/complaint"]
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
                                                        
                                                        
                                                        for (int i =0 ; i < [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"] count]; i++) {
                                                            if (![dealerNameList containsObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"DEALER_NAME"]]) {
                                                                
                                                                [dealerNameList addObject:[NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"DEALER_NAME"]]];
                                                                [dealerIDList addObject:[NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"DEALER_ID"]]];
                                                                [dealerZone addObject:[NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"DEALER_ZONE"]]];
                                                                [dealerCategory addObject:[NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"DEALER_CATEGORY"]]];
                                                            }
                                                        }
                                                        completion();
                                                    }
                                                }];
    [dataTask resume];
}

-(void) getStateList {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://125.19.46.252/ws/get_all_state.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"state"]);
                                                        for (int i = 0; i < [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"state"] count]; i++) {
                                                            
                                                            if (![stateList containsObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"state"][i][@"STATE"]]) {
                                                                [stateList addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"state"][i][@"STATE"]];
                                                                [stateZoneList addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"state"][i][@"ZONE"]];
                                                            }
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [SVProgressHUD dismiss];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

-(void) getCityList: (NSString *)state {
    
    cityList = [[NSMutableArray alloc] init];
    NSDictionary *headers = @{ @"content-type": @"application/json"};
    NSDictionary *parameters = @{ @"method": @"citylist",
                                  @"state": state};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.greatplus.com/service/complaint"]
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
                                                        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                                                        
                                                        for (int i = 0; i < [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"] count]; i++) {
                                                            
                                                            if (![cityList containsObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]]){
                                                                [cityList addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"CITY"]];
                                                            }
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [SVProgressHUD dismiss];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

-(void) getComplaintType: (void (^)(void)) completion {
    
    NSDictionary *headers = @{@"content-type": @"application/json"};
    NSDictionary *parameters = @{ @"method": @"complaint_type" };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.greatplus.com/service/complaint"]
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
                                                        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                                                        
                                                        for (int i = 0; i < [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"] count]; i++) {
                                                            
                                                            if (![complaintType containsObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"COMPLAIN_TYPE_NAME"]]) {
                                                                [complaintType addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"COMPLAIN_TYPE_NAME"]];
                                                                [complaintCode addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"COMPLAIN_TYPE_CODE"]];
                                                            }
                                                        }
                                                        completion();
                                                    }
                                                }];
    [dataTask resume];
}

- (void) getProductList {
    activityIndicator = [[POAcvityView alloc] initWithTitle:EmptyString message:LoadingTitle];
    [activityIndicator showView];
    if ([MailClassViewController isNetworkConnected]) {
        if ([_dealerNameButton.titleLabel.text isEqualToString:@"  Dealer List"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:GreatPlusTitle message:@"Please select a dealer." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okay];
            [self presentViewController:alert animated:true completion:^{
                [activityIndicator hideView];
            }];
        } else {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"getProduct",@"request", _dealerNameButton.titleLabel.text, @"p_dealer_name", dealerZone[selectedDealerIndex], @"p_zone", dealerZone[selectedDealerIndex], @"p_dealer_category",  nil];
            [[GreatPlusSharedPostRequestManager sharedInstance] executePostRequest:CMD_PRODUCT_LIST_INIT withDictionaryInfo:params andTagName:ProductServiceTag andCompletionHandler:^(id result, int statusCode, NSString *message) {
                [activityIndicator hideView];
                if (statusCode == StatusCode) {
                    [[NSUserDefaults standardUserDefaults] setObject:SelectProductListTitle forKey:titleKey];
                    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                    for (NSMutableDictionary *ldic in result[productKey]) {
                        NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:ldic];
                        [d setObject:NOTitle forKey:SELECTEDKey];
                        [tempArray addObject:d];
                    }
                    if ([tempArray count] == 0) {
                        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:NoRecordAlertFor delegate:nil tag:0];
                    } else {
                        [MailClassViewController sharedInstance].mProductListArray = tempArray;
                        [self customPopUP];
                    }
                } else {
                    [MailClassViewController toastWithMessage:message AndObj:self.view];
                }
            }];
        }
    } else {
        [activityIndicator hideView];
        [MailClassViewController showAlertViewWithTitle:ConnectionTitle message:OhnoAlert delegate:nil tag:NetworkAlertTag];
    }
}

-(void) searchProduct: (NSString *)serialNo witBundleNo: (NSString *)bundleNo {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:@"filter_products" forKey:@"method"];
    [params setValue:serialNo forKey:@"serial_no"];
    [params setValue:bundleNo forKey:@"bundle_no"];
    
    NSDictionary *headers = @{@"content-type": @"application/json"};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.greatplus.com/service/complaint"]
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
                                                        
                                                        [_productNameButton setTitle:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_product_specification"] forState:UIControlStateNormal];
                                                        [_lengthTextField setText:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_length"]];
                                                        [_widthTextField setText:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_width"]];
                                                        [_thickTextField setText:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_thick"]];
                                                        [_serialNoTextField setText:serialNo];
                                                        [_purchaseDateTextField setText:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_zd_invoice_date"]];
                                                        if (![[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_existing_mrp"] isKindOfClass:[NSNull class]]) {
                                                            [_existingTextField setText:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_existing_mrp"]];
                                                        }
                                                        if (![[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_dealer_name"] isKindOfClass:[NSNull class]]) {
                                                            [_dealerNameButton setTitle:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_dealer_name"] forState:UIControlStateNormal];
                                                        }
                                                        if (![[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_customer_name"] isKindOfClass:[NSNull class]]) {
                                                            [_customerNameTextField setText:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_customer_name"]];
                                                        }
                                                        if (![[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_customer_mobile"] isKindOfClass:[NSNull class]]) {
                                                            [_customerMobileTextField setText:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_customer_mobile"]];
                                                        }
                                                        subProduct = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][@"op_sub_product"];
                                                        
                                                    }
                                                }];
    [dataTask resume];
}

-(void) submitComplaint: (NSString *)city andState: (NSString *)state withPin: (NSString *)pin andDealerName: (NSString *)dealerName withComplaintType: (NSString *)complaintType andSubProduct: (NSString *)subProduct withSerialNo: (NSString *)serialNo andMRP: (NSString *)mrp withPurchaseDate: (NSString *)purchaseDate andProduct: (NSString *)product withLength: (NSString *)length andBreadth: (NSString *)breadth withThick: (NSString *)thick andCustomerName: (NSString *)customerName withCustomerMobile: (NSString *)customerMobile andCustomerAddress: (NSString *)customerAddress withCustomerEmail: (NSString *)customerEmail {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:@"post usage" forKey:@"pre_post_usage"];
    [params setValue:city forKey:@"city"];
    [params setValue:state forKey:@"state"];
    [params setValue:pin forKey:@"pincode"];
    [params setValue:@"save_new" forKey:@"method"];
    [params setValue:[historyModel sharedhistoryModel].uid forKey:@"user_id"];
    [params setValue:customerName forKey:@"customer_name"];
    [params setValue:customerMobile forKey:@"customer_mobile"];
    [params setValue:customerEmail forKey:@"customer_email"];
    [params setValue:customerAddress forKey:@"customer_address"];
    [params setValue:dealerName forKey:@"dealer_name"];
    [params setValue:@"" forKey:@"dealer_address"];
    [params setValue:complaintType forKey:@"comp_type_name"];
    [params setValue:subProduct forKey:@"sub_product"];
    [params setValue:serialNo forKey:@"serial"];
    [params setValue:mrp forKey:@"mrp"];
    [params setValue:purchaseDate forKey:@"purchase_date"];
    [params setValue:product forKey:@"product"];
    [params setValue:length forKey:@"length"];
    [params setValue:breadth forKey:@"bredth"];
    [params setValue:thick forKey:@"thick"];
    
    NSLog(@"%@", params);
    
    NSDictionary *headers = @{@"content-type": @"application/json"};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.greatplus.com/service/complaint"]
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
                                                        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                                                        
                                                        if ([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"status"] isEqualToString:@"200"]) {
                                                            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"complaint_no"] delegate:nil tag:0];
                                                        } else {
                                                            
                                                            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Complaint not submitted, please try again." delegate:nil tag:0];
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

//************ Back Action ************

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


@end
