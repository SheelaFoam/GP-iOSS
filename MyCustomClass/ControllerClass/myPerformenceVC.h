//
//  myPerformenceVC.h
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPerformanceCell.h"

@interface myPerformenceVC : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myPerformenceTable;
@property(assign,nonatomic) CGRect tablefream;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@end
