//
//  Complaint.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 07/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Complaint : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *preUsageBtn;
@property (weak, nonatomic) IBOutlet UIButton *postUsageBtn;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet UITableView *complaintListTable;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@end
