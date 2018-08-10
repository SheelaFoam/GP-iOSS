//
//  latestEventDetail.h
//  Sheela Foam
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface latestEventDetail : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITableView *latestEventTable;
@property (weak, nonatomic) IBOutlet UILabel *eventLab;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *dataAvailabilityLAb;

- (IBAction)backBtn:(id)sender;
- (IBAction)profileBtn:(id)sender;

@end
