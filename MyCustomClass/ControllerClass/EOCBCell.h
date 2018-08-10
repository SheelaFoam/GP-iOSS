//
//  EOCBCell.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EOCBCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *transDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *transDescLbl;
@property (weak, nonatomic) IBOutlet UILabel *crLbl;
@property (weak, nonatomic) IBOutlet UILabel *drLbl;

@property (weak, nonatomic) IBOutlet UILabel *noDataLbl;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end
