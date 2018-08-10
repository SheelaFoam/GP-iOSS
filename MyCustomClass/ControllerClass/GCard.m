//
//  GCard.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 07/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "GCard.h"

@interface GCard() <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
    NSMutableArray *gCardArray;
    NSMutableArray *salesRepArray;
    NSMutableArray *suggestionsArray;
}

@end

@implementation GCard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_searchTableView setAlpha:0.0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

// *************** Textfield Delegate Methods ***************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if (textField == _salesRepTextfield) {
//        if ([_fromDateTextfield.text isEqualToString:@""]) {
//            [MailClassViewController toastWithMessage:@"From date cannot be empty" AndObj:self.view];
//        } else if ([_toDateTextfield.text isEqualToString:@""]) {
//            [MailClassViewController toastWithMessage:@"From date cannot be empty" AndObj:self.view];
//        } else {
//            if (salesRepArray.count > 0) {
//
//            } else {
//                
//            }
//            [self getGCardData:_fromDateTextfield.text andToDate:_toDateTextfield.text withSalesRepName:_salesRepTextfield.text completionHandler:^{
//                [salesRepArray removeAllObjects];
//                for (int i = 0; i < gCardArray.count; i++) {
//                    if (![gCardArray[i][@"salesRepName"] isKindOfClass:[NSNull class]]) {
//                        [salesRepArray addObject:gCardArray[i][@"salesRepName"]];
//                    }
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
//                    [datePicker setDate:[NSDate date]];
//                    datePicker.datePickerMode = UIDatePickerModeDate;
//                    [_gCardTable reloadData];
//                    [SVProgressHUD dismiss];
//                });
//            }];
//        }
//    }
    [textField resignFirstResponder];
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == _salesRepTextfield) {
        for (NSString *str in salesRepArray) {
            if([[str lowercaseString] hasPrefix:[searchText lowercaseString]]) {
                [suggestionsArray removeAllObjects];
                if (![suggestionsArray containsObject:str]) {
                    [suggestionsArray addObject:str];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_searchTableView reloadData];
                    if (_searchTableView.contentSize.height > 100) {
                        [_searchTableHeight setConstant:100];
                    } else {
                        [_searchTableHeight setConstant:_searchTableView.contentSize.height];
                    }
                    [_searchTableView setAlpha:1.0];
                });
            } else {
                [_searchTableView setAlpha:0.0];
            }
        }
    }
    return true;
}

// *************** TableView Datasource/Delegate Methods ***************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _gCardTable) {
        return gCardArray.count;
    } else {
        return suggestionsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == _gCardTable) {
        NSString *identifier = @"GCardCell";
        
        GCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[GCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [cell.salesRepLbl setText:_salesRepTextfield.text];
        [cell.specsLbl setText:gCardArray[indexPath.row][@"productSpecs"]];
        [cell.lengthLbl setText:gCardArray[indexPath.row][@"length"]];
        [cell.breadthLbl setText:gCardArray[indexPath.row][@"breadth"]];
        if ([gCardArray[indexPath.row][@"thickness"] isKindOfClass:[NSNull class]]) {
            [cell.thicknessLbl setText:@""];
        } else {
            [cell.thicknessLbl setText:gCardArray[indexPath.row][@"thickness"]];
        }
        [cell.countLbl setText:gCardArray[indexPath.row][@"count"]];
        
        return cell;
    } else {
        
        NSString *identifier = @"SearchCell";
        
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [cell.searchLbl setText:suggestionsArray[indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _searchTableView) {
        [_salesRepTextfield setText:suggestionsArray[indexPath.row]];
        [_searchTableView setAlpha:0.0];
    }
}

// *************** Custom Methods ***************

- (IBAction)fromDate:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)_fromDateTextfield.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _fromDateTextfield.text = [NSString stringWithFormat:@"%@",dateString];
}

- (IBAction)toDate:(id)sender {
    
    UIDatePicker *picker = (UIDatePicker*)_toDateTextfield.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _toDateTextfield.text = [NSString stringWithFormat:@"%@",dateString];
}

- (IBAction)go:(id)sender {
    [SVProgressHUD show];
    if ([_fromDateTextfield.text isEqualToString:@""]) {
        [MailClassViewController toastWithMessage:@"From date cannot be empty" AndObj:self.view];
    } else if ([_toDateTextfield.text isEqualToString:@""]) {
        [MailClassViewController toastWithMessage:@"From date cannot be empty" AndObj:self.view];
    } else {
        [SVProgressHUD show];
        [self getGCardData:_fromDateTextfield.text andToDate:_toDateTextfield.text withSalesRepName:_salesRepTextfield.text completionHandler:^{
            [salesRepArray removeAllObjects];
            for (int i = 0; i < gCardArray.count; i++) {
                if (![gCardArray[i][@"salesRepName"] isKindOfClass:[NSNull class]]) {
                    [salesRepArray addObject:gCardArray[i][@"salesRepName"]];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                UIDatePicker *datePicker = [[UIDatePicker alloc]init];
                [datePicker setDate:[NSDate date]];
                datePicker.datePickerMode = UIDatePickerModeDate;
                [_gCardTable reloadData];
                [SVProgressHUD dismiss];
            });
        }];
    }
}

-(void) initialSetup {
    
    [_gCardTable setRowHeight:UITableViewAutomaticDimension];
    [_gCardTable setEstimatedRowHeight:60];
    
    [_searchTableView.layer setBorderColor:UIColor.grayColor.CGColor];
    [_searchTableView.layer setBorderWidth:1.0];
    gCardArray = [[NSMutableArray alloc] init];
    salesRepArray = [[NSMutableArray alloc] init];
    suggestionsArray = [[NSMutableArray alloc] init];
//    [self getGCardData:@"01-04-2018" andToDate:@"05-07-2018" withSalesRepName:@"" completionHandler:^{
//        [salesRepArray removeAllObjects];
//        for (int i = 0; i < gCardArray.count; i++) {
//            if (![gCardArray[i][@"salesRepName"] isKindOfClass:[NSNull class]]) {
//                [salesRepArray addObject:gCardArray[i][@"salesRepName"]];
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIDatePicker *datePicker = [[UIDatePicker alloc]init];
//            [datePicker setDate:[NSDate date]];
//            datePicker.datePickerMode = UIDatePickerModeDate;
//            [SVProgressHUD dismiss];
//        });
//    }];
    
    UIDatePicker *datePicker1 = [[UIDatePicker alloc]init];
    [datePicker1 setDate:[NSDate date]];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    
    [datePicker1 addTarget:self action:@selector(fromDate:) forControlEvents:UIControlEventValueChanged];
    [_fromDateTextfield setInputView:datePicker1];
    
    UIDatePicker *datePicker2 = [[UIDatePicker alloc]init];
    [datePicker2 setDate:[NSDate date]];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    
    [datePicker2 addTarget:self action:@selector(toDate:) forControlEvents:UIControlEventValueChanged];
    [_toDateTextfield setInputView:datePicker2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInputView)];
    [self.view addGestureRecognizer:tap];
}

-(void) dismissInputView {
    [self.view endEditing:true];
}


// *************** API Methods ***************

-(void) getGCardData: (NSString *)fromDate andToDate: (NSString *)toDate withSalesRepName: (NSString *)name completionHandler: (nullable void (^)(void)) completion {
    
    NSDictionary *headers = @{ @"content-type": @"application/json"};
    NSDictionary *parameters = @{ @"p_user_id": @"9811676725",
                                  @"p_from_date": fromDate,
                                  @"p_to_date": toDate,
                                  @"p_dlr_sales_rep_name": name};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://greatplus.com/api_services/gcard_api.php"]
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
                                                        [gCardArray removeAllObjects];
                                                        for (int i = 0; i < [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] count]; i++) {
                                                            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                                                            [dict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"PRODUCT_SPECIFICATION"] forKey:@"productSpecs"];
                                                            [dict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"LENGTH"] forKey:@"length"];
                                                            [dict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"BREDTH"] forKey:@"breadth"];
                                                            [dict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"COUNT(1)"] forKey:@"count"];
                                                            [dict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"THICK"] forKey:@"thickness"];
                                                            [dict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"DLR_SALES_REP_NAME"] forKey:@"salesRepName"];
                                                            [gCardArray addObject:dict];
                                                        }
                                                        completion();
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
