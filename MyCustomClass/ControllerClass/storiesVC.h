//
//  storiesVC.h
//  Sheela Foam
//
//  Created by Apple on 22/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface storiesVC : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIImageView *storiesImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UIButton *storiesBtn;
@property (weak, nonatomic) IBOutlet UITableView *sankalpStoriesTable;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIButton *sankalpBtn;
@end
