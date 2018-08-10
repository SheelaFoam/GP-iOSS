//
//  MyPerformanceCell.h
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPerformanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalTargetLab;
@property (weak, nonatomic) IBOutlet UILabel *percentlab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *colourLab;
@property (weak, nonatomic) IBOutlet UISlider *slidercolour;
@property (weak, nonatomic) IBOutlet UILabel *sapraterLab;
@property (weak, nonatomic) IBOutlet UILabel *weightLab;
@property (weak, nonatomic) IBOutlet UILabel *wALabel;

@end
