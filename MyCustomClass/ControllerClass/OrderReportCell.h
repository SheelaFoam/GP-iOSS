//
//  OrderReportCell.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 21/05/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReportCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *productLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailsLbl;
@end
