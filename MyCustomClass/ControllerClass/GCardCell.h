//
//  GCardCell.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 07/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *salesRepLbl;
@property (weak, nonatomic) IBOutlet UILabel *specsLbl;
@property (weak, nonatomic) IBOutlet UILabel *lengthLbl;
@property (weak, nonatomic) IBOutlet UILabel *breadthLbl;
@property (weak, nonatomic) IBOutlet UILabel *thicknessLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@end
