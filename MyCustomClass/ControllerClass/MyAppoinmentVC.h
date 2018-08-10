//
//  MyAppoinmentVC.h
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAppoinmentVC : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myAppoinmentTable;
@property (strong, nonatomic) IBOutlet UIView *headerTitle;

@end
