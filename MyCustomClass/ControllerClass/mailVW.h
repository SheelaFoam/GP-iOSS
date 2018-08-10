//
//  mailVW.h
//  Sheela Foam
//
//  Created by Apple on 18/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mailVW : UIView<UITableViewDelegate,UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UITableView *commonTable;
@property (weak, nonatomic) IBOutlet UITableView *mailTable;
- (IBAction)mailDetail:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mailDetail;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@end
