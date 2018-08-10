//
//  PerformanceDashboard.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 30/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardCell.h"
#import "PerformanceDashboardModel.h"
#import "DashboardOptions.h"
#import "UIImageView+WebCache.h"

@interface PerformanceDashboard : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *performanceDashboardCollectionView;
@end
