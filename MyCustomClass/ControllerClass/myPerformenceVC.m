//
//  myPerformenceVC.m
//  Sheela Foam
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 Supraits. All rights reserved.
//

#import "myPerformenceVC.h"
#import "historyModel.h"

@implementation myPerformenceVC
{
    MyPerformanceCell*MyPerformance;
    CGSize labelHeight;

}
-(id)initWithFrame:(CGRect)frame
{ self = [super initWithFrame:frame];
    
    if (self)
    { UIView *ViewName = [[[NSBundle mainBundle] loadNibNamed:@"myPerformenceVC" owner:self options:nil] objectAtIndex:0];
        CGRect frame= ViewName.frame; frame.size.width=self.frame.size.width; frame.size.height=self.frame.size.height; ViewName.frame=frame; [self addSubview:ViewName];
        self.myPerformenceTable.delegate=self;
        self.myPerformenceTable.dataSource=self;
        
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(13,self.headerView.frame.size.height-5,[UIScreen mainScreen].bounds.size.width-60,1)];
        fromLabel.backgroundColor=[UIColor colorWithRed:12.0/255.0f green:76.0/255.0f blue:164.0/255.0f alpha:1.0];
        [self.headerView addSubview:fromLabel];
        
        self.myPerformenceTable.tableHeaderView=self.headerView;
        NSLog(@"mail4");

        
    }
    
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    labelHeight = [self heigtForCellwithString:[NSString stringWithFormat:@"%@ %@/PERC",[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"KPI"],[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"WEIGHTAGE"]] withFont:[UIFont systemFontOfSize:14]];
    return labelHeight.height+MyPerformance.weightLab.frame.size.height+MyPerformance.slidercolour.frame.size.height+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"MyPerformanceCell";
    MyPerformance = (MyPerformanceCell *)[self.myPerformenceTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (MyPerformance == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"MyPerformanceCell" owner:self options:nil];
        MyPerformance = [cellArray objectAtIndex:0];
        self.myPerformenceTable.allowsSelection = NO;
    }
    MyPerformance.detailLab.text=[NSString stringWithFormat:@"%@",[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"KPI"]];
    MyPerformance.weightLab.text=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"WEIGHTAGE"];
         MyPerformance.detailLab.frame=CGRectMake(65,2,MyPerformance.detailLab.frame.size.width,labelHeight.height);
     [MyPerformance.detailLab sizeToFit];
    
    if ([[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"TARGET"] isEqual:[NSNull null]])
    {
        MyPerformance.weightLab.text=@"0";

    }
    else
    {
        NSString*weightStr=[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"TARGET"];
        MyPerformance.weightLab.text=weightStr;
    }

    
    NSString*ackPercent=[NSString stringWithFormat:@"%@%@",[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"ACH_DETAIL"],@"%"];

    MyPerformance.percentlab.text=ackPercent;

  


    
    if([[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"ACH_DETAIL"] intValue] <=25)
    {
   
        MyPerformance.slidercolour.value=[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"ACH_DETAIL"] intValue];
        MyPerformance.slidercolour.minimumTrackTintColor = [UIColor redColor];

        
    }
    else if([[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"ACH_DETAIL"] intValue] <=50)
    {
        MyPerformance.slidercolour.value=[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"ACH_DETAIL"] intValue];
        MyPerformance.slidercolour.minimumTrackTintColor=[UIColor yellowColor];

    }
    else if ([[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"ACH_DETAIL"] intValue] <=100)
    {
        MyPerformance.slidercolour.value=[[[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] objectAtIndex:indexPath.row]objectForKey:@"ACH_DETAIL"] intValue];
        MyPerformance.slidercolour.minimumTrackTintColor=[UIColor colorWithRed:30/255.0f green:175/255.0f blue:180/255.0f alpha:1.0f];

    }
    MyPerformance.weightLab.frame=CGRectMake(65,MyPerformance.detailLab.frame.origin.y+MyPerformance.detailLab.frame.size.height+5,MyPerformance.weightLab.frame.size.width,MyPerformance.weightLab.frame.size.height+10);
    
//    MyPerformance.slidercolour.frame=CGRectMake(59,MyPerformance.frame.size.height-MyPerformance.slidercolour.frame.size.height-26,MyPerformance.slidercolour.frame.size.width,MyPerformance.slidercolour.frame.size.height);
//    MyPerformance.percentlab.frame=CGRectMake(18,MyPerformance.slidercolour.frame.origin.y,MyPerformance.slidercolour.frame.size.width,MyPerformance.slidercolour.frame.size.height);
//    
//     MyPerformance.sapraterLab.frame=CGRectMake(15,MyPerformance.percentlab.frame.origin.y+MyPerformance.percentlab.frame.size.height,MyPerformance.sapraterLab.frame.size.width,MyPerformance.sapraterLab.frame.size.height);
    
    if (indexPath.row==[[[historyModel sharedhistoryModel].homeDataDicStep2 objectForKey:@"my_performance"] count]-1)
    {
        MyPerformance.sapraterLab.hidden=YES;
    }

    
    
        return  MyPerformance;
    
    
    
}
-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font{
    CGSize constraint = CGSizeMake(256,2000); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return rect.size;
}



@end
