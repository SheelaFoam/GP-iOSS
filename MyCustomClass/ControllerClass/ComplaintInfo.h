//
//  ComplaintInfo.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 15/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintInfo : UIViewController


@property (strong, nonatomic) NSMutableArray *response;
@property NSInteger index;

@property (weak, nonatomic) IBOutlet UITableView *complaintInfoTable;

@property (weak, nonatomic) IBOutlet UITextField *complaintIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerMobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *keywordTextField;
@end
