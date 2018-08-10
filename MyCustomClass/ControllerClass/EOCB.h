//
//  EOCB.h
//  Sheela Foam
//
//  Created by Akshay Yerneni on 26/07/18.
//  Copyright © 2018 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EOCBCell.h"
#import "PassbookModel.h"

@interface EOCB : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *openingLbl;
@property (weak, nonatomic) IBOutlet UILabel *closingLbl;
@property (weak, nonatomic) IBOutlet UILabel *creditLbl;
@property (weak, nonatomic) IBOutlet UILabel *debitLbl;

@property (weak, nonatomic) IBOutlet UITableView *eocbTable;

@end
