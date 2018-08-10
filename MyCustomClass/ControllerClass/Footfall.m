//
//  Footfall.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 10/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "Footfall.h"
#import "historyModel.h"
#import "UserDefaultStorage.h"
#import "SVProgressHUD.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedHeader.h"

@interface Footfall() <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
    
    NSMutableArray *pickerArray;
    NSMutableArray *storeListArray;
    NSMutableArray *channelPartnerGroupArray;
    
    NSString *selectedOption;
    NSString *selectedStore;
    NSString *selectedHearOpt;
    NSInteger selectedIndex;
    NSString *selectedChannelPartnerGrp;
}

@end

@implementation Footfall

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [_dateTextfield resignFirstResponder];
        [_walkinTextfield resignFirstResponder];
        [_conversionTextfield resignFirstResponder];
    }
}

- (IBAction)selectStore:(id)sender {
    
    [self showAlert:storeListArray withTitle:@"Select Store" andStyle:UIAlertControllerStyleAlert withButtonName:_storeButton completionHandler:^(NSString *selection, NSInteger index) {
        selectedStore = selection;
        selectedChannelPartnerGrp = channelPartnerGroupArray[index];
    }];
}

- (IBAction)heardAboutSleepwell:(id)sender {
    
    
    [self showAlert:@[@"TV", @"Newspaper", @"Radio", @"Internet", @"Others"] withTitle:@"Where did you hear about Sleepwell ?" andStyle:UIAlertControllerStyleAlert withButtonName:_hearButton completionHandler:^(NSString *selection, NSInteger index) {
        selectedHearOpt = selection;
    }];
}

- (IBAction)submit:(id)sender {
    
    if ([selectedStore isEqualToString:@""]) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please select store." delegate:nil tag:0];
    } else if ([_walkinTextfield.text isEqualToString:@""]) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please enter number of walkins." delegate:nil tag:0];
    } else if ([_conversionTextfield.text isEqualToString:@""]) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please enter number of conversions." delegate:nil tag:0];
    } else if ([selectedHearOpt isEqualToString:@""] || [selectedHearOpt isKindOfClass:[NSNull class]]) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please select where you heard about Sleepwell." delegate:nil tag:0];
    } else if ([_dateTextfield.text isEqualToString:@""]) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please select date." delegate:nil tag:0];
    } else {
        [SVProgressHUD show];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        
        [parameters setValue:_dateTextfield.text forKey:@"date"];
        [parameters setValue:_conversionTextfield.text forKey:@"numberOfConversation"];
        [parameters setValue:_walkinTextfield.text forKey:@"numberOfWalkin"];
        [parameters setValue:selectedStore forKey:@"storeId"];
        [parameters setValue:selectedHearOpt forKey:@"heardAbout"];
        [parameters setValue:selectedChannelPartnerGrp forKey:@"channelPartnerGroup"];
        [parameters setValue:@"" forKey:@"cityId"];
        
        [self submit:[historyModel sharedhistoryModel].uid withToken:[historyModel sharedhistoryModel].token andParameters:parameters completionHandler:^(BOOL success, NSString *message) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:message delegate:nil tag:0];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:message delegate:nil tag:0];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
    }
}

//************ Picker Data Source/Delegate methods ************

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedOption = pickerArray[row];
    selectedIndex = row;
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

//************ TextField Delegate methods ************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
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
    
    [SVProgressHUD show];
    storeListArray = [[NSMutableArray alloc] init];
    pickerArray = [[NSMutableArray alloc] init];
    channelPartnerGroupArray = [[NSMutableArray alloc] init];
    selectedOption = [[NSString alloc] init];
    
    [self applyButtonBorder:_storeButton andWidth:1.0];
    [self applyButtonBorder:_hearButton andWidth:1.0];
    
    [self applyTextFieldBorder:_walkinTextfield andWidth:1.0];
    [self applyTextFieldBorder:_conversionTextfield andWidth:1.0];
    [self applyTextFieldBorder:_dateTextfield andWidth:1.0];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_dateTextfield setInputView:datePicker];
    [self getStoreID:[historyModel sharedhistoryModel].uid withToken:[historyModel sharedhistoryModel].token completionHandler:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
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
    
    selectedOption = [[NSString alloc] init];
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

-(void) dateTextField:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)_dateTextfield.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _dateTextfield.text = [NSString stringWithFormat:@"  %@",dateString];
}

//************ API Action ************

-(void) getStoreID: (NSString *)uid withToken: (NSString *)token completionHandler: (void (^)(void))completionHandler {
    
    NSDictionary *headers = @{ @"cache-control": @"no-cache",
                               @"postman-token": @"4698163e-d6e8-1e67-f2fc-a2fbd78a0ca8" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://be.greatplus.com/sheelafoam/rest/employees/details/%@/%@", uid, token]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        for (int i = 0; i < [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][0][@"storeList"] count]; i++) {
                                                            [storeListArray addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][0][@"storeList"][i][@"pARENT_CHANNEL_PARTNER_NAME"]];
                                                            [channelPartnerGroupArray addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][0][@"storeList"][i][@"cHANNEL_PARTNER_GROUP"]];
                                                        }
                                                        completionHandler();
                                                    }
                                                }];
    [dataTask resume];
}

-(void) submit: (NSString *)uid withToken: (NSString *)token andParameters: (NSDictionary *)params completionHandler: (nullable void (^)(BOOL success, NSString *message))completionHandler {
    
    NSDictionary *headers = @{ @"content-type": @"application/json"};
    NSDictionary *parameters = params;
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSLog(@"%@", parameters);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://be.greatplus.com/sheelafoam/rest/services/saveAdvertisementFeedback/%@/%@", uid, token]]
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
                                                    }
                                                    NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                                                    if ([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"success"] == true) {
                                                        
                                                        completionHandler(true, [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"message"]);
                                                    } else {
                                                        completionHandler(false, @"Could not submit date. Please try again.");
                                                    }
                                                }];
    [dataTask resume];
}

//************ Back Action ************

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
