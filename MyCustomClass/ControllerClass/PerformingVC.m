//
//  PerformingVC.m
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "PerformingVC.h"
#import "historyModel.h"

@implementation PerformingVC
{
   // PerformingCell*PerformingCoustomCell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{ self = [super initWithFrame:frame];
    
    if (self)
    { UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"PerformingVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        UILabel *blueSeparator = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerTitle.frame.size.height+self.headerTitle.frame.origin.y+5,[UIScreen mainScreen].bounds.size.width-60,1)];
        blueSeparator.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [self addSubview:blueSeparator];
        //
        if ([[historyModel sharedhistoryModel].opUserType.lowercaseString isEqualToString:@"employee"]) {
            [self ytd:self.ytdBtn];
        }
        NSLog(@"mail5");


    }
    
    return self;
}



- (IBAction)thisYrar:(id)sender {
    
    self.thisWeekBtn.backgroundColor = [UIColor colorWithRed:30/255.0f green:175/255.0f blue:180/255.0f alpha:1.0f];
    self.ytdBtn.backgroundColor=[UIColor colorWithRed:226/255.0f green:234/255.0f blue:244/255.0f alpha:1.0f];
    
    

        self.tpAchiveLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"TP_WEEK_ACH"];
            self.tpTargetLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"TP_WEEK_TARGET"];
            self.rcvAchiveLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"RCV_WEEK_ACH"];
            self.rcvTargetLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"RCV_WEEK_TARGET"];
    
    
}
- (IBAction)ytd:(id)sender {
    
    self.ytdBtn.backgroundColor = [UIColor colorWithRed:30/255.0f green:175/255.0f blue:180/255.0f alpha:1.0f];
    self.thisWeekBtn.backgroundColor=[UIColor colorWithRed:226/255.0f green:234/255.0f blue:244/255.0f alpha:1.0f];
    if ([[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] count]) {
        self.tpAchiveLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"TP_YTD_ACH"];
        self.tpTargetLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"TP_YTD_TARGET"];
        self.rcvAchiveLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"RCV_YTD_ACH"];
        self.rcvTargetLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"company_performance"] objectAtIndex:0] objectForKey:@"RCV_YTD_TARGET"];
    }
    
    
    
//    cellAttachment.titlelab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"0"];
//    cellAttachment.tpAchive.text=[[info objectAtIndex:indexPath.row] objectForKey:@"RCV_WEEK_ACH"];
//    cellAttachment.tpTarget.text=[[info objectAtIndex:indexPath.row] objectForKey:@"RCV_WEEK_TARGET"];
//    cellAttachment.RCVAchive.text=[[info objectAtIndex:indexPath.row] objectForKey:@"RCV_YTD_ACH"];
//    cellAttachment.RCVTarget.text=[[info objectAtIndex:indexPath.row] objectForKey:@"RCV_YTD_TARGET"];
    

}
@end
