//
//  moreAppVC.h
//  Sheela Foam
//
//  Created by Apple on 18/01/17.
//  Copyright © 2017 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moreAppVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *moreAppCollection;

@end
