//
//  DashboardOptions.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardOptionCell.h"
#import "PerformanceDashboardModel.h"
#import "UIImageView+WebCache.h"
#import "PerformanceWebview.h"

@interface DashboardOptions : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *dashboardCollectionView;
@property (strong, nonatomic) NSString *idStr;
@property NSInteger index;

@end
