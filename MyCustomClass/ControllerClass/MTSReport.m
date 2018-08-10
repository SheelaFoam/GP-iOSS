//
//  MTSReport.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 03/05/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "MTSReport.h"
#import "MTSCell.h"
#import "historyModel.h"
#import "SVProgressHUD.h"
#import "CCDropDownMenu.h"
#import "ManaDropDownMenu.h"
#import "MailClassViewController.h"
#import "HomeViewController.h"
#import "UserDefaultStorage.h"

@interface MTSReport()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CCDropDownMenuDelegate> {
    
    NSMutableArray *responseArray;
    NSMutableDictionary *object;
    NSMutableDictionary *searchObj;
    NSMutableArray *searchArray;
    NSMutableDictionary *filterObj;
    NSMutableArray *filterArray;
    
    NSMutableArray *tableDataSource;
}

@property (nonatomic, strong) ManaDropDownMenu *dropDown;

@end

@implementation MTSReport

- (void)viewDidLoad {
    [super viewDidLoad];
    
    responseArray = [[NSMutableArray alloc] init];
    searchObj = [[NSMutableDictionary alloc] init];
    searchArray = [[NSMutableArray alloc] init];
    tableDataSource = [[NSMutableArray alloc] init];
    filterArray = [[NSMutableArray alloc] init];
    
    [self getMTSData:[UserDefaultStorage getDealerID] completionHandler:^{
        if (responseArray.count == 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MailClassViewController showAlertViewWithTitle:@"GreatPlus" message:@"No data." delegate:nil tag:0];
                [SVProgressHUD dismiss];
            });
        } else {
            [tableDataSource addObjectsFromArray:responseArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_mtsTableView reloadData];
                [SVProgressHUD dismiss];
            });
        }
    }];
    
//    _dropDown = [[SyuDropDownMenu alloc] initWithNavigationBar:self.navigationController.navigationBar useNavigationController:true];
    CGFloat yCoordinate = [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height;
    _dropDown = [[ManaDropDownMenu alloc] initWithFrame:CGRectMake(0, yCoordinate, self.view.frame.size.width, 50) title:@"Filter"];
    _dropDown.delegate = self;
    _dropDown.numberOfRows = 3;
    _dropDown.textOfRows = @[@"All", @"In Stock", @"Out of Stock"];
    _dropDown.indicator = [UIImage imageNamed:@"arrow.png"];
    _dropDown.colorOfRows = @[UIColor.whiteColor, UIColor.whiteColor, UIColor.whiteColor];
    _dropDown.resilient = true;
    [self.view addSubview:_dropDown];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [SVProgressHUD show];
}

- (void)dropDownMenu:(CCDropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSInteger)index {
    
    [SVProgressHUD show];
    
    if (index == 0) {
        
        if (filterArray.count > 0) {
            [filterArray removeAllObjects];
        }
        [tableDataSource removeAllObjects];
        [tableDataSource addObjectsFromArray:responseArray];
        
    } else if (index == 1) {
        
        if (filterArray.count > 0) {
            [filterArray removeAllObjects];
        }
        [tableDataSource removeAllObjects];
        for (int i=0; i<responseArray.count; i++) {
            if ([responseArray[i][@"stock"] integerValue] > 0) {
                [filterArray addObject:responseArray[i]];
            }
        }
        [tableDataSource addObjectsFromArray:filterArray];
    } else {
        
        if (filterArray.count == 0) {
            [filterArray removeAllObjects];
        }
        [tableDataSource removeAllObjects];
        for (int i=0; i<responseArray.count; i++) {
            if ([responseArray[i][@"stock"] integerValue] == 0) {
                [filterArray addObject:responseArray[i]];
            }
        }
        [tableDataSource addObjectsFromArray:filterArray];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mtsTableView reloadData];
        [SVProgressHUD dismiss];
    });
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [SVProgressHUD show];
    [searchBar resignFirstResponder];
    
    if (searchArray.count > 0) {
        [searchArray removeAllObjects];
    }
    
    if ([searchBar.text isEqualToString:@""]) {
        
        [tableDataSource addObjectsFromArray:responseArray];
    } else {
        
        for (int i=0; i<responseArray.count; i++) {
            NSString *tempStr1 = [responseArray[i][@"length"] lowercaseString];
            NSString *tempStr2 = [responseArray[i][@"breadth"] lowercaseString];
            NSString *tempStr3 = [responseArray[i][@"thick"] lowercaseString];
            NSString *tempStr4 = [responseArray[i][@"color"] lowercaseString];
            NSString *tempStr5 = [responseArray[i][@"stock"] lowercaseString];
            NSString *tempStr6 = [responseArray[i][@"model"] lowercaseString];
            
            searchBar.text = [searchBar.text lowercaseString];
            
            if ([tempStr1 containsString:searchBar.text] || [tempStr2 containsString:searchBar.text] || [tempStr3 containsString:searchBar.text] || [tempStr4 containsString:searchBar.text] || [tempStr5 containsString:searchBar.text] || [tempStr6 containsString:searchBar.text]) {
                
                [searchArray addObject:responseArray[i]];
                [tableDataSource removeAllObjects];
                [tableDataSource addObjectsFromArray:searchArray];
            }
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mtsTableView reloadData];
        [SVProgressHUD dismiss];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reusableIdentifier = @"MTSCell";
    MTSCell *cell = [tableView dequeueReusableCellWithIdentifier: reusableIdentifier];
    
    if (cell == nil) {
        cell = [[MTSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
    }
    if (indexPath.row%2 == 0) {
        [cell.shadowLbl.layer setShadowColor: [UIColor colorWithRed:0.0/255.0 green:106.0/255.0 blue:194.0/255.0 alpha:1.0].CGColor];
    } else {
        [cell.shadowLbl.layer setShadowColor:[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor];
    }
    
    [cell.shadowLbl.layer setShadowRadius:5.0];
    [cell.shadowLbl.layer setShadowOpacity:1.0];
    [cell.shadowLbl.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
    [cell.shadowLbl.layer setMasksToBounds:false];
    [cell.mainView.layer setCornerRadius:5.0];
    
    [cell.modeLbl setText:tableDataSource[indexPath.row][@"model"]];
    [cell.lengthLbl setText:tableDataSource[indexPath.row][@"length"]];
    [cell.breadthLbl setText:tableDataSource[indexPath.row][@"breadth"]];
    [cell.thickLbl setText:tableDataSource[indexPath.row][@"thick"]];
    if ([tableDataSource[indexPath.row][@"color"] isEqualToString:@""]) {
        [cell.colorLbl setText:@"N.A."];
    } else {
        [cell.colorLbl setText:tableDataSource[indexPath.row][@"color"]];
    }
    [cell.pcsLbl setText:tableDataSource[indexPath.row][@"stock"]];
    
    return cell;
}

-(void)getMTSData: (NSString *)dealerID completionHandler: (void (^)(void)) completion {
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"669e9948-3c91-51f1-0c06-acd29b24b5c0" };
    NSDictionary *parameters = @{ @"p_dealer_id": dealerID };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://greatplus.com/warranty_log_api/mts_report_api.php"]
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
                                                        
                                                        for (int i=0; i<[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] count]; i++) {
                                                            object = [[NSMutableDictionary alloc] init];
                                                            [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"LENGTH"] forKey:@"length"];
                                                            [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"BREDTH"] forKey:@"breadth"];
                                                            [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"THICK"] forKey:@"thick"];
                                                            
                                                            if ([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"COLOR"] isKindOfClass:[NSNull class]]) {
                                                                [object setValue:@"" forKey:@"color"];
                                                            } else {
                                                                [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"COLOR"] forKey:@"color"];
                                                            }
                                                            
                                                            [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"PRODUCT_DISPLAY_NAME"] forKey:@"model"];
                                                            [object setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][i][@"CURR_STOCK"] forKey:@"stock"];
                                                            if (![responseArray containsObject:object]) {
                                                                [responseArray addObject:object];
                                                            }
                                                        }
                                                        completion();
                                                    }
                                                }];
    [dataTask resume];
}

- (IBAction)back:(id)sender {
    
    HomeViewController *home = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:true];
}

@end
