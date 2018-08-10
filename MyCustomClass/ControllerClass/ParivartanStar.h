//
//  ParivartanStar.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParivartanCell.h"
#import "PassbookModel.h"

@interface ParivartanStar : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *openingLbl;
@property (weak, nonatomic) IBOutlet UILabel *closingLbl;
@property (weak, nonatomic) IBOutlet UILabel *creditLbl;
@property (weak, nonatomic) IBOutlet UILabel *debitLbl;

@property (weak, nonatomic) IBOutlet UITableView *parivartanTable;
@end
