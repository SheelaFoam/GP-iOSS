//
//  MTSCell.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 03/05/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTSCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shadowLbl;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UILabel *modeLbl;
@property (weak, nonatomic) IBOutlet UILabel *lengthLbl;
@property (weak, nonatomic) IBOutlet UILabel *breadthLbl;
@property (weak, nonatomic) IBOutlet UILabel *thickLbl;
@property (weak, nonatomic) IBOutlet UILabel *colorLbl;
@property (weak, nonatomic) IBOutlet UILabel *pcsLbl;

@end
