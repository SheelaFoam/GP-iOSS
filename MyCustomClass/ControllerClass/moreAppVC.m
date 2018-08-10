//
//  moreAppVC.m
//  Sheela Foam
//
//  Created by Apple on 18/01/17.
//  Copyright © 2017 Supraits. All rights reserved.
//

#import "moreAppVC.h"
#import "MoreAppCell.h"

@interface moreAppVC ()
{
    MoreAppCell*cell;


}

@end

@implementation moreAppVC

- (void)viewDidLoad {
    self.moreAppCollection.delegate=self;
    self.moreAppCollection.dataSource=self;
       [self.moreAppCollection registerNib:[UINib nibWithNibName:@"MoreAppCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSUInteger collectionRow = 10;
  
    
    return collectionRow;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(80,80);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";

    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

       return cell;
    
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
    
    
    
    
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
