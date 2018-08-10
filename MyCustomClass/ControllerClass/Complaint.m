//
//  Complaint.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 07/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "Complaint.h"
#import "ComplaintCell.h"
#import "historyModel.h"
#import "SVProgressHUD.h"
#import "MailClassViewController.h"
#import "GreatPlusSharedHeader.h"
#import "ComplaintInfo.h"
#import "Add.h"

@interface Complaint()<UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *responseArray;
    NSMutableArray *compID;
    NSMutableArray *mobileNo;
    NSMutableArray *name;
    
    NSArray *sortedArray;
    
    NSMutableDictionary *object;
    
    NSInteger index;
    
    NSString *typeSelected;
    NSMutableString *remarks;
    
    NSMutableDictionary *parameters;
    
    NSMutableArray *complaintData;
    
    NSMutableArray *photoArray;
    NSMutableArray *docArray;
    
    NSMutableArray *photoNameArray;
    NSMutableArray *docNameArray;
    
    NSMutableArray *photoPathArray;
    NSMutableArray *docPathArray;
}

@end

@implementation Complaint

- (void)viewDidLoad {
    [super viewDidLoad];
    
    responseArray = [[NSMutableArray alloc] init];
    compID = [[NSMutableArray alloc] init];
    sortedArray = [[NSArray alloc] init];
    mobileNo = [[NSMutableArray alloc] init];
    name = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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
    return responseArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 365;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"ComplaintCell";
    
    ComplaintCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ComplaintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.complaintID setText:[NSString stringWithFormat:@"No. %@", sortedArray[indexPath.row][@"compID"]]];
    [cell.compDateLbl setText:sortedArray[indexPath.row][@"compDate"]];
    [cell.cityLbl setText:sortedArray[indexPath.row][@"city"]];
    [cell.nameLbl setText:sortedArray[indexPath.row][@"name"]];
    [cell.mobileLbl setText:sortedArray[indexPath.row][@"mobile"]];
    [cell.addressLbl setText:sortedArray[indexPath.row][@"address"]];
    [cell.productLbl setText:sortedArray[indexPath.row][@"product"]];
    [cell.billLbl setText:sortedArray[indexPath.row][@"bill"]];
    [cell.dealerLbl setText:sortedArray[indexPath.row][@"dealer"]];
    [cell.problemLbl setText:sortedArray[indexPath.row][@"problem"]];
    [cell.pendingLbl setText:sortedArray[indexPath.row][@"pending"]];
    
    cell.moreButton.tag = indexPath.row;
    [cell.moreButton addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.addDetailButton.tag = indexPath.row;
    [cell.addDetailButton addTarget:self action:@selector(addDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (IBAction)search:(id)sender {
    
    if ([_searchTextField.text isEqualToString:@""]) {
        [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Please enter complaint number." delegate:nil tag:0];
    } else {
        if ([compID containsObject:_searchTextField.text]) {
            [_complaintListTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:[compID indexOfObject:_searchTextField.text] inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:true];
        } else if ([mobileNo containsObject:_searchTextField.text]) {
            [_complaintListTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:[mobileNo indexOfObject:_searchTextField.text] inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:true];
        } else if ([name containsObject:_searchTextField.text]) {
            [_complaintListTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:[name indexOfObject:_searchTextField.text] inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:true];
        } else {
            [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"Complaint not found" delegate:nil tag:0];
        }
    }
}


- (IBAction)addDetails:(id)sender {
    
    UIButton *pressedButton = (UIButton *)sender;
    
    index = pressedButton.tag;
    
    [self performSegueWithIdentifier:@"toAdd" sender:self];
}

- (IBAction)more:(id)sender {
    
    UIButton *pressedButton = (UIButton *)sender;
    
    index = pressedButton.tag;
    
    [self performSegueWithIdentifier:@"toComplaintInfo" sender:self];
}



- (IBAction)goToPreUsage:(id)sender {
    
    [self performSegueWithIdentifier:@"toPreUsage" sender:self];
}

- (IBAction)goToPostUsage:(id)sender {
    
    [self performSegueWithIdentifier:@"toPostUsage" sender:self];
}

- (IBAction)uploadPendingData:(id)sender {
    
    [self checkForPendingData];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"toComplaintInfo"]) {
        
        ComplaintInfo *dest = [segue destinationViewController];
        
        dest.self.response = responseArray;
        dest.self.index = index;
    } else if ([[segue identifier] isEqualToString:@"toAdd"]) {
        
        Add *dest = [segue destinationViewController];
        dest.complaintID = responseArray[index][@"compID"];
        dest.self.index = index;
    }
}


//************ API Methods ************

-(void) getComplaintList: (NSString *)uid completionHandler: (void (^)(BOOL updateStatus)) completion {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://125.19.46.252/ws/complaint_agentAPI.php?MOBILE=%@", uid]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                                                        if (![[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"] isKindOfClass:[NSNull class]]) {
                                                            for (int i = 0; i < [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"] count]; i++) {
                                                                object = [[NSMutableDictionary alloc] init];
                                                                [compID addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"COMP_ID"]];
                                                                [mobileNo addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"MOBILE"]];
                                                                [mobileNo addObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"DEALER_NAME"]];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"COMP_ID"] forKey:@"compID"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"ENTRYDATE"] forKey:@"compDate"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"CITY"] forKey:@"city"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"CUST_NAME"] forKey:@"name"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"MOBILE"] forKey:@"mobile"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"ADDRESS1"] forKey:@"address"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"PRODUCT_DISPLAY_NAME"] forKey:@"product"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"PUR_DATE"] forKey:@"bill"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"DEALER_NAME"] forKey:@"dealer"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"COMPLAIN_TYPE_NAME"] forKey:@"problem"];
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"track"][i][@"PENDING_SINCE"] forKey:@"pending"];
                                                                if (![responseArray containsObject:object]) {
                                                                    [responseArray addObject:object];
                                                                }
                                                            }
                                                            completion(true);
                                                        } else {
                                                            completion(false);
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [SVProgressHUD dismiss];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

-(void) uploadFile: (NSMutableDictionary *)parameters withFileName: (NSString *)fileName andPath:(NSString *)filePath completionHandler: (void (^)(void))completion{
    
    NSString *uploadURL = @"http://125.19.46.252/multipartForm.php";
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:uploadURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file[]" fileName:fileName mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          NSLog(@"%@", response);
                          NSLog(@"%@", responseObject);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                      completion();
                  }];
    
    [uploadTask resume];
}

-(void) sendData: (NSString *)urlStr {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [SVProgressHUD dismiss];
                                                            [MailClassViewController toastWithMessage:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] AndObj:self.view];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

//************ Custom Methods ************

-(void) initialSetup {
    
    [[_preUsageBtn layer] setCornerRadius:5.0];
    [[_postUsageBtn layer] setCornerRadius:5.0];
    [[_searchBtn layer] setBorderColor:UIColor.blackColor.CGColor];
    [[_searchBtn layer] setBorderWidth:1.5];
    [SVProgressHUD show];
//    @"9811960505"
    [self getComplaintList:[historyModel sharedhistoryModel].mobileNo completionHandler:^(BOOL updateStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if (updateStatus) {
            NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"PUR_DATE" ascending:true];
            NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
            sortedArray = [responseArray sortedArrayUsingDescriptors:sortDescriptors];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.complaintListTable reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MailClassViewController showAlertViewWithTitle:GreatPlusTitle message:@"No data found." delegate:nil tag:0];
            });
        }
    }];
}

-(NSString *) encodeURL: (NSString *)str {
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF32StringEncoding];
}

-(NSString *) createImageString {
    
    NSMutableString *imgStr;
    imgStr = [[NSMutableString alloc] init];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObjectsFromArray:photoNameArray];
    [tempArray addObjectsFromArray:docNameArray];
    for (int i = 0; i < tempArray.count; i++) {
        if ([imgStr isKindOfClass:[NSNull class]] || [imgStr isEqualToString:@""]) {
            [imgStr appendString:[NSString stringWithFormat:@"%@", tempArray[i]]];
        } else {
            [imgStr appendString:[NSString stringWithFormat:@"***%@", tempArray[i]]];
        }
    }
    return imgStr;
}

-(NSString *) createGETURL: (NSString *)mobileNo withcomplaintID: (NSString *)compID andImgStr: (NSString *)imgStr withRemarks: (NSString *)remarks andType: (NSString *)type {
    
    return [NSString stringWithFormat:@"http://125.19.46.252/ws/ComplaintVisitReport.php?MOBILE=%@&ID=%@&IMAGE=%@&REMARK=%@&p_gen_ungen=%@", mobileNo, compID, imgStr, remarks, type];
}

-(void) checkForPendingData {
    
    if ([[UserDefaultStorage getRemainingData] count] > 0) {
        complaintData = [UserDefaultStorage getRemainingData];
        for (int i = 0; i < complaintData.count; i++) {
            [photoArray addObjectsFromArray:complaintData[i][@"photos"]];
            [photoNameArray addObjectsFromArray:complaintData[i][@"photoNames"]];
            [photoPathArray addObjectsFromArray:complaintData[i][@"photoPaths"]];
            
            [docArray addObjectsFromArray:complaintData[i][@"docs"]];
            [docNameArray addObjectsFromArray:complaintData[i][@"docNames"]];
            [docPathArray addObjectsFromArray:complaintData[i][@"docPaths"]];
            
            remarks = complaintData[i][@"remarks"];
            if ([complaintData[i][@"type"] isEqualToString:@"genuine"]) {
                typeSelected = @"genuine";
            } else {
                typeSelected = @"in-genuine";
            }
            
            if ([MailClassViewController isNetworkConnected]) {
                for (int i = 0; i < photoArray.count; i++) {
                    
                    [parameters setValue:UIImageJPEGRepresentation(photoArray[i], 0.3) forKey:@"file[]"];
                    [self uploadFile:parameters withFileName:photoNameArray[i] andPath:photoPathArray[i] completionHandler:^{
                    }];
                }
                
                for (int i = 0 ; i < docArray.count; i++) {
                    
                    [parameters setValue:UIImageJPEGRepresentation(docArray[i], 0.3) forKey:@"file[]"];
                    [self uploadFile:parameters withFileName:docNameArray[i] andPath:docPathArray[i] completionHandler:^{
                        if (i == docArray.count - 1) {
                            [self sendData:[self createGETURL:[historyModel sharedhistoryModel].mobileNo withcomplaintID:complaintData[i][@"compID"] andImgStr:[self createImageString] withRemarks:[self encodeURL:remarks] andType:[self encodeURL:typeSelected]]];
                        }
                    }];
                }
                [MailClassViewController toastWithMessage:@"Pending files have been uploaded." AndObj:self.view];
            }
        }
    } else {
        [MailClassViewController toastWithMessage:@"No pending uploads." AndObj:self.view];
    }
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

//************ Back Action ************

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
