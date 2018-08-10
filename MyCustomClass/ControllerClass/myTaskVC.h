//
//  myTaskVC.h
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableViewCell.h"
#import "MyWebServiceHelper.h"
#import "MyWebServiceHelper.h"


@interface myTaskVC : UIView<UITableViewDelegate,UITableViewDataSource,WebServiceResponseProtocal>

@property (weak, nonatomic) IBOutlet UIButton *approveRequest;
@property (weak, nonatomic) IBOutlet UIButton *seeAll;
@property (weak, nonatomic) IBOutlet UIImageView *myTaskfooter;
@property (weak, nonatomic) IBOutlet UILabel *approveRequestLab;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *mytaskTable;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@end
