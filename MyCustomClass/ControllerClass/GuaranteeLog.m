//
//  GuaranteeLog.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 23/04/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "GuaranteeLog.h"
#import "GuaranteeCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "historyModel.h"
#import "MailClassViewController.h"
#import "UserDefaultStorage.h"

@interface GuaranteeLog()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    NSMutableArray *responseObj;
    NSMutableArray *searchObj;
    
    BOOL showSearchData;
}

@end

@implementation GuaranteeLog

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController].navigationBar setBarTintColor:[UIColor colorWithRed:65.0/255.0 green:0.0/255.0 blue:170.0/255.0 alpha:1.0]];
    responseObj = [[NSMutableArray alloc] init];
    [self guaranteeLogData:[historyModel sharedhistoryModel].uid];
    
    showSearchData = false;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (showSearchData) {
        return searchObj.count;
    } else {
        return [responseObj count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  165.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GuaranteeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuaranteeCell"];
    
    if (cell == nil) {
        cell = [[GuaranteeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GuaranteeCell"];
    }
    
    if (showSearchData) {
        
        if ([searchObj count] != 0) {
            [cell.dateLbl setText:[NSString stringWithFormat:@"%@", [searchObj[indexPath.row] objectForKey:@"DATETIME"]]];
            [cell.serialNoLbl setText:[NSString stringWithFormat:@"%@", [searchObj[indexPath.row] objectForKey:@"SERIAL_NUMBER"]]];
            NSString *msg = [searchObj[indexPath.row] objectForKey:@"RECEIVE_MESSAGE"];
            if (![msg isKindOfClass:[NSNull class]]) {
                [cell.msgLbl setText:[NSString stringWithFormat:@"%@", [responseObj[indexPath.row] objectForKey:@"RECEIVE_MESSAGE"]]];
            } else {
                [cell.msgLbl setText:@"No message."];
            }
            
            NSString *temp = [responseObj[indexPath.row] objectForKey:@"GIFT_MESSAGE"];
            if (![temp isKindOfClass:[NSNull class]]) {
                [cell.giftMsgLbl setText:[NSString stringWithFormat:@"%@", [responseObj[indexPath.row] objectForKey:@"GIFT_MESSAGE"]]];
            } else {
                [cell.giftMsgLbl setText:@"No gift message."];
            }
        }
    } else {
        if ([responseObj count] != 0) {
            
            
            [cell.dateLbl setText:[NSString stringWithFormat:@"%@", [responseObj[indexPath.row] objectForKey:@"DATETIME"]]];
            [cell.serialNoLbl setText:[NSString stringWithFormat:@"%@", [responseObj[indexPath.row] objectForKey:@"SERIAL_NUMBER"]]];
            NSString *msg = [responseObj[indexPath.row] objectForKey:@"RECEIVE_MESSAGE"];
            if (![msg isKindOfClass:[NSNull class]]) {
                [cell.msgLbl setText:[NSString stringWithFormat:@"%@", [responseObj[indexPath.row] objectForKey:@"RECEIVE_MESSAGE"]]];
            } else {
                [cell.msgLbl setText:@"No message."];
            }
            
            NSString *temp = [responseObj[indexPath.row] objectForKey:@"GIFT_MESSAGE"];
            if (![temp isKindOfClass:[NSNull class]]) {
                [cell.giftMsgLbl setText:[NSString stringWithFormat:@"%@", [responseObj[indexPath.row] objectForKey:@"GIFT_MESSAGE"]]];
            } else {
                [cell.giftMsgLbl setText:@"No gift message."];
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    
    
    [self getSearchResults:searchBar.text andUserID:[historyModel sharedhistoryModel].uid completionHandler:^{
        
        if (searchObj.count == 0) {
            showSearchData = false;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_guaranteeTable reloadData];
                [SVProgressHUD dismiss];
                [MailClassViewController showAlertViewWithTitle:@"GreatPlus" message:@"No log data for this serial number." delegate:nil tag:0];
            });
        } else {
            showSearchData = true;
            [_guaranteeTable reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_guaranteeTable reloadData];
                [SVProgressHUD dismiss];
            });
        }
    }];
}

-(void) getSearchResults: (NSString *)serialNo andUserID: (NSString *)uid completionHandler: (void (^)(void))completion {
    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"eece9aa7-1241-94d0-c835-8dcc539e558b" };
    NSArray *parameters = @[ @{ @"name": @"p_user_id", @"value": uid},
                             @{ @"name": @"serial_number", @"value": serialNo}];
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
    
    NSError *error;
    NSMutableString *body = [NSMutableString string];
    for (NSDictionary *param in parameters) {
        [body appendFormat:@"--%@\r\n", boundary];
        if (param[@"fileName"]) {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", param[@"name"], param[@"fileName"]];
            [body appendFormat:@"Content-Type: %@\r\n\r\n", param[@"contentType"]];
            [body appendFormat:@"%@", [NSString stringWithContentsOfFile:param[@"fileName"] encoding:NSUTF8StringEncoding error:&error]];
            if (error) {
                NSLog(@"%@", error);
            }
        } else {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
            [body appendFormat:@"%@", param[@"value"]];
        }
    }
    [body appendFormat:@"\r\n--%@--\r\n", boundary];
    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greatplus.com/warranty_log_api/searchBySerial.php"]
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
                                                        searchObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                        showSearchData = true;
                                                        completion();
                                                    }
                                                }];
    [dataTask resume];
}

-(void) guaranteeLogData: (NSString *)userID {
    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"7e77dd17-195e-1999-544d-7f3f2180a1fd" };
    NSArray *parameters = @[ @{ @"name": @"p_user_id", @"value": userID} ];
    
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
    
    NSError *error;
    NSMutableString *body = [NSMutableString string];
    for (NSDictionary *param in parameters) {
        [body appendFormat:@"--%@\r\n", boundary];
        if (param[@"fileName"]) {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", param[@"name"], param[@"fileName"]];
            [body appendFormat:@"Content-Type: %@\r\n\r\n", param[@"contentType"]];
            [body appendFormat:@"%@", [NSString stringWithContentsOfFile:param[@"fileName"] encoding:NSUTF8StringEncoding error:&error]];
            if (error) {
                NSLog(@"%@", error);
            }
        } else {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
            [body appendFormat:@"%@", param[@"value"]];
        }
    }
    [body appendFormat:@"\r\n--%@--\r\n", boundary];
    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greatplus.com/warranty_log_api/prevSevenDays.php"]
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
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [_guaranteeTable reloadData];
                                                            [SVProgressHUD dismiss];
                                                        });
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

@end
