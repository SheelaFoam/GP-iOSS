//
//  Pager.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "Passbook.h"

@interface Passbook()<CAPSPageMenuDelegate> {
    
    NSArray *controllerArray;
    NSMutableArray *headerColorArray;
    NSArray *footerColorArray;
    
    NSString *fromDate;
    NSString *toDate;
    NSString *previousDate;
    
    UIImageView *fromCalendarImgView;
    UIImageView *toCalendarImgView;
}

@end

@implementation Passbook

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [_fromDateTextField resignFirstResponder];
        [_toDateTextField resignFirstResponder];
    }
}

// *************** CAPSPageMenu Delegate Methods ***************

- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    
    if (controller.view.tag == 0) {
        [_titleView setBackgroundColor:[UIColor colorWithRed:146.0/255.0 green:74.0/255.0 blue:150.0/255.0 alpha:1.0]];
        [_fromDateLbl setBackgroundColor:[UIColor colorWithRed:146.0/255.0 green:74.0/255.0 blue:150.0/255.0 alpha:1.0]];
        [_toDateLbl setBackgroundColor:[UIColor colorWithRed:146.0/255.0 green:74.0/255.0 blue:150.0/255.0 alpha:1.0]];
    } else if (controller.view.tag == 1) {
        [_titleView setBackgroundColor:[UIColor colorWithRed:22.0/255.0 green:115.0/255.0 blue:185.0/255.0 alpha:1.0]];
        [_fromDateLbl setBackgroundColor:[UIColor colorWithRed:22.0/255.0 green:115.0/255.0 blue:185.0/255.0 alpha:1.0]];
        [_toDateLbl setBackgroundColor:[UIColor colorWithRed:22.0/255.0 green:115.0/255.0 blue:185.0/255.0 alpha:1.0]];
    } else if (controller.view.tag == 2) {
        [_titleView setBackgroundColor:[UIColor colorWithRed:228.0/255.0 green:45.0/255.0 blue:37.0/255.0 alpha:1.0]];
        [_fromDateLbl setBackgroundColor:[UIColor colorWithRed:228.0/255.0 green:45.0/255.0 blue:37.0/255.0 alpha:1.0]];
        [_toDateLbl setBackgroundColor:[UIColor colorWithRed:228.0/255.0 green:45.0/255.0 blue:37.0/255.0 alpha:1.0]];
    } else if (controller.view.tag == 3) {
        [_titleView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:127.0/255.0 blue:27.0/255.0 alpha:1.0]];
        [_fromDateLbl setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:127.0/255.0 blue:27.0/255.0 alpha:1.0]];
        [_toDateLbl setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:127.0/255.0 blue:27.0/255.0 alpha:1.0]];
    }
}

// *************** Custom Methods ***************

-(void) initialSetup {
    
    _datesView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    _shadowLbl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [_datesView layer].cornerRadius = 10.0;
    self.shadowLbl.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowLbl.layer.shadowRadius = 5.0;
    self.shadowLbl.layer.shadowOpacity = 1.0;
    self.shadowLbl.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.shadowLbl.layer.masksToBounds = false;
    
    fromCalendarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_fromDateTextField.bounds.origin.x, _fromDateTextField.bounds.origin.y, _fromDateTextField.bounds.size.height*0.65, _fromDateTextField.bounds.size.height*0.65)];
    [fromCalendarImgView setImage:[UIImage imageNamed:@"calendar"]];
    [fromCalendarImgView setContentMode:UIViewContentModeCenter];
    [_fromDateTextField setRightView:fromCalendarImgView];
    [_fromDateTextField setRightViewMode:UITextFieldViewModeAlways];
    
    toCalendarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_fromDateTextField.bounds.origin.x, _fromDateTextField.bounds.origin.y, _fromDateTextField.bounds.size.height*0.65, _fromDateTextField.bounds.size.height*0.65)];
    [toCalendarImgView setImage:[UIImage imageNamed:@"calendar"]];
    [toCalendarImgView setContentMode:UIViewContentModeCenter];
    [_toDateTextField setRightView:toCalendarImgView];
    [_toDateTextField setRightViewMode:UITextFieldViewModeAlways];
    
    UIDatePicker *datePicker1 = [[UIDatePicker alloc]init];
    [datePicker1 setDate:[NSDate date]];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    
    [datePicker1 addTarget:self action:@selector(fromDate:) forControlEvents:UIControlEventValueChanged];
    [_fromDateTextField setInputView:datePicker1];
    
    UIDatePicker *datePicker2 = [[UIDatePicker alloc]init];
    [datePicker2 setDate:[NSDate date]];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    
    [datePicker2 addTarget:self action:@selector(toDate:) forControlEvents:UIControlEventValueChanged];
    [_toDateTextField setInputView:datePicker2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInputView)];
    [self.view addGestureRecognizer:tap];
    
    NSDate *now = [NSDate date];
    NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:-7*24*60*60];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    previousDate = [dateFormatter stringFromDate:sevenDaysAgo];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy";
    NSString *string = [formatter stringFromDate:[NSDate date]];
    toDate = string;
    
    [self getPassbookData:[historyModel sharedhistoryModel].uid withDealerID:[UserDefaultStorage getDealerID] andFromDate:previousDate withToDate:toDate];
}

-(void) setupSegmentedControl {
    
    controllerArray = [[NSArray alloc] init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DealerStoryboard" bundle:nil];
    
    UIViewController *eocb = [storyboard instantiateViewControllerWithIdentifier:@"EOCB"];
    eocb.view.tag = 0;
    eocb.title = @"EOCB";
    
    UIViewController *cashAmt = [storyboard instantiateViewControllerWithIdentifier:@"CashAmount"];
    cashAmt.view.tag = 1;
    cashAmt.title = @"Cash Amount";
    
    UIViewController *parivartan = [storyboard instantiateViewControllerWithIdentifier:@"ParivartanStar"];
    parivartan.view.tag = 2;
    parivartan.title = @"Parivartan Star";
    
    UIViewController *prize = [storyboard instantiateViewControllerWithIdentifier:@"Prize"];
    prize.view.tag = 3;
    prize.title = @"Prize";
    
    controllerArray = @[eocb, cashAmt, parivartan, prize];
    
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: UIColor.clearColor,
                                 CAPSPageMenuOptionViewBackgroundColor: UIColor.clearColor,
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor: UIColor.whiteColor,
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: UIColor.whiteColor,
                                 CAPSPageMenuOptionSelectionIndicatorColor: UIColor.whiteColor,
                                 CAPSPageMenuOptionBottomMenuHairlineColor: UIColor.clearColor,
                                 CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold],
                                 CAPSPageMenuOptionMenuHeight: @(50.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(90.0),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES)
                                 };
    _pagemenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(self.view.bounds.size.width*0.025, 100.0, self.view.bounds.size.width*0.95, self.view.bounds.size.height - 150) options:parameters];
    [self.view addSubview:_pagemenu.view];
    _pagemenu.delegate = self;
}

-(void) getPassbookData: (NSString *)uid withDealerID:(NSString *)dealerID andFromDate: (NSString *)fromDate withToDate: (NSString *)toDate {
    
    [self getPassbookData:uid withDealerID:dealerID andFromDate:fromDate withToDate:toDate andSchemeType:@"EOCB" withReportType:@"DETAIL" completionHandler:^{
        [self getPassbookData:uid withDealerID:dealerID andFromDate:fromDate withToDate:toDate andSchemeType:@"CASH AMOUNT" withReportType:@"DETAIL" completionHandler:^{
            [self getPassbookData:uid withDealerID:dealerID andFromDate:fromDate withToDate:toDate andSchemeType:@"PARIVATAN STAR" withReportType:@"DETAIL" completionHandler:^{
                [self getPassbookData:uid withDealerID:dealerID andFromDate:fromDate withToDate:toDate andSchemeType:@"PRIZE" withReportType:@"DETAIL" completionHandler:^{
                    [self getPassbookData:uid withDealerID:dealerID andFromDate:fromDate withToDate:toDate andSchemeType:@"EOCB" withReportType:@"SUMMARY" completionHandler:^{
                        [self getPassbookData:uid withDealerID:dealerID andFromDate:fromDate withToDate:toDate andSchemeType:@"CASH AMOUNT" withReportType:@"SUMMARY" completionHandler:^{
                            [self getPassbookData:uid withDealerID:dealerID andFromDate:fromDate withToDate:toDate andSchemeType:@"PARIVATAN STAR" withReportType:@"SUMMARY" completionHandler:^{
                                [self getPassbookData:uid withDealerID:dealerID andFromDate:fromDate withToDate:toDate andSchemeType:@"PRIZE" withReportType:@"SUMMARY" completionHandler:^{
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [SVProgressHUD dismiss];
                                        [self setupSegmentedControl];
                                    });
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];
}

- (IBAction)fromDate:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)_fromDateTextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    fromDate = [NSString stringWithFormat:@"%@",dateString];
    _fromDateTextField.text = [NSString stringWithFormat:@"%@",dateString];
    _fromDateLbl.text = [NSString stringWithFormat:@"%@",dateString];
}

- (IBAction)toDate:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)_toDateTextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    toDate = [NSString stringWithFormat:@"%@",dateString];
    _toDateTextField.text = [NSString stringWithFormat:@"%@",dateString];
    _toDateLbl.text = [NSString stringWithFormat:@"%@",dateString];
}

- (IBAction)submit:(id)sender {
    
    [self closePopupPunchInView:_datesView shadowLabel:_shadowLbl];
    
    if ([MailClassViewController isNetworkConnected]) {
        if ([_fromDateLbl.text isEqualToString:@"From"]) {
            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please select From Date." delegate:nil tag:0];
        } else if ([_toDateLbl.text isEqualToString:@"To"]) {
            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please select To Date." delegate:nil tag:0];
        } else {
            [SVProgressHUD show];
            [PassbookModel sharedInstance].detail = [[NSMutableDictionary alloc] init];
            [PassbookModel sharedInstance].summary = [[NSMutableDictionary alloc] init];
            
            [self getPassbookData:[historyModel sharedhistoryModel].uid withDealerID:[UserDefaultStorage getDealerID] andFromDate:fromDate withToDate:toDate];
        }
    } else {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please select To Date." delegate:nil tag:0];
    }
}

- (IBAction)filter:(id)sender {
    
    [self openPopupPunchInView:_datesView shadowLabel:_shadowLbl];
}

-(void) dismissInputView {
    [self.view endEditing:true];
}

// ************** Custom Methods **************

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

// ************** API Methods **************

-(void) getPassbookData: (NSString *)uid withDealerID: (NSString *)dealerID andFromDate:(NSString *)fromDate withToDate:(NSString *)toDate andSchemeType:(NSString *)schemeType withReportType:(NSString *)reportType completionHandler: (void (^)(void))completionHandler {
    
    NSDictionary *headers = @{ @"content-type": @"application/json"};
    NSDictionary *parameters = @{ @"p_user_id": uid,
                                  @"p_dealer_id": dealerID,
                                  @"p_from": fromDate,
                                  @"p_to": toDate,
                                  @"p_scheme_type": schemeType,
                                  @"p_report_type": reportType};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://greatplus.com/api_services/passbook_api.php"]
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
                                                        if ([reportType isEqualToString:@"DETAIL"]) {
                                                            if ([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"DETAIL"] count] > 0) {
                                                                [[PassbookModel sharedInstance].detail setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"DETAIL"] forKey:schemeType];
                                                            } else {
                                                                [[PassbookModel sharedInstance].detail setValue:@{} forKey:schemeType];
                                                            }
                                                        } else {
                                                            if ([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"SUMMARY"] count] > 0) {
                                                                [[PassbookModel sharedInstance].summary setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"SUMMARY"][0] forKey:schemeType];
                                                            } else {
                                                                [[PassbookModel sharedInstance].summary setValue:@{} forKey:schemeType];
                                                            }
                                                        }
                                                        completionHandler();
                                                    }
                                                }];
    [dataTask resume];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
