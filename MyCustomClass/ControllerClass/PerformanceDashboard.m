//
//  PerformanceDashboard.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "PerformanceDashboard.h"

@interface PerformanceDashboard() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    
    NSString *selectedParentID;
}

@end

@implementation PerformanceDashboard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDashboardData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [PerformanceDashboardModel sharedModel].parentDataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_performanceDashboardCollectionView.frame.size.width*0.35, _performanceDashboardCollectionView.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 125, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DashboardCell" forIndexPath:indexPath];
    
    [[cell.mainView layer] setCornerRadius:5.0];
    [cell.nameLbl setText:[PerformanceDashboardModel sharedModel].parentDataArray[indexPath.row][@"name"]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgView setImageWithURL:[PerformanceDashboardModel sharedModel].parentDataArray[indexPath.row][@"image"] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    });
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedParentID = [PerformanceDashboardModel sharedModel].parentDataArray[indexPath.row][@"id"];
    [self performSegueWithIdentifier:@"toDashboardOptions" sender:self];
}

-(void) getDashboardData {
    
    NSDictionary *headers = @{@"cache-control": @"no-cache"};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://greatplus.com/warranty_log_api/performance_dashboard_api.php"]
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
                                                        
                                                        [PerformanceDashboardModel sharedModel].response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                        
                                                        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                                                        
                                                        for (int i = 0; i < [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"] count]; i++) {
                                                            
                                                            if ([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"link"] isEqualToString:@""]) {
                                                                
                                                                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                                                                [tempDict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"name"] forKey:@"name"];
                                                                [tempDict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"image"] forKey:@"image"];
                                                                [tempDict setValue:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"data"][i][@"id"] forKey:@"id"];
                                                                [tempArray addObject:tempDict];
                                                            }
                                                        }
                                                        [PerformanceDashboardModel sharedModel].parentDataArray = tempArray;
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [_performanceDashboardCollectionView reloadData];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDashboardOptions"]) {    
        DashboardOptions *dest = [segue destinationViewController];
        dest.idStr = selectedParentID;
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
