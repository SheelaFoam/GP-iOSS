//
//  DashboardOptions.m
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import "DashboardOptions.h"

@interface DashboardOptions() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    
    NSString *selectedUrl;
}

@end

@implementation DashboardOptions

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [PerformanceDashboardModel sharedModel].childDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DashboardOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DashboardOptionCell" forIndexPath:indexPath];
    
    [[cell.mainView layer] setCornerRadius:5.0];
    
    [cell.nameLbl setText:[PerformanceDashboardModel sharedModel].childDataArray[indexPath.row][@"name"]];
    [cell.imgView setImageWithURL:[PerformanceDashboardModel sharedModel].childDataArray[indexPath.row][@"image"] placeholderImage:[UIImage imageNamed:@"dummyImg"]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_dashboardCollectionView.frame.size.width*0.3, _dashboardCollectionView.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 5, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedUrl = [PerformanceDashboardModel sharedModel].childDataArray[indexPath.row][@"link"];
    [self performSegueWithIdentifier:@"toDashboardWebview" sender:self];
}

-(void) createDataSource {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [[PerformanceDashboardModel sharedModel].response[@"data"] count]; i++) {
        
        if ([[PerformanceDashboardModel sharedModel].response[@"data"][i][@"parentId"] isEqualToString:_idStr]) {
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
            
            [tempDict setValue:[PerformanceDashboardModel sharedModel].response[@"data"][i][@"name"] forKey:@"name"];
            [tempDict setValue:[PerformanceDashboardModel sharedModel].response[@"data"][i][@"image"] forKey:@"image"];
            [tempDict setValue:[PerformanceDashboardModel sharedModel].response[@"data"][i][@"link"] forKey:@"link"];
            [tempArray addObject:tempDict];
        }
    }
    [PerformanceDashboardModel sharedModel].childDataArray = tempArray;
    [_dashboardCollectionView reloadData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDashboardWebview"]) {
        PerformanceWebview *dest = segue.destinationViewController;
        dest.imageStr = selectedUrl;
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
