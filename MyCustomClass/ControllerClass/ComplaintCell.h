//
//  ComplaintCell.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 12/06/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *compDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *cityLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *mobileLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *productLbl;
@property (weak, nonatomic) IBOutlet UILabel *billLbl;
@property (weak, nonatomic) IBOutlet UILabel *dealerLbl;
@property (weak, nonatomic) IBOutlet UILabel *problemLbl;
@property (weak, nonatomic) IBOutlet UILabel *pendingLbl;
@property (weak, nonatomic) IBOutlet UILabel *complaintID;

@property (weak, nonatomic) IBOutlet UIButton *addDetailButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end
