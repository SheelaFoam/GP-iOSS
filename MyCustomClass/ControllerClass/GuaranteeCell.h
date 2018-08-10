//
//  GuaranteeCell.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 23/04/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuaranteeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *serialNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *msgLbl;
@property (weak, nonatomic) IBOutlet UILabel *giftMsgLbl;

@end
