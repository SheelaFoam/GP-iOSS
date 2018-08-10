//
//  OpinionVC.h
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebServiceHelper.h"

@interface OpinionVC : UIView<UITableViewDelegate,UITableViewDataSource,WebServiceResponseProtocal>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITableView *pooleTable;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property(strong,nonatomic)NSString*poolValuSet;
@end
